//
//  GameViewController.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-24.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "Mission.h"
#import "GridView.h"
#import "GameData.h"
#import "GameState.h"
#import "PathButton.h"
#import "StatusView.h"
#import "PreviewView.h"
#import "MissionsHandler.h"
#import "ConfirmationView.h"
#import "UIBezierPath+Paths.h"
#import "GameViewController.h"
#import "StoreViewController.h"
#import <iAd/iAd.h>

@interface GameViewController ()

@property (nonatomic) int currentLevel;
@property (nonatomic) BOOL levelFailed;
@property (nonatomic) BOOL allowTouch;

@property (nonatomic) UIButton *restartButton;
@property (nonatomic) UIButton *menuButton;

@property (nonatomic) GridView *gridView;
@property (nonatomic) GameState *gameState;
@property (nonatomic) StatusView *statusView;

@property (nonatomic) PathButton *undoButton;
@property (nonatomic) PreviewView *previewView;
@property (nonatomic) PathButton *storageButton;
@property (nonatomic) UILabel *storageLabel;

@property (nonatomic) ADBannerView *adView;

@property (nonatomic) NSMutableArray *previousStorages;
@property (nonatomic) NSMutableArray *previousScores;

@end

@implementation GameViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentLevel = 1;
        
        self.gameState = [[GameState alloc] initWithGridSize:2 delegate:self];
        self.gridView = [GridView new];
        [self.gridView setUpForGameState:self.gameState];
        self.statusView  = [StatusView new];
        
        self.restartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.restartButton.titleLabel.textColor = [UIColor whiteColor];
        self.restartButton.backgroundColor = [UIColor defaultDarkColor];
        [self.restartButton setTitle:@"Restart" forState:UIControlStateNormal];
        [self.restartButton addTarget:self action:@selector(restartButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.menuButton.titleLabel.textColor = [UIColor whiteColor];
        self.menuButton.backgroundColor = [UIColor defaultDarkColor];
        [self.menuButton setTitle:@"Menu" forState:UIControlStateNormal];
        [self.menuButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.storageButton = [[PathButton alloc] initWithPath:[UIBezierPath storagePath]
                                              foregroundColor:[UIColor defaultDarkColor]
                                              backgroundColor:[UIColor whiteColor]];
        [self.storageButton addTarget:self action:@selector(storageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.storageLabel = [UILabel new];
        self.storageLabel.textAlignment = NSTextAlignmentCenter;
        self.storageLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        
        self.undoButton = [[PathButton alloc] initWithPath:[UIBezierPath undoPath]
                                           foregroundColor:[UIColor defaultDarkColor]
                                           backgroundColor:[UIColor whiteColor]];
        [self.undoButton addTarget:self action:@selector(undoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.previewView = [[PreviewView alloc] initWithNumbers:@[@1 ,@1 ,@1]];
        
        self.previousStorages = [NSMutableArray new];
        self.previousScores = [NSMutableArray new];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor defaultLightColor];
    [self.view addSubview:self.gridView];
    [self.view addSubview:self.statusView];
    [self.view addSubview:self.restartButton];
    [self.view addSubview:self.menuButton];
    
    [self.view addSubview:self.undoButton];
    [self.view addSubview:self.previewView];
    [self.view addSubview:self.storageButton];
    [self.storageButton addSubview:self.storageLabel];
    
    [self layoutViews];
}

- (void)playLevel:(int)level {
    if (level != self.currentLevel) {
        self.currentLevel = level;
        
        self.gameState = [[GameState alloc] initWithGridSize:level+1 delegate:self];
        [self.gridView setUpForGameState:self.gameState];
        [self startNewGame];
    }
    [self.statusView updateTargetScoreForLevel:level];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!IsIphone4) {
        if (![GameData sharedGameData].fullGameUnlocked && self.adView == NULL) {
            self.adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
            [self.adView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            [self.view addSubview:self.adView];
        } else if([GameData sharedGameData].fullGameUnlocked && self.adView != NULL) {
            [self.adView removeFromSuperview];
            self.adView = NULL;
        }
    }

    if (!self.gameState.gameOngoing) {
        [self startNewGame];
    }
    [self layoutViews];
    [self.statusView updateScoreTo:self.gameState.totalScore];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.previewView playFadeAnimation];
}

- (void)layoutViews {
    CGSize size = self.view.frame.size;
    
    BOOL isAd = !IsIphone4 && ![GameData sharedGameData].fullGameUnlocked;
    
    if (isAd) {
        self.adView.frame = SKRectSetX(self.adView.frame, 0);
        self.adView.frame = SKRectSetY(self.adView.frame, 20);
    }
    
    CGFloat statusTop = IsIphone4 ? 0.045 : (isAd ? 0.04 : 0.08);
    static CGFloat statusLeft = 0.04;
    static CGFloat statusRight = 0.04;
    static CGFloat statusHeight = 0.07;
    self.statusView.frame = SKRectSetX(self.statusView.frame, size.width*statusLeft);
    self.statusView.frame = SKRectSetY(self.statusView.frame, CGRectGetMaxY(self.adView.frame) + size.height*statusTop);
    self.statusView.frame = SKRectSetRight(self.statusView.frame, size.width - size.width*statusRight, YES);
    self.statusView.frame = SKRectSetHeight(self.statusView.frame, size.height*statusHeight);
    
    CGFloat buttonsTop = IsIphone4 ? 0.03 : (isAd ? 0.02 : 0.05);
    static CGFloat buttonsLeft = 0.04;
    static CGFloat buttonsRight = 0.04;
    CGFloat buttonsHeight = isAd ? 0.05 : 0.06;
    static CGFloat buttonsWidth = 0.4;
    self.restartButton.frame = SKRectSetX(self.restartButton.frame, size.width*buttonsLeft);
    self.restartButton.frame = SKRectSetY(self.restartButton.frame, CGRectGetMaxY(self.statusView.frame) + size.height*buttonsTop);
    self.restartButton.frame = SKRectSetWidth(self.restartButton.frame, size.width*buttonsWidth);
    self.restartButton.frame = SKRectSetHeight(self.restartButton.frame, size.height*buttonsHeight);
    
    [self.menuButton setTitle:@"Menu" forState:UIControlStateNormal];
    self.menuButton.frame = SKRectSetWidth(self.menuButton.frame, size.width*buttonsWidth);
    self.menuButton.frame = SKRectSetHeight(self.menuButton.frame, size.height*buttonsHeight);
    self.menuButton.frame = SKRectSetRight(self.menuButton.frame, size.width - size.width*buttonsRight, NO);
    self.menuButton.frame = SKRectSetY(self.menuButton.frame, CGRectGetMaxY(self.statusView.frame) + size.height*buttonsTop);
    
    static CGFloat gridSize = 0.92;
    CGFloat gridMargin = (1-gridSize)/2;
    self.gridView.frame = SKRectSetWidth(self.gridView.frame, size.width*gridSize);
    self.gridView.frame = SKRectSetHeight(self.gridView.frame, size.width*gridSize);
    self.gridView.frame = SKRectSetX(self.gridView.frame, size.width*gridMargin);
    self.gridView.frame = SKRectSetBottom(self.gridView.frame, size.height - size.width*gridMargin, NO);
    
    CGFloat actionsBottom = IsIphone4 ? 0.04 : 0.05;
    static CGFloat actionsLeft = 0.07;
    static CGFloat actionsRight = 0.07;
    static CGFloat actionsSize = 0.13;
    CGFloat actionsSpacing = (size.width - size.width*actionsSize*4 - actionsLeft - actionsRight)/5;
    
    self.previewView.frame = SKRectSetX(self.previewView.frame, size.width*actionsLeft);
    self.previewView.frame = SKRectSetBottom(self.previewView.frame, CGRectGetMinY(self.gridView.frame) - size.height*actionsBottom, NO);
    self.previewView.frame = SKRectSetWidth(self.previewView.frame, size.width*actionsSize*3);
    self.previewView.frame = SKRectSetHeight(self.previewView.frame, size.width*actionsSize);
    
    self.storageButton.frame = SKRectSetX(self.storageButton.frame, CGRectGetMaxX(self.previewView.frame) + actionsSpacing);
    self.storageButton.frame = SKRectSetBottom(self.storageButton.frame, CGRectGetMinY(self.gridView.frame) - size.height*actionsBottom, NO);
    self.storageButton.frame = SKRectSetWidth(self.storageButton.frame, size.width*actionsSize);
    self.storageButton.frame = SKRectSetHeight(self.storageButton.frame, size.width*actionsSize);
    
    self.undoButton.frame = SKRectSetBottom(self.undoButton.frame, CGRectGetMinY(self.gridView.frame) - size.height*actionsBottom, NO);
    self.undoButton.frame = SKRectSetX(self.undoButton.frame, CGRectGetMaxX(self.storageButton.frame) + actionsSpacing);
    self.undoButton.frame = SKRectSetWidth(self.undoButton.frame, size.width*actionsSize);
    self.undoButton.frame = SKRectSetHeight(self.undoButton.frame, size.width*actionsSize);

    self.storageLabel.frame = self.storageButton.bounds;
}

- (void)startNewGame {
    [self.previousScores removeAllObjects];
    [self.previousStorages removeAllObjects];
    [self.gameState resetGameState];
    [self.previewView resetValues];
    self.storageLabel.text = @"";
    [self.previewView newNumbers:@[@1,@1,@1]];
    self.allowTouch = YES;
    self.levelFailed = NO;
    [self.statusView updateScoreTo:self.gameState.totalScore];
    [self layoutViews];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.allowTouch || !self.previewView.finishedAnimating) {
        return;
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self.gridView];
    if ([touch view] == self.gridView) {
        [self userSelectedCell:[self.gridView gridCellViewForTouchPoint:touchPoint]];
    }
}

- (void)userSelectedCell:(GridCellView *)gridCellView {
    if (gridCellView.cellValue == 0 && self.previewView.finishedAnimating) {
        [self.previousStorages addObject:@(NO)];
        [self.gameState storeCurrentCellValues];
        [self.previewView storeCurrentValues];
        self.allowTouch = NO;
        self.gameState.lastPlacedTile = gridCellView;
        self.gameState.lastPlacedValue = self.previewView.nextNumber;
        self.gameState.tilesPlaced++;
        self.gameState.totalScore += self.previewView.nextNumber;
        [gridCellView startCellWithNumber:self.previewView.nextNumber];
        [[GameData sharedGameData] newScore:self.gameState.totalScore];
        [self.statusView updateScoreTo:self.gameState.totalScore];
        NSArray *neighbours = [self.gridView neighboursForCell:gridCellView];
        [gridCellView mergeWithNeighbours:neighbours];
    }
}

- (void)generateNextNumber {
    [self.previewView newNumber:[self.gameState generateNewNumber]];
}

#pragma GridCellViewProtocoll
- (void)mergedCellsWithScore:(int)score {
    self.gameState.totalScore += score;
    [[GameData sharedGameData] newScore:self.gameState.totalScore];
    [self.statusView updateScoreTo:self.gameState.totalScore];
}

- (void)finishedMergingCells {
    if ([self.gameState isGameOver]) {
        self.levelFailed = YES;
        [ConfirmationView DisplayConfirmationView:@"Game Over"
                                          message:@"No more moves to make"
                                     confirmTitle:@"Restart"
                                    confirmAction:^void(){[self startNewGame];}];
        
        [self layoutViews];
    } else {
        if (self.currentLevel == 1 && ![GameData sharedGameData].level2Unlocked && self.gameState.totalScore >= [GameData sharedGameData].level2ScoreRequired) {
            [[GameData sharedGameData] unlockedLevel2];
            [ConfirmationView DisplayConfirmationView:@"Level completed!"
                                              message:@"Woho! You have finished level 1, you can now play level 2"
                                         confirmTitle:@"Play level 2"
                                        confirmAction:^void(){
                                            [self playLevel:2];
                                            [self layoutViews];
                                        }];
        
        } else if (self.currentLevel == 2 && ![GameData sharedGameData].level3Unlocked && self.gameState.totalScore >= [GameData sharedGameData].level3ScoreRequired) {
            [[GameData sharedGameData] unlockedLevel3];
            NSString *m = [GameData sharedGameData].fullGameUnlocked ? @"Woho! You have finished level 2, you can now play level 3" :
                                                                       @"You unlocked level 3, but you need the full game to play it :(";
            NSString *t = [GameData sharedGameData].fullGameUnlocked ? @"Play level 3" : @"Full Game info";
            [ConfirmationView DisplayConfirmationView:@"Level completed!"
                                              message:m
                                         confirmTitle:t
                                        confirmAction:^void(){
                                            if ([GameData sharedGameData].fullGameUnlocked) {
                                                [self playLevel:3];
                                                [self layoutViews];
                                            } else {
                                                [self presentViewController:[StoreViewController new] animated:YES completion:nil];
                                            }
                                        }];
        }
        [self generateNextNumber];
        self.allowTouch = YES;
        [self.previousScores addObject:[NSNumber numberWithInt:self.gameState.totalScore]];
        
    }
}
- (void)storageButtonPressed:(id)sender {
    if (!self.allowTouch || !self.previewView.finishedAnimating)
        return;
        
    if (self.storageLabel.text.length > 0) {
        int storageNumber = [self.storageLabel.text intValue];
        self.storageLabel.text = [NSString stringWithFormat:@"%i", self.previewView.nextNumber];
        [self.previewView replaceNumber:storageNumber];
        [self.previousStorages addObject:@(YES)];
    } else {
        self.storageLabel.text = [NSString stringWithFormat:@"%i", self.previewView.nextNumber];
        [self generateNextNumber];
        [self.previousStorages addObject:@(YES)];
    }
}

- (void)undoButtonPressed:(id)sender {
    if (![GameData sharedGameData].fullGameUnlocked) {
        [ConfirmationView DisplayConfirmationView:@"Unlock Full Game"
                                          message:@"You need to unlock the full game for this feature"
                                     confirmTitle:@"Full Game info"
                                    confirmAction:^void(){[self presentViewController:[StoreViewController new] animated:YES completion:nil];}];
    } else if (!self.levelFailed && self.previewView.finishedAnimating && self.allowTouch) {
        if ([[self.previousStorages lastObject] boolValue]) {
            int sum = 0;
            for (NSNumber *n in self.previousStorages) {
                sum += n.intValue;
            }
            if (sum == 1) {
                [self.previewView lastStorageUndo:self.storageLabel.text];
                self.storageLabel.text = @"";
            } else {
                int storageNumber = [self.storageLabel.text intValue];
                self.storageLabel.text = [NSString stringWithFormat:@"%i", self.previewView.nextNumber];
                [self.previewView replaceNumber:storageNumber];
            }
        } else {
            [self.gameState undo];
            [self.previewView undo];
            [self.previousScores removeLastObject];
            self.gameState.totalScore = [[self.previousScores lastObject] intValue];
        }
        [self.previousStorages removeLastObject];
        [self.statusView updateScoreTo:self.gameState.totalScore];
    }
}

- (void)menuButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)restartButtonPressed:(id)sender {
    [self startNewGame];
}

@end
