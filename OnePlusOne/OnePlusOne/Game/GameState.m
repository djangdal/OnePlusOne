//
//  GameState.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-06-02.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "GameState.h"

@interface GameState ()

@property (nonatomic) NSArray *grid;
@property (nonatomic) NSMutableArray *numberProbabilities;
@property (nonatomic) NSMutableArray *previousProbabilities;
@property (nonatomic) NSMutableArray *previousScores;

@end

@implementation GameState

- (instancetype)initWithGridSize:(int)size delegate:(id<GridCellViewDelegate>)delegate {
    self = [super init];
    if (self) {
        self.numberProbabilities = [[NSMutableArray alloc] initWithObjects:@0, nil];
        
        NSMutableArray *outer = [NSMutableArray new];
        for (int x = 0; x<size; x++) {
            NSMutableArray *inner = [NSMutableArray new];
            for (int y = 0; y<size; y++) {
                [inner addObject:[[GridCellView alloc] initWithX:x withY:y delegate:delegate]];
            }
            [outer addObject:inner];
        }
        self.grid = [[NSArray alloc] initWithArray:outer];
        self.previousProbabilities = [NSMutableArray new];
        self.previousScores = [NSMutableArray new];
    }
    return self;
}

- (void)resetGameState {
    self.totalScore = 0;
    self.tilesPlaced = 0;
    self.gameOngoing = YES;
    self.lastPlacedValue = 0;
    self.lastPlacedTile = nil;
    [self.numberProbabilities removeAllObjects];
    [self.numberProbabilities addObject:@0];
    [self.previousProbabilities removeAllObjects];
    [self.previousScores removeAllObjects];
    for (NSArray *inner in self.grid) {
        for (GridCellView *cell in inner) {
            [cell resetCell];
        }
    }
}

- (BOOL)isGameOver {
    for (NSArray *inner in self.grid) {
        for (GridCellView *cell in inner) {
            if (cell.cellValue == 0) {
                return false;
            }
        }
    }
    return true;
}

int _totalScore = 0;
- (void)setTotalScore:(int)totalScore {
    _totalScore = totalScore;
    [self.previousScores addObject:@(totalScore)];
}

- (GridCellView *)firstEmptyCell {
    if (self.lastPlacedTile) {
        int x = self.lastPlacedTile.x;
        int y = self.lastPlacedTile.y;
        long int max = self.grid.count;
        
        if (y+1 < max) {
            GridCellView *cell = [[self.grid objectAtIndex:x] objectAtIndex:y+1];
            if (cell.cellValue == 0) return cell;
        }
        
        if (x+1 < max && y+1 < max) {
            GridCellView *cell = [[self.grid objectAtIndex:x+1] objectAtIndex:y+1];
            if (cell.cellValue == 0) return cell;
        }
        
        if (x-1 >= 0 && y+1 < max) {
            GridCellView *cell = [[self.grid objectAtIndex:x-1] objectAtIndex:y+1];
            if (cell.cellValue == 0) return cell;
        }
        if (x-1 >= 0) {
            GridCellView *cell = [[self.grid objectAtIndex:x-1] objectAtIndex:y];
            if (cell.cellValue == 0) return cell;
        }
        
        if (x+1 < max) {
            GridCellView *cell = [[self.grid objectAtIndex:x+1] objectAtIndex:y];
            if (cell.cellValue == 0) return cell;
        }
        
        if (y-1 >= 0) {
            GridCellView *cell = [[self.grid objectAtIndex:x] objectAtIndex:y-1];
            if (cell.cellValue == 0) return cell;
        }
        
        if (x-1 >= 0 && y-1 >= 0) {
            GridCellView *cell = [[self.grid objectAtIndex:x-1] objectAtIndex:y-1];
            if (cell.cellValue == 0) return cell;
        }
        
        if (x+1 < max && y-1 >= 0) {
            GridCellView *cell = [[self.grid objectAtIndex:x+1] objectAtIndex:y-1];
            if (cell.cellValue == 0) return cell;
        }
    }
    
    for (NSArray *inner in self.grid) {
        for (GridCellView *cell in inner) {
            if (cell.cellValue == 0) {
                return cell;
            }
        }
    }
    return nil;
}

- (int)generateNewNumber {
    int highestNumber = [self highestCellValue];
    if (highestNumber > [self.numberProbabilities count]) {
        [self.numberProbabilities addObject:@0];
    }
    
    __block int highestIdx = 0;
    __block int highestProbability = INT32_MIN;
    __block int sum = 0;
    [self.numberProbabilities enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop) {
        int addNumber = arc4random_uniform(highestNumber-(int)idx + 1)+1;
        sum +=addNumber;
        int newNumber = number.intValue + addNumber;
        if (newNumber > highestProbability) {
            highestIdx = (int)idx;
            highestProbability = newNumber;
        }
        [self.numberProbabilities replaceObjectAtIndex:idx withObject:@(number.intValue + addNumber)];
    }];
    
    NSNumber *n = [self.numberProbabilities objectAtIndex:highestIdx];
    int reducedNumber = n.intValue - sum;
    [self.numberProbabilities replaceObjectAtIndex:highestIdx withObject:[NSNumber numberWithInt:reducedNumber]];
    
    return highestIdx+1;
}

- (int)highestCellValue {
    int highest = 0;
    for (int x = 0; x<self.grid.count; x++) {
        NSArray *inner = [self.grid objectAtIndex:x];
        for (int y = 0; y<inner.count; y++) {
            GridCellView *gridCellView = [inner objectAtIndex:y];
            if (gridCellView.cellValue > highest) {
                highest = gridCellView.cellValue;
            }
        }
    }
    return highest;
}

- (void)storeCurrentCellValues {
    for (NSArray *inner in self.grid) {
        for (GridCellView *cell in inner) {
            [cell storeCurrentValue];
        }
    }
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray:self.numberProbabilities];
    [self.previousProbabilities addObject:tmp];
}

- (void)undo {
    if(self.previousProbabilities.count > 0) {
        for (NSArray *inner in self.grid) {
            for (GridCellView *cell in inner) {
                [cell undo];
            }
        }
        self.numberProbabilities = [self.previousProbabilities lastObject];
        [self.previousProbabilities removeLastObject];
        int n = [[self.previousScores lastObject] intValue];
        self.totalScore = n;
        [self.previousScores removeLastObject];
    }
}

@end
