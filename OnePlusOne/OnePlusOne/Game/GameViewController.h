//
//  GameViewController.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-24.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "GridCellView.h"

@interface GameViewController : UIViewController <GridCellViewDelegate>

//@property (nonatomic) NSArray *missions;

- (void)startNewGame;

@end
