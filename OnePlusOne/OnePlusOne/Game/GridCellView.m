//
//  GridCellView.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-25.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "GridCellView.h"
#import "GameData.h"

@interface GridCellView ()

@property (nonatomic) int x;
@property (nonatomic) int y;
@property (nonatomic) int cellValue;
@property (nonatomic) UILabel *valueLabel;
@property (nonatomic) UILabel *previewLabel;

@property (nonatomic, weak) id<GridCellViewDelegate> delegate;

@end

CGFloat const kMergeDuration = 0.3f;
CGFloat const kPreviewDuration = 0.5f;

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
        self.valueLabel.textColor = [UIColor blackColor];
        
        self.previewLabel = [UILabel new];
        self.previewLabel.font = [UIFont fontWithName:@"Helvetica" size:28];
        self.previewLabel.textAlignment = NSTextAlignmentCenter;
        self.previewLabel.textColor = [UIColor defaultDarkColor];
        
        [self addSubview:self.valueLabel];
        [self addSubview:self.previewLabel];
    }
    return self;
}

- (void)layoutSubviews {
    self.valueLabel.frame = self.bounds;
    self.previewLabel.frame = self.bounds;
}

- (void)updateValueLabel {
    self.valueLabel.hidden = self.cellValue==0 ? YES : NO;
    self.valueLabel.text = [NSString stringWithFormat:@"%i", self.cellValue];
}

- (void)startCellWithNumber:(int)number {
    self.cellValue = number;
    [self updateValueLabel];
}

- (void)resetCell {
    self.cellValue = 0;
    [self updateValueLabel];
}

- (void)mergeWithNeighbours:(NSArray *)neighbours {
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
    } else {
        [self.delegate finishedMergingCells];
    }
}

- (void)mergeToCell:(GridCellView *)gridCellView {
    CGRect originalFrame = self.frame;
    self.cellValue = 0;
    [UIView animateWithDuration:kMergeDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = gridCellView.frame;
    } completion:^(BOOL finished) {
        self.frame = originalFrame;
        [self updateValueLabel];
    }];
}

- (void)previewNumber:(int)number {
//    if ([GameData sharedGameData].level < 4) {
//        return;
//    }
    self.previewLabel.alpha = 0.3;
    self.previewLabel.text = [NSString stringWithFormat:@"%i", number];
    [UIView animateWithDuration:kPreviewDuration delay:0 options:(UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat) animations:^{
        self.previewLabel.alpha = 1.0f;
    } completion:nil];
}

- (void)stopPreviewNumber {
    [UIView animateWithDuration:0.1 animations:^{
        self.previewLabel.alpha = 0.0f;
    }];
}

@end
