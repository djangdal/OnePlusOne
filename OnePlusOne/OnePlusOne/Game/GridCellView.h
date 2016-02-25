//
//  GridCellView.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-25.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GridCellViewDelegate <NSObject>

- (void)finishedMergingCells;
- (void)mergedCellsWithScore:(int)score;

@end

@interface GridCellView : UIView

- (instancetype)initWithX:(int)x withY:(int)y delegate:(id<GridCellViewDelegate>)delegate;

@property (nonatomic, readonly) int x;
@property (nonatomic, readonly) int y;
@property (nonatomic, readonly) int cellValue;

- (void)resetCell;
- (void)startCellWithNumber:(int)number;
- (void)mergeToCell:(GridCellView *)gridCellView;
- (void)mergeWithNeighbours:(NSArray *)neighbours;
- (void)storeCurrentValue;
- (void)undo;

//- (void)previewNumber:(int)number;
//- (void)stopPreviewNumber;

@end
