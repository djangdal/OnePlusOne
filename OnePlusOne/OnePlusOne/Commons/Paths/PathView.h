//
//  PathView.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-07.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PathView : UIView

- (instancetype)initWithPath:(UIBezierPath *)path color:(UIColor *)color;

@property (nonatomic) UIBezierPath *path;

@end
