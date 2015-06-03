//
//  ControlsView.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-06-03.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "ControlsView.h"
#import "PathButton.h"
#import "GameData.h"
#import "NextNumberView.h"
#import "UIBezierPath+Paths.h"

@interface ControlsView ()

@property (nonatomic) UILabel *infoLabel;
@property (nonatomic) PathButton *addButton;
@property (nonatomic) PathButton *undoButton;
@property (nonatomic) PathButton *storageButton;
@property (nonatomic) NextNumberView *nextNumberView;

@property (nonatomic, weak) id<ControlsViewDelegate> delegate;

@end

@implementation ControlsView

- (instancetype)initWithDelegate:(id<ControlsViewDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        
        self.nextNumberView = [NextNumberView new];
        
        self.storageButton = [[PathButton alloc] initWithPath:[UIBezierPath storagePath]
                                              foregroundColor:[UIColor defaultDarkColor]
                                              backgroundColor:[UIColor whiteColor]];
        [self.storageButton addTarget:self action:@selector(storageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.undoButton = [[PathButton alloc] initWithPath:[UIBezierPath undoPath]
                                           foregroundColor:[UIColor defaultDarkColor]
                                           backgroundColor:[UIColor whiteColor]];
        [self.undoButton addTarget:self action:@selector(undoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.addButton = [[PathButton alloc] initWithPath:[UIBezierPath addPath]
                                          foregroundColor:[UIColor defaultDarkColor]
                                          backgroundColor:[UIColor whiteColor]];
        [self.addButton addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.infoLabel = [UILabel new];
        self.infoLabel.textColor = [UIColor defaultDarkColor];
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
        self.infoLabel.numberOfLines = 0;
        self.infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        [self addSubview:self.infoLabel];
        [self addSubview:self.storageButton];
        [self addSubview:self.undoButton];
        [self addSubview:self.addButton];
        [self addSubview:self.nextNumberView];
    }
    return self;
}

- (void)previewNextNumber:(int)number {
    [self.nextNumberView previewNextNumber:number];
    [self setNeedsLayout];
}

- (void)stopPreviewing {
    [self.nextNumberView stopPreviewing];
}

- (void)layoutSubviews {
    CGSize size = self.frame.size;
    self.infoLabel.frame = self.bounds;
    
    static CGFloat actionsTop = 0.06;
    static CGFloat actionsLeft = 0.00;
    static CGFloat actionsRight = 0.00;
    static CGFloat actionsSize = 0.15;
    CGFloat actionsSpacing = (size.width - size.width*actionsSize*4 - actionsLeft - actionsRight)/5;
    
    self.nextNumberView.frame = SKRectSetX(self.nextNumberView.frame, size.width*actionsLeft+actionsSpacing);
    self.nextNumberView.frame = SKRectSetY(self.nextNumberView.frame, size.height*actionsTop);
    self.nextNumberView.frame = SKRectSetWidth(self.nextNumberView.frame, size.width*actionsSize);
    self.nextNumberView.frame = SKRectSetHeight(self.nextNumberView.frame, size.width*actionsSize);
    
    self.storageButton.frame = SKRectSetX(self.storageButton.frame, CGRectGetMaxX(self.nextNumberView.frame) + actionsSpacing);
    self.storageButton.frame = SKRectSetY(self.storageButton.frame, size.height*actionsTop);
    self.storageButton.frame = SKRectSetWidth(self.storageButton.frame, size.width*actionsSize);
    self.storageButton.frame = SKRectSetHeight(self.storageButton.frame, size.width*actionsSize);
    
    self.undoButton.frame = SKRectSetWidth(self.undoButton.frame, size.width*actionsSize);
    self.undoButton.frame = SKRectSetHeight(self.undoButton.frame, size.width*actionsSize);
    self.undoButton.frame = SKRectSetY(self.undoButton.frame, size.height*actionsTop);
    self.undoButton.frame = SKRectSetX(self.undoButton.frame, CGRectGetMaxX(self.storageButton.frame) + actionsSpacing);
    
    self.addButton.frame = SKRectSetWidth(self.addButton.frame, size.width*actionsSize);
    self.addButton.frame = SKRectSetHeight(self.addButton.frame, size.width*actionsSize);
    self.addButton.frame = SKRectSetRight(self.addButton.frame, size.width - size.width*actionsRight - actionsSpacing, NO);
    self.addButton.frame = SKRectSetY(self.addButton.frame, size.height*actionsTop);
    
}

- (void)displayForLevel:(int)level {
    self.nextNumberView.hidden = YES;
    self.storageButton.hidden = YES;
    self.undoButton.hidden = YES;
    self.addButton.hidden = YES;
    if (level == 1) {
        self.infoLabel.text = @"This is the first level. Complete your missions to get to the next. In this one, you need to get 12 points. Click on an empty cell to place a number";
    } else if (level == 2) {
        self.infoLabel.text = @"This is the second level. You have a bigger board and two missions. Good luck!";
    } else if (level == 3) {
        self.infoLabel.text = @"It is now possible to place a 2 tile, it comes random though. But for the next level you can see the upcoming tile";
    }
}

- (void)displayGameOver {
    self.infoLabel.text = @"Sorry, you did not finish all the missions. Restart and try again!";
    self.infoLabel.hidden = NO;
    self.nextNumberView.hidden = YES;
    self.storageButton.hidden = YES;
    self.undoButton.hidden = YES;
    self.addButton.hidden = YES;
}

- (void)displayLevelCompleted {
    self.infoLabel.hidden = NO;
    self.infoLabel.text = @"Congratulazions! \nYou finished all missions and can move on to the next level";
    self.nextNumberView.hidden = YES;
    self.storageButton.hidden = YES;
    self.undoButton.hidden = YES;
    self.addButton.hidden = YES;
}

- (void)storageButtonPressed:(id)sender {
    [self.delegate storageButtonPressed];
}

- (void)undoButtonPressed:(id)sender {
    [self.delegate undoButtonPressed];
}

- (void)addButtonPressed:(id)sender {
    [self.delegate addButtonPressed];
}

@end
