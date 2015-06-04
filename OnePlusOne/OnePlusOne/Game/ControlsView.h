//
//  ControlsView.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-06-03.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ControlsViewDelegate <NSObject>

- (void)storageButtonPressed;
- (void)undoButtonPressed;
- (void)addButtonPressed;

@end

@interface ControlsView : UIView

- (instancetype)initWithDelegate:(id<ControlsViewDelegate>)delegate;
//- (void)previewNextNumber:(int)number;
//- (void)stopPreviewing;
- (void)displayGameOver;
- (void)displayLevelCompleted;
- (void)displayForLevel:(int)level;

@end
