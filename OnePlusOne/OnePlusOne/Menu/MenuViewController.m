//
//  MenuViewController.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-24.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "MenuViewController.h"
#import "GameViewController.h"
#import "UIBezierPath+Paths.h"
#import "PathButton.h"
#import "MissionsView.h"
#import "NextLevelView.h"
#import "GameData.h"
#import "MissionsFactory.h"

#import "Mission.h"

@interface MenuViewController ()

@property (nonatomic) int level;

@property (nonatomic) NSArray *missions;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *levelLabel;
@property (nonatomic) UIView *levelBackgroundView;

@property (nonatomic) PathButton *playButton;
@property (nonatomic) PathButton *optionsButton;
@property (nonatomic) PathButton *highscoresButton;
@property (nonatomic) PathButton *achievementsButton;

@property (nonatomic) MissionsView *missionsView;
@property (nonatomic) NextLevelView *nextLevelView;
@property (nonatomic) GameViewController *gameViewController;

@end

@implementation MenuViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [[GameData sharedGameData] reset];
        self.gameViewController = [[GameViewController alloc] init];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:38];
        self.titleLabel.textColor = [UIColor defaultDarkColor];
        self.titleLabel.text = @"One Plus One";
        
        self.levelLabel = [UILabel new];
        self.levelLabel.textColor = [UIColor defaultLightColor];
        self.levelLabel.font = [UIFont fontWithName:@"helvetica" size:20];
        
        self.levelBackgroundView = [UIView new];
        self.levelBackgroundView.backgroundColor = [UIColor defaultDarkColor];
        
        self.missionsView = [MissionsView new];
        self.nextLevelView = [NextLevelView new];

        self.playButton = [[PathButton alloc] initWithPath:[UIBezierPath playPath]
                                           foregroundColor:[UIColor whiteColor]
                                           backgroundColor:[UIColor defaultDarkColor]];
        [self.playButton addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.playButton.scale = 0.45;
        
        self.optionsButton = [[PathButton alloc] initWithPath:[UIBezierPath optionsPath]
                                              foregroundColor:[UIColor whiteColor]
                                              backgroundColor:[UIColor defaultDarkColor]];
        [self.optionsButton addTarget:self action:@selector(achievementsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.optionsButton.scale = 0.5;
        
        self.highscoresButton = [[PathButton alloc] initWithPath:[UIBezierPath highscoresPath]
                                                 foregroundColor:[UIColor whiteColor]
                                                 backgroundColor:[UIColor defaultDarkColor]];
        [self.highscoresButton addTarget:self action:@selector(highscoresButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.highscoresButton.scale = 0.6;
        
        self.achievementsButton = [[PathButton alloc] initWithPath:[UIBezierPath achievementsPath]
                                                   foregroundColor:[UIColor whiteColor]
                                                   backgroundColor:[UIColor defaultDarkColor]];
        [self.achievementsButton addTarget:self action:@selector(achievementsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.achievementsButton.scale = 0.6;
        
        [[GameData sharedGameData] levelUp];
//        [[GameData sharedGameData] levelUp];
//        [[GameData sharedGameData] levelUp];
        self.level = [GameData sharedGameData].level;
        self.missions = [MissionsFactory missionsForLevel:self.level];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor defaultLightColor];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.levelBackgroundView];
    [self.levelBackgroundView addSubview:self.levelLabel];
    [self.view addSubview:self.missionsView];
    [self.view addSubview:self.nextLevelView];
    [self.view addSubview:self.playButton];
    [self.view addSubview:self.optionsButton];
    [self.view addSubview:self.highscoresButton];
    [self.view addSubview:self.achievementsButton];
    
    [self.missionsView displayMissions:self.missions];
    self.levelLabel.text = [NSString stringWithFormat:@"Level %i", self.level];
    [self.nextLevelView showNextLeveL:self.level+1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self layoutViews];
    [self.missionsView displayMissions:self.missions];
    
    if ([GameData sharedGameData].level != self.level) {
        self.level = [GameData sharedGameData].level;
        self.missions = [MissionsFactory missionsForLevel:self.level];
        [self.gameViewController startNewGame];
        [UIView animateWithDuration:1 animations:^{
            self.missionsView.alpha = 0;
        } completion:^(BOOL finished) {
            self.missionsView.alpha = 1;
            [self.missionsView displayMissions:self.missions];
            self.levelLabel.text = [NSString stringWithFormat:@"Level %i", self.level];
            [self.nextLevelView showNextLeveL:self.level+1];
        }];
    }
}

- (void)playButtonPressed:(UIButton *)button {
    self.gameViewController.missions = self.missions;
    [self presentViewController:self.gameViewController animated:NO completion:nil];
}

- (void)highscoresButtonPressed:(UIButton *)button {
//    [self presentViewController:self.gameViewController animated:NO completion:nil];
}

- (void)achievementsButtonPressed:(UIButton *)button {
}

- (void)optionsButtonPressed:(UIButton *)button {
//    [[GameData sharedGameData] reset];
//    [[GameData sharedGameData] save];
}

- (void)layoutViews {
    CGSize size = self.view.frame.size;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = SKRectCenterHorizontallyInRect(self.titleLabel.frame, self.view.bounds);
    self.titleLabel.frame = SKRectSetY(self.titleLabel.frame, 30);
    
    static CGFloat levelTop = 0.03;
    static CGFloat levelLeft = 0.13;
    static CGFloat levelRight = 0.5;
    static CGFloat levelHeight = 0.04;
    self.levelBackgroundView.frame = SKRectSetX(self.levelBackgroundView.frame, size.width*levelLeft);
    self.levelBackgroundView.frame = SKRectSetY(self.levelBackgroundView.frame, CGRectGetMaxY(self.titleLabel.frame) + size.height*levelTop);
    self.levelBackgroundView.frame = SKRectSetRight(self.levelBackgroundView.frame, size.width - size.width*levelRight, YES);
    self.levelBackgroundView.frame = SKRectSetHeight(self.levelBackgroundView.frame, size.height*levelHeight);
    
    [self.levelLabel sizeToFit];
    self.levelLabel.frame = SKRectCenterVerticallyInRect(self.levelLabel.frame, self.levelBackgroundView.frame);
    self.levelLabel.frame = SKRectSetX(self.levelLabel.frame, size.width*0.03);
    
    static CGFloat missionsTop = 0.0;
    static CGFloat missionsLeft = 0.13;
    static CGFloat missionsRight = 0.13;
    static CGFloat missionsHeight = 0.28;
    self.missionsView.frame = SKRectSetX(self.missionsView.frame, size.width * missionsLeft);
    self.missionsView.frame = SKRectSetY(self.missionsView.frame, CGRectGetMaxY(self.levelBackgroundView.frame) + size.height*missionsTop);
    self.missionsView.frame = SKRectSetRight(self.missionsView.frame, size.width - size.width*missionsRight, YES);
    self.missionsView.frame = SKRectSetHeight(self.missionsView.frame, size.height*missionsHeight);
    
    static CGFloat nextLevelTop = 0.03;
    static CGFloat nextLevelLeft = 0.13;
    static CGFloat nextLevelRight = 0.13;
    static CGFloat nextLevelHeight = 0.09;
    self.nextLevelView.frame = SKRectSetX(self.nextLevelView.frame, size.width*nextLevelLeft);
    self.nextLevelView.frame = SKRectSetY(self.nextLevelView.frame, CGRectGetMaxY(self.missionsView.frame) + size.height*nextLevelTop);
    self.nextLevelView.frame = SKRectSetRight(self.nextLevelView.frame, size.width - size.width*nextLevelRight, YES);
    self.nextLevelView.frame = SKRectSetHeight(self.nextLevelView.frame, size.height*nextLevelHeight);
    
    static CGFloat buttonTop = 0.06;
    static CGFloat buttonLeft = 0.13;
    static CGFloat buttonRight = 0.13;
    static CGFloat buttonMiddle = 0.04;
    static CGFloat buttonSize = 0.26;
    self.playButton.frame = SKRectSetX(self.playButton.frame, size.width*buttonLeft);
    self.playButton.frame = SKRectSetY(self.playButton.frame, CGRectGetMaxY(self.nextLevelView.frame) + size.height*buttonTop);
    self.playButton.frame = SKRectSetWidth(self.playButton.frame, self.view.bounds.size.width*buttonSize);
    self.playButton.frame = SKRectSetHeight(self.playButton.frame, self.view.bounds.size.width*buttonSize);
    
    self.highscoresButton.frame = SKRectSetX(self.highscoresButton.frame, size.width*buttonLeft);
    self.highscoresButton.frame = SKRectSetY(self.highscoresButton.frame, CGRectGetMaxY(self.playButton.frame) + size.height*buttonMiddle);
    self.highscoresButton.frame = SKRectSetWidth(self.highscoresButton.frame, self.view.bounds.size.width*buttonSize);
    self.highscoresButton.frame = SKRectSetHeight(self.highscoresButton.frame, self.view.bounds.size.width*buttonSize);
    
    self.achievementsButton.frame = SKRectSetWidth(self.achievementsButton.frame, self.view.bounds.size.width*buttonSize);
    self.achievementsButton.frame = SKRectSetHeight(self.achievementsButton.frame, self.view.bounds.size.width*buttonSize);
    self.achievementsButton.frame = SKRectSetRight(self.achievementsButton.frame, size.width - size.width*buttonRight, NO);
    self.achievementsButton.frame = SKRectSetY(self.achievementsButton.frame, CGRectGetMaxY(self.nextLevelView.frame) + size.height*buttonTop);
    
    self.optionsButton.frame = SKRectSetWidth(self.optionsButton.frame, self.view.bounds.size.width*buttonSize);
    self.optionsButton.frame = SKRectSetHeight(self.optionsButton.frame, self.view.bounds.size.width*buttonSize);
    self.optionsButton.frame = SKRectSetRight(self.optionsButton.frame, size.width - size.width*buttonRight, NO);
    self.optionsButton.frame = SKRectSetY(self.optionsButton.frame, CGRectGetMaxY(self.achievementsButton.frame) + size.height*buttonMiddle);
}

@end
