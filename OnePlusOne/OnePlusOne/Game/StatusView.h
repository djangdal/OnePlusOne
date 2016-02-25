//
//  StatusView.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-27.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusView : UIView

- (void)updateTargetScoreForLevel:(int)level;
- (void)updateScoreTo:(int)score;

@end
