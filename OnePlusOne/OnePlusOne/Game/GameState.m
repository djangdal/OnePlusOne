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
//@property (nonatomic) GridCellView *lastPlacedTile;

@end

@implementation GameState

- (instancetype)initWithGridSize:(int)size delegate:(id<GridCellViewDelegate>)delegate {
    self = [super init];
    if (self) {
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

@end
