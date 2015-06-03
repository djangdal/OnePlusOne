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
#import "UIBezierPath+Paths.h"
#import "GameViewController.h"

@interface GameViewController ()

@property (nonatomic) int nextNumber;
@property (nonatomic) BOOL levelCompleted;
@property (nonatomic) BOOL levelFailed;
@property (nonatomic) BOOL allowTouch;

@property (nonatomic) UIView *fadeView;
@property (nonatomic) UIButton *restartButton;
@property (nonatomic) UIButton *menuButton;

@property (nonatomic) GridView *gridView;
@property (nonatomic) GameState *gameState;
@property (nonatomic) StatusView *statusView;
@property (nonatomic) ControlsView *controlsView;

@end

//static CGFloat const kGridSize = 2;

@implementation GameViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.gameState = [[GameState alloc] initWithGridSize:[self gridSizeForLevel:[GameData sharedGameData].level] delegate:self];
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
        self.fadeView.alpha = 0.5f;
        
        self.controlsView = [[ControlsView alloc] initWithDelegate:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor defaultLightColor];
    [self.view addSubview:self.gridView];
    [self.view addSubview:self.statusView];
    [self.view addSubview:self.controlsView];
    [self.view addSubview:self.fadeView];
    [self.view addSubview:self.controlsView];
    [self.view addSubview:self.restartButton];
    [self.view addSubview:self.menuButton];
    
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
    
    if (!self.levelCompleted) {
        static CGFloat buttonsTop = 0.02;
        static CGFloat buttonsLeft = 0.04;
        static CGFloat buttonsRight = 0.04;
        static CGFloat buttonsHeight = 0.05;
        static CGFloat buttonsWidth = 0.4;
        self.restartButton.frame = SKRectSetX(self.restartButton.frame, size.width*buttonsLeft);
        self.restartButton.frame = SKRectSetY(self.restartButton.frame, CGRectGetMaxY(self.statusView.frame) + size.height*buttonsTop);
        self.restartButton.frame = SKRectSetWidth(self.restartButton.frame, size.width*buttonsWidth);
        self.restartButton.frame = SKRectSetHeight(self.restartButton.frame, size.height*buttonsHeight);
        
        self.menuButton.frame = SKRectSetWidth(self.menuButton.frame, size.width*buttonsWidth);
        self.menuButton.frame = SKRectSetHeight(self.menuButton.frame, size.height*buttonsHeight);
        self.menuButton.frame = SKRectSetRight(self.menuButton.frame, size.width - size.width*buttonsRight, NO);
        self.menuButton.frame = SKRectSetY(self.menuButton.frame, CGRectGetMaxY(self.statusView.frame) + size.height*buttonsTop);
    } else {
        static CGFloat buttonsTop = 0.02;
        static CGFloat buttonsLeft = 0.04;
        static CGFloat buttonsRight = 0.04;
        static CGFloat buttonsHeight = 0.05;
        self.menuButton.frame = SKRectSetX(self.menuButton.frame, size.width*buttonsLeft);
        self.menuButton.frame = SKRectSetHeight(self.menuButton.frame, size.height*buttonsHeight);
        self.menuButton.frame = SKRectSetRight(self.menuButton.frame, size.width - size.width*buttonsRight, YES);
        self.menuButton.frame = SKRectSetY(self.menuButton.frame, CGRectGetMaxY(self.statusView.frame) + size.height*buttonsTop);
    }
    if (self.levelCompleted || self.levelFailed) {
        self.fadeView.frame = self.view.bounds;
    } else {
        self.fadeView.frame = CGRectZero;
    }
    
    static CGFloat gridSize = 0.92;
    CGFloat gridMargin = (1-gridSize)/2;
    self.gridView.frame = SKRectSetWidth(self.gridView.frame, size.width*gridSize);
    self.gridView.frame = SKRectSetHeight(self.gridView.frame, size.width*gridSize);
    self.gridView.frame = SKRectSetX(self.gridView.frame, size.width*gridMargin);
    self.gridView.frame = SKRectSetBottom(self.gridView.frame, size.height - size.width*gridMargin, NO);
    
    static CGFloat controlsTop = 0.01;
    static CGFloat controlsLeft = 0.04;
    static CGFloat controlsRight = 0.04;
    static CGFloat controlsBottom = 0.01;
    self.controlsView.frame = SKRectSetX(self.controlsView.frame, size.width*controlsLeft);
    self.controlsView.frame = SKRectSetRight(self.controlsView.frame, size.width - size.width*controlsRight, YES);
    self.controlsView.frame = SKRectSetY(self.controlsView.frame, CGRectGetMaxY(self.menuButton.frame) + size.height*controlsTop);
    self.controlsView.frame = SKRectSetBottom(self.controlsView.frame, CGRectGetMinY(self.gridView.frame) - size.height*controlsBottom, YES);
}

