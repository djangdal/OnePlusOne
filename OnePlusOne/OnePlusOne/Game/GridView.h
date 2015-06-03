//
//  GridView.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-24.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GridCellView, GameState;

@interface GridView : UIView

- (void)setUpForGameState:(GameState *)gameState;
- (GridCellView *)gridCellViewForTouchPoint:(CGPoint)touchPoint;
- (NSArray *)neighboursForCell:(GridCellView *)gridCellView;

@end
