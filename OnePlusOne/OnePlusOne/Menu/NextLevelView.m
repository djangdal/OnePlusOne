//
//  NextLevelView.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-07.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "NextLevelView.h"

@interface NextLevelView ()

@property (nonatomic) UILabel *levelLabel;
@property (nonatomic) UILabel *descriptionLabel;

@end

@implementation NextLevelView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor defaultDarkColor];
        
        self.levelLabel = [UILabel new];
        self.levelLabel.textColor = [UIColor defaultLightColor];
        [self addSubview:self.levelLabel];
        
        self.descriptionLabel = [UILabel new];
        self.descriptionLabel.textColor = [UIColor defaultLightColor];
        [self addSubview:self.descriptionLabel];
    }
    return self;
}

- (void)layoutSubviews {
    CGSize size = self.frame.size;
    self.levelLabel.font = [UIFont fontWithName:@"helvetica" size:size.width*0.08f];
    self.descriptionLabel.font = [UIFont fontWithName:@"helvetica" size:size.width*0.06f];
    
    static CGFloat levelTop = 0.06;
    static CGFloat levelLeft = 0.05;
    [self.levelLabel sizeToFit];
    self.levelLabel.frame = SKRectSetX(self.levelLabel.frame, self.frame.size.width * levelLeft);
    self.levelLabel.frame = SKRectSetY(self.levelLabel.frame, self.frame.size.height * levelTop);
    
    static CGFloat descriptionBottom = 0.14;
    static CGFloat descriptionLeft = 0.05;
    static CGFloat descriptionRight = 0.05;
    [self.descriptionLabel sizeToFit];
    self.descriptionLabel.frame = SKRectSetBottom(self.descriptionLabel.frame, size.height - size.height*descriptionBottom, NO);
    self.descriptionLabel.frame = SKRectSetX(self.descriptionLabel.frame, self.frame.size.width * descriptionLeft);
    self.descriptionLabel.frame = SKRectSetRight(self.descriptionLabel.frame, self.frame.size.width - self.frame.size.width*descriptionRight, YES);
}

- (void)showNextLeveL:(int)nextLevel {
    self.levelLabel.text = [NSString stringWithFormat:@"Level %i", nextLevel];
    if (nextLevel == 2) {
        self.descriptionLabel.text = @"Unlock the 3x3 grid";
    }
    
    if (nextLevel == 3) {
        self.descriptionLabel.text = @"Unlock the number 2 tile";
    }
    
    if (nextLevel == 4) {
        self.descriptionLabel.text = @"Preview of the next number";
    }
}

@end
