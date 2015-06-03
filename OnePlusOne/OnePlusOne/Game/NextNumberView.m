//
//  NextNumberView.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-16.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "NextNumberView.h"

@interface NextNumberView ()

@property (nonatomic) UILabel *previewLabel;

@end

@implementation NextNumberView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor defaultDarkColor].CGColor;
        self.layer.borderWidth = 4;
        
        self.previewLabel = [UILabel new];
        self.previewLabel.font = [UIFont fontWithName:@"Helvetica" size:28];
        self.previewLabel.textAlignment = NSTextAlignmentCenter;
        self.previewLabel.textColor = [UIColor blackColor];
        [self addSubview:self.previewLabel];
    }
    return self;
}

- (void)layoutSubviews {
    self.previewLabel.frame = self.bounds;
}

- (void)previewNextNumber:(int)number {
    self.previewLabel.text = [NSString stringWithFormat:@"%i", number];
}

- (void)stopPreviewing {
    self.previewLabel.text = @"";
}

@end
