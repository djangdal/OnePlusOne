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

@end