- (void)viewWillAppear:(BOOL)animated {
    [self.statusView updateMissionsStatus:self.missions];
    int gridSize = [self gridSizeForLevel:[GameData sharedGameData].level];
    if (gridSize != self.gameState.grid.count) {
        self.gameState = [[GameState alloc] initWithGridSize:gridSize delegate:self];
        [self.gridView setUpForGameState:self.gameState];
    }
    
    if (!self.gameState.gameOngoing) {
        [self startNewGame];
    }
    [self layoutViews];
}

- (void)menuButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)restartButtonPressed:(id)sender {
    NSLog(@"reset");
    [self startNewGame];
}

- (int)gridSizeForLevel:(int)level {
    int size = 2;
    if ([GameData sharedGameData].level >= 2) {
        size = 3;
    }
    if ([GameData sharedGameData].level >= 4) {
        size = 4;
    }
    return size;
}

- (void)startNewGame {
    self.gameState.totalScore = 0;
    self.gameState.tilesPlaced = 0;
    self.gameState.gameOngoing = YES;
    self.gameState.lastPlacedValue = 0;
    self.gameState.lastPlacedTile = nil;
    self.nextNumber = [GameData sharedGameData].level==3 ? 2 : 1;
    self.allowTouch = YES;
    self.levelFailed = NO;
    self.levelCompleted = NO;
    [self.controlsView previewNextNumber:self.nextNumber];
    [self.statusView updateScoreTo:self.gameState.totalScore];
    [self.missions enumerateObjectsUsingBlock:^(Mission *mission, NSUInteger idx, BOOL *stop) {
        if (mission.missionState != MissionStateCompleted) {
            mission.resetMission = YES;
            mission.missionState = MissionStateOngoing;
        }
    }];
    [self.statusView updateMissionsStatus:self.missions];
    for (NSArray *inner in self.gameState.grid) {
        for (GridCellView *cell in inner) {
            [cell resetCell];
        }
    }
    [self layoutViews];
    [self.controlsView displayForLevel:[GameData sharedGameData].level];
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
        self.gameState.lastPlacedValue = self.nextNumber;
        self.gameState.tilesPlaced++;
        self.gameState.totalScore += self.nextNumber;
        [self.controlsView stopPreviewing];
        [gridCellView startCellWithNumber:self.nextNumber];
        [self.statusView updateScoreTo:self.gameState.totalScore];
        NSArray *neighbours = [self.gridView neighboursForCell:gridCellView];
        [gridCellView mergeWithNeighbours:neighbours];
    }
}

- (void)generateNextNumber {
    int maxNumber = [GameData sharedGameData].level > 2 ? 2 : 1;
    self.nextNumber = arc4random_uniform(maxNumber)+1;
    [self.controlsView previewNextNumber:self.nextNumber];
}

#pragma GridCellViewProtocoll
- (void)mergedCellsWithScore:(int)score {
    self.gameState.totalScore += score;
    [self.statusView updateScoreTo:self.gameState.totalScore];
}

- (void)finishedMergingCells {
    if ([self.gameState isGameOver]) {
        self.levelFailed = YES;
        [self.controlsView displayGameOver];
        [self layoutViews];
    } else {
        __block BOOL allCompleted = YES;
        __block BOOL anyCompleted = YES;
        [self.missions enumerateObjectsUsingBlock:^(Mission *mission, NSUInteger idx, BOOL *stop) {
            if ([mission completedForGameState:self.gameState]) {
                anyCompleted = YES;
            } else {
                allCompleted = NO;
            }
        }];
        
        if (anyCompleted) {
            [self.statusView updateMissionsStatus:self.missions];
        }
        if (allCompleted && !self.levelCompleted) {
            self.levelCompleted = YES;
            [[GameData sharedGameData] levelUp];
            [self.controlsView displayLevelCompleted];
            [self layoutViews];
        } else {
            [self generateNextNumber];
            self.allowTouch = YES;
        }
    }
}

#pragma ControlsViewProtocoll
- (void)storageButtonPressed {
    NSLog(@"storage");
}

- (void)undoButtonPressed{
    NSLog(@"undo");
}

- (void)addButtonPressed {
    NSLog(@"add");
}

@end
