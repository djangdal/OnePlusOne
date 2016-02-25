//
//  GameState.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-06-02.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GridCellView.h"

@interface GameState : NSObject

- (instancetype)initWithGridSize:(int)size delegate:(id<GridCellViewDelegate>)delegate;

@property (nonatomic) int totalScore;
@property (nonatomic) int tilesPlaced;
@property (nonatomic) int lastPlacedValue;
@property (nonatomic) BOOL gameOngoing;
@property (nonatomic) BOOL isGameOver;

@property (nonatomic) GridCellView *lastPlacedTile;
@property (nonatomic, readonly) NSArray *grid;

- (GridCellView *)firstEmptyCell;
- (void)resetGameState;
- (int)highestCellValue;
- (int)generateNewNumber;
- (void)undo;
- (void)storeCurrentCellValues;

@end
