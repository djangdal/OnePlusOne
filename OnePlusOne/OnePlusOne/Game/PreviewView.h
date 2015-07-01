//
//  PreviewView.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-06-27.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewView : UIView

- (instancetype)initWithNumbers:(NSArray *)numbers;
- (void)newNumbers:(NSArray *)numbers;
- (void)newNumber:(int)number;
- (void)replaceNumber:(int)number;
- (int)nextNumber;

@end
