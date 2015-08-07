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
#import "UIBezierPath+Paths.h"
#import "GameViewController.h"

@interface GameViewController ()

//@property (nonatomic) int nextNumber;
//@property (nonatomic) BOOL levelCompleted;
@property (nonatomic) BOOL levelFailed;
@property (nonatomic) BOOL allowTouch;

@property (nonatomic) UIView *fadeView;
@property (nonatomic) UIButton *restartButton;
@property (nonatomic) UIButton *menuButton;

@property (nonatomic) GridView *gridView;
@property (nonatomic) GameState *gameState;
@property (nonatomic) StatusView *statusView;

@property (nonatomic) PathButton *undoButton;
@property (nonatomic) PreviewView *previewView;
@property (nonatomic) PathButton *storageButton;
@property (nonatomic) UILabel *storageLabel;

@end

@implementation GameViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.gameState = [[GameState alloc] initWithGridSize:3 delegate:self];
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
        
        self.fadeView = [UIView new];
        self.fadeView.backgroundColor = [UIColor defaultLightColor];
        self.fadeView.alpha = 0.85f;
        
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
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor defaultLightColor];
    [self.view addSubview:self.gridView];
    [self.view addSubview:self.statusView];
    [self.view addSubview:self.fadeView];
    [self.view addSubview:self.restartButton];
    [self.view addSubview:self.menuButton];
    
    [self.view addSubview:self.undoButton];
    [self.view addSubview:self.previewView];
    [self.view addSubview:self.storageButton];
    [self.storageButton addSubview:self.storageLabel];
    
    [self layoutViews];
}

- (void)layoutViews {
    CGSize size = self.view.frame.size;
    static CGFloat statusTop = 0.05;
    static CGFloat statusLeft = 0.04;
    static CGFloat statusRight = 0.04;
    static CGFloat statusHeight = 0.17;
    self.statusView.frame = SKRectSetX(self.statusView.frame, size.width*statusLeft);
    self.statusView.frame = SKRectSetY(self.statusView.frame, size.height*statusTop);
    self.statusView.frame = SKRectSetRight(self.statusView.frame, size.width - size.width*statusRight, YES);
    self.statusView.frame = SKRectSetHeight(self.statusView.frame, size.height*statusHeight);
    
    static CGFloat buttonsTop = 0.02;
    static CGFloat buttonsLeft = 0.04;
    static CGFloat buttonsRight = 0.04;
    static CGFloat buttonsHeight = 0.05;
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
    
    static CGFloat actionsBottom = 0.01;
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

- (void)viewWillAppear:(BOOL)animated {
//    [self.statusView updateMissionsStatus:self.missions];
//    int gridSize = [self gridSizeForLevel:[GameData sharedGameData].level];
//    if (gridSize != self.gameState.grid.count) {
//        self.gameState = [[GameState alloc] initWithGridSize:gridSize delegate:self];
//        [self.gridView setUpForGameState:self.gameState];
//    }
//    
    if (!self.gameState.gameOngoing) {
        [self startNewGame];
    }
    [self layoutViews];
    [self.statusView updateScoreTo:self.gameState.totalScore];
}

- (void)menuButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)restartButtonPressed:(id)sender {
    NSLog(@"restart");
    [self startNewGame];
}


- (void)startNewGame {
    [self.gameState resetGameState];
//    self.nextNumber = 1;
    self.storageLabel.text = @"";
    [self.previewView newNumbers:@[@1,@1,@1]];
    
//    [self previewNextNumber];
    self.allowTouch = YES;
    self.levelFailed = NO;
//    self.levelCompleted = NO;
//    [self.controlsView previewNextNumber:self.nextNumber];
    [self.statusView updateScoreTo:self.gameState.totalScore];
//    [self.missions enumerateObjectsUsingBlock:^(Mission *mission, NSUInteger idx, BOOL *stop) {
//        if (mission.missionState != MissionStateCompleted) {
//            mission.resetMission = YES;
//            mission.missionState = MissionStateOngoing;
//        }
//    }];
//    [self.statusView updateMissionsStatus:self.missions];
    [self layoutViews];
//    [self.controlsView displayForLevel:[GameData sharedGameData].level];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.allowTouch) {
        return;
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self.gridView];
    if ([touch view] == self.gridView) {
        [self userSelectedCell:[self.gridView gridCellViewForTouchPoint:touchPoint]];
    }
}

- (void)userSelectedCell:(GridCellView *)gridCellView {
    if (gridCellView.cellValue == 0) {
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
//    __block BOOL allCompleted = YES;
    __block BOOL anyCompleted = YES;
    [[[MissionsHandler sharedHandler] currentMissions] enumerateObjectsUsingBlock:^(Mission *mission, NSUInteger idx, BOOL *stop) {
        if ([mission completedForGameState:self.gameState]) {
            [[MissionsHandler sharedHandler] completedMission:mission];
            anyCompleted = YES;
        }
    }];
    
    if (anyCompleted) {
        [self.statusView displayMissions:[[MissionsHandler sharedHandler] currentMissions]];
    }
//    if (allCompleted && !self.levelCompleted) {
//        self.levelCompleted = YES;
//        if ([GameData sharedGameData].level < 12) {
//            [[GameData sharedGameData] levelUp];
//        }
//        [self.controlsView displayLevelCompleted];
//        [self layoutViews];
    if ([self.gameState isGameOver]) {
        self.levelFailed = YES;
//        [self.controlsView displayGameOver];
        [self layoutViews];
    } else {
        [self generateNextNumber];
        self.allowTouch = YES;
    }
}
- (void)storageButtonPressed:(id)sender {
    NSLog(@"storage");
    if (self.storageLabel.text.length > 0) {
        int storageNumber = [self.storageLabel.text intValue];
        self.storageLabel.text = [NSString stringWithFormat:@"%i", self.previewView.nextNumber];
        [self.previewView replaceNumber:storageNumber];
    } else {
        self.storageLabel.text = [NSString stringWithFormat:@"%i", self.previewView.nextNumber];
        [self generateNextNumber];
    }
}

- (void)undoButtonPressed:(id)sender {
    NSLog(@"undo");
    [self generateNextNumber];
}

@end
