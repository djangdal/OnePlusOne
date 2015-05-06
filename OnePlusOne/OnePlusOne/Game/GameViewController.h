//
//  GameViewController.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-24.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "GridCellView.h"
#import "StatusView.h"

@interface GameViewController : UIViewController <GridCellViewDelegate, StatusViewDelegate>

@property (nonatomic, readonly) BOOL gameOngoing;

- (void)startNewGame;

@end
