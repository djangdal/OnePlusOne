//
//  PathView.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-07.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "PathView.h"
#import "UIBezierPath+Helpers.h"

@interface PathView ()

@property (nonatomic) UIColor *color;

@end

@implementation PathView

- (instancetype)initWithPath:(UIBezierPath *)path color:(UIColor *)color {
    self = [super init];
    if (self) {
        self.path = path;
        self.color = color;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setPath:(UIBezierPath *)path {
    _path = path;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [self.color setFill];
    [[[self.path scaleToFitSize:rect.size] centerInRect:rect] fill];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

@end
