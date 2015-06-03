//
//  PathButton.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-07.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "PathButton.h"
#import "UIBezierPath+Helpers.h"

@interface PathButton ()

@property (nonatomic) UIBezierPath *path;
@property (nonatomic) UIColor *foregroundColor;

@end

@implementation PathButton

- (instancetype)initWithPath:(UIBezierPath *)path foregroundColor:(UIColor *)foregroundColor backgroundColor:(UIColor *)backgroundColor {
    self = [super init];
    if (self) {
        self.path = path;
        self.foregroundColor = foregroundColor;
        self.backgroundColor = backgroundColor;
    }
    
    return self;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [self.foregroundColor setFill];
    if (self.scale) {
        [[[[self.path scaleToFitSize:rect.size] scale:self.scale] centerInRect:rect] fill];
    } else {
        [[[self.path scaleToFitSize:rect.size] centerInRect:rect] fill];
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

@end
