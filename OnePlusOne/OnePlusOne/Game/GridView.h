//
//  GridView.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-24.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GridCellView;

@interface GridView : UIView

- (instancetype)initWithGrid:(NSArray *)grid;
- (GridCellView *)gridCellViewForTouchPoint:(CGPoint)touchPoint;
- (NSArray* )neighboursForCell:(GridCellView *)gridCellView;


@end
