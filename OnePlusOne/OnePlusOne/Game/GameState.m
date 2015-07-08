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
    }
    return self;
}

- (void)resetGameState {
    self.totalScore = 0;
    self.tilesPlaced = 0;
    self.gameOngoing = YES;
    self.lastPlacedValue = 0;
    self.lastPlacedTile = nil;
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
    
    NSLog(@"---------- new round---------");
    NSLog(@"array before %@", self.numberProbabilities);
    
    __block int highestIdx;
    __block int highestProbability = INT32_MIN;
    [self.numberProbabilities enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop) {
        int addNumber = arc4random_uniform(highestNumber-(int)idx + 1)+1;
        int newNumber = number.intValue + addNumber;
        if (newNumber > highestProbability) {
            highestIdx = (int)idx;
            highestProbability = newNumber;
        }
        [self.numberProbabilities replaceObjectAtIndex:idx withObject:@(number.intValue + addNumber)];
        NSLog(@"highest %i idx %lu generated %i",highestNumber,(unsigned long)idx,addNumber);
    }];
    NSLog(@"array after %@", self.numberProbabilities);
    
    NSNumber *n = [self.numberProbabilities objectAtIndex:highestIdx];
    int reducedNumber = n.intValue - highestNumber*1.5;
    NSLog(@"higestidx %lu reducedNumber %i", (unsigned long)highestIdx, reducedNumber);
    [self.numberProbabilities replaceObjectAtIndex:highestIdx withObject:[NSNumber numberWithInt:reducedNumber]];
    NSLog(@"array reduced %@", self.numberProbabilities);
    
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

@end
