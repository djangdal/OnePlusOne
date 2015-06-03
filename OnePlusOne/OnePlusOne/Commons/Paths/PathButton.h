//
//  PathButton.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-07.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PathButton : UIButton

- (instancetype)initWithPath:(UIBezierPath *)path foregroundColor:(UIColor *)foregroundColor backgroundColor:(UIColor *)backgroundColor;

@property (nonatomic) CGFloat scale;

@end
