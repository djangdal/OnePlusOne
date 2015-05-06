//
//  StatusView.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-27.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StatusViewDelegate <NSObject>
- (void)quitButtonPressed;
- (void)resetButtonPressed;
@end

@interface StatusView : UIView

- (instancetype)initWithDelegate:(id<StatusViewDelegate>)delegate;
- (void)updateScoreTo:(int)score;
- (void)showNextNumber:(int)number;

@end
