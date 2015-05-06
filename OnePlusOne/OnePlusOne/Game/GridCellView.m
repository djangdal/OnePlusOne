//
//  GridCellView.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-25.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "GridCellView.h"

@interface GridCellView ()

@property (nonatomic) int x;
@property (nonatomic) int y;
@property (nonatomic) int cellValue;
@property (nonatomic) UILabel *valueLabel;

@property (nonatomic, weak) id<GridCellViewDelegate> delegate;

@end

CGFloat const kMergeDuration = 0.3f;

@implementation GridCellView

- (instancetype)initWithX:(int)x withY:(int)y delegate:(id<GridCellViewDelegate>)delegate {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.x = x;
        self.y = y;
        self.delegate = delegate;
        self.backgroundColor = [UIColor clearColor];
        
        self.valueLabel = [UILabel new];
        self.valueLabel.font = [UIFont fontWithName:@"Helvetica" size:28];
        self.valueLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.valueLabel];
    }
    return self;
}

- (void)layoutSubviews{
    self.valueLabel.frame = self.bounds;
}

- (void)updateValueLabel{
    self.valueLabel.hidden = self.cellValue==0 ? YES : NO;
    self.valueLabel.text = [NSString stringWithFormat:@"%i", self.cellValue];
}

- (void)startCellWithNumber:(int)number {
    self.cellValue = number;
    [self updateValueLabel];
}

- (void)resetCell{
    self.cellValue = 0;
    [self updateValueLabel];
}

- (void)mergeWithNeighbours:(NSArray *)neighbours{
    int sum = 0;
    for (GridCellView *cell in neighbours) {
        if (cell.cellValue == self.cellValue) {
            sum += cell.cellValue;
            [cell mergeToCell:self];
        }
    }
    if (sum > 0) {
        [UIView animateWithDuration:kMergeDuration animations:^{
            self.valueLabel.alpha = 0.0f;
        }completion:^(BOOL finished){
            self.cellValue += sum;
            [self updateValueLabel];
            self.valueLabel.alpha = 1.0f;
            [self.delegate mergedCellsWithScore:sum];
            [self mergeWithNeighbours:neighbours];
        }];
    }
    else{
        [self.delegate finishedMergingCells];
    }
}

- (void)mergeToCell:(GridCellView *)gridCellView{
    CGRect originalFrame = self.frame;
    self.cellValue = 0;
    [UIView animateWithDuration:kMergeDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = gridCellView.frame;
    } completion:^(BOOL finished) {
        self.frame = originalFrame;
        [self updateValueLabel];
    }];
}

@end
