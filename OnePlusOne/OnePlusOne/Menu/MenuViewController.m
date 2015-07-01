//
//  MenuViewController.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-24.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "MenuViewController.h"
#import "GameViewController.h"
#import "OptionsViewController.h"
#import "UIBezierPath+Paths.h"
#import "PathButton.h"
#import "MissionsView.h"
#import "NextLevelView.h"
#import "GameData.h"
#import "MissionsFactory.h"

#import "Mission.h"

@interface MenuViewController ()

//@property (nonatomic) int level;

//@property (nonatomic) NSArray *missions;
@property (nonatomic) UILabel *titleLabel;
//@property (nonatomic) UILabel *levelLabel;
//@property (nonatomic) UIView *levelBackgroundView;

//@property (nonatomic) PathButton *playButton;
//@property (nonatomic) PathButton *optionsButton;
@property (nonatomic) UIButton *playButton;
@property (nonatomic) UIButton *resetProgressButton;
@property (nonatomic) UIButton *removeAdsButton;

@property (nonatomic) MissionsView *missionsView;
//@property (nonatomic) NextLevelView *nextLevelView;
@property (nonatomic) GameViewController *gameViewController;
//@property (nonatomic) OptionsViewController *optionsViewController;

@end

@implementation MenuViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [[GameData sharedGameData] reset];
        
        self.gameViewController = [[GameViewController alloc] init];
        
//        self.optionsViewController = [OptionsViewController new];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor defaultDarkColor];
        self.titleLabel.text = @"One Plus One";
        
//        self.levelLabel = [UILabel new];
//        self.levelLabel.textColor = [UIColor defaultLightColor];
//        self.levelLabel.font = [UIFont fontWithName:@"Helvetica" size:24];
//        
//        self.levelBackgroundView = [UIView new];
//        self.levelBackgroundView.backgroundColor = [UIColor defaultDarkColor];
        
        self.missionsView = [MissionsView new];
//        self.nextLevelView = [NextLevelView new];

//        self.playButton = [[PathButton alloc] initWithPath:[UIBezierPath playPath]
//                                           foregroundColor:[UIColor whiteColor]
//                                           backgroundColor:[UIColor defaultDarkColor]];
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playButton.backgroundColor = [UIColor defaultDarkColor];
        [self.playButton setTitleColor:[UIColor defaultWhiteColor] forState:UIControlStateNormal];
        [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
        [self.playButton addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        self.playButton.scale = 0.75;
        
//        self.optionsButton = [[PathButton alloc] initWithPath:[UIBezierPath optionsPath]
//                                              foregroundColor:[UIColor whiteColor]
//                                              backgroundColor:[UIColor defaultDarkColor]];
        
        self.resetProgressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.resetProgressButton.backgroundColor = [UIColor defaultDarkColor];
        [self.resetProgressButton setTitleColor:[UIColor defaultWhiteColor] forState:UIControlStateNormal];
        [self.resetProgressButton setTitle:@"Reset progress" forState:UIControlStateNormal];
        [self.resetProgressButton addTarget:self action:@selector(optionsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.removeAdsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.removeAdsButton.backgroundColor = [UIColor defaultDarkColor];
        [self.removeAdsButton setTitleColor:[UIColor defaultWhiteColor] forState:UIControlStateNormal];
        [self.removeAdsButton setTitle:@"Remove ads" forState:UIControlStateNormal];
        [self.removeAdsButton addTarget:self action:@selector(optionsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
//        self.optionsButton.scale = 0.75;
//        [[GameData sharedGameData] levelUp];
//        [[GameData sharedGameData] levelUp];
//        [[GameData sharedGameData] levelUp];
//        self.level = [GameData sharedGameData].level;
//        self.missions = [MissionsFactory missionsForLevel:self.level];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor defaultLightColor];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.missionsView];
//    [self.view addSubview:self.levelBackgroundView];
//    [self.levelBackgroundView addSubview:self.levelLabel];
    //    [self.view addSubview:self.nextLevelView];
    [self.view addSubview:self.playButton];
    [self.view addSubview:self.resetProgressButton];
    [self.view addSubview:self.removeAdsButton];
//    [self.view addSubview:self.optionsButton];
    
    self.titleLabel.font = [UIFont fontWithName:@"helvetica" size:self.view.frame.size.width*0.12f];
//    self.levelLabel.text = [NSString stringWithFormat:@"Level %i", self.level];
//    [self.missionsView displayMissions:self.missions];
//    [self.nextLevelView showNextLeveL:self.level+1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self layoutViews];
//    [self.missionsView displayMissions:self.missions];
//    
//    if ([GameData sharedGameData].level != self.level) {
//        static float duration = 0.6;
//        self.level = [GameData sharedGameData].level;
//        self.missions = [MissionsFactory missionsForLevel:self.level];
//        [self.gameViewController startNewGame];
//        [self.missionsView displayNewMissions:self.missions duration:duration];
//        CGRect origrect = self.levelLabel.frame;
//        [UIView animateWithDuration:duration animations:^{
//            self.levelLabel.alpha = 0;
//        } completion:^(BOOL finished) {
//            self.levelLabel.alpha = 1;
//            self.levelLabel.frame = SKRectSetY(self.levelLabel.frame, +260);
//            self.levelLabel.text = [NSString stringWithFormat:@"Level %i", self.level];
//            [self.nextLevelView animateNextLeveL:self.level+1 duration:duration*0.65];
//            [UIView animateWithDuration:duration animations:^{
//                self.levelLabel.frame = origrect;
//                [self layoutViews];
//            }];
//        }];
//    }
}

- (void)playButtonPressed:(UIButton *)button {
//    self.gameViewController.missions = self.missions;
    [self presentViewController:self.gameViewController animated:NO completion:nil];
}

- (void)optionsButtonPressed:(UIButton *)button {
//    [self presentViewController:self.optionsViewController animated:NO completion:nil];
}

- (void)layoutViews {
    CGSize size = self.view.frame.size;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = SKRectCenterHorizontallyInRect(self.titleLabel.frame, self.view.bounds);
    self.titleLabel.frame = SKRectSetY(self.titleLabel.frame, 30);
    
//    static CGFloat levelTop = 0.03;
//    static CGFloat levelLeft = 0.13;
//    static CGFloat levelRight = 0.5;
//    static CGFloat levelHeight = 0.04;
//    self.levelBackgroundView.frame = SKRectSetX(self.levelBackgroundView.frame, size.width*levelLeft);
//    self.levelBackgroundView.frame = SKRectSetY(self.levelBackgroundView.frame, CGRectGetMaxY(self.titleLabel.frame) + size.height*levelTop);
//    self.levelBackgroundView.frame = SKRectSetRight(self.levelBackgroundView.frame, size.width - size.width*levelRight, YES);
//    self.levelBackgroundView.frame = SKRectSetHeight(self.levelBackgroundView.frame, size.height*levelHeight);
//    
//    [self.levelLabel sizeToFit];
//    self.levelLabel.frame = SKRectCenterVerticallyInRect(self.levelLabel.frame, self.levelBackgroundView.frame);
//    self.levelLabel.frame = SKRectSetX(self.levelLabel.frame, size.width*0.03);
    
    static CGFloat missionsTop = 0.1;
    static CGFloat missionsLeft = 0.13;
    static CGFloat missionsRight = 0.13;
    static CGFloat missionsHeight = 0.28;
    self.missionsView.frame = SKRectSetX(self.missionsView.frame, size.width * missionsLeft);
    self.missionsView.frame = SKRectSetY(self.missionsView.frame, CGRectGetMaxY(self.titleLabel.frame) + size.height*missionsTop);
    self.missionsView.frame = SKRectSetRight(self.missionsView.frame, size.width - size.width*missionsRight, YES);
    self.missionsView.frame = SKRectSetHeight(self.missionsView.frame, size.height*missionsHeight);
    
//    static CGFloat nextLevelTop = 0.03;
//    static CGFloat nextLevelLeft = 0.13;
//    static CGFloat nextLevelRight = 0.13;
//    static CGFloat nextLevelHeight = 0.1;
//    self.nextLevelView.frame = SKRectSetX(self.nextLevelView.frame, size.width*nextLevelLeft);
//    self.nextLevelView.frame = SKRectSetY(self.nextLevelView.frame, CGRectGetMaxY(self.missionsView.frame) + size.height*nextLevelTop);
//    self.nextLevelView.frame = SKRectSetRight(self.nextLevelView.frame, size.width - size.width*nextLevelRight, YES);
//    self.nextLevelView.frame = SKRectSetHeight(self.nextLevelView.frame, size.height*nextLevelHeight);
    
    static CGFloat buttonTop = 0.1;
    static CGFloat buttonSpacing = 0.04;
    static CGFloat buttonLeft = 0.13;
    static CGFloat buttonRight = 0.13;
    static CGFloat buttonSize = 0.15;
    
    self.playButton.frame = SKRectSetX(self.playButton.frame, size.width*buttonLeft);
    self.playButton.frame = SKRectSetY(self.playButton.frame, CGRectGetMaxY(self.missionsView.frame) + size.height*buttonTop);
    self.playButton.frame = SKRectSetHeight(self.playButton.frame, size.width*buttonSize);
    self.playButton.frame = SKRectSetRight(self.playButton.frame, size.width - size.width*buttonRight, YES);
    
    self.resetProgressButton.frame = SKRectSetX(self.resetProgressButton.frame, size.width*buttonLeft);
    self.resetProgressButton.frame = SKRectSetY(self.resetProgressButton.frame, CGRectGetMaxY(self.playButton.frame) + size.height*buttonSpacing);
    self.resetProgressButton.frame = SKRectSetHeight(self.resetProgressButton.frame, size.width*buttonSize);
    self.resetProgressButton.frame = SKRectSetRight(self.resetProgressButton.frame, size.width - size.width*buttonRight, YES);
    
    self.removeAdsButton.frame = SKRectSetX(self.removeAdsButton.frame, size.width*buttonLeft);
    self.removeAdsButton.frame = SKRectSetY(self.removeAdsButton.frame, CGRectGetMaxY(self.resetProgressButton.frame) + size.height*buttonSpacing);
    self.removeAdsButton.frame = SKRectSetHeight(self.removeAdsButton.frame, size.width*buttonSize);
    self.removeAdsButton.frame = SKRectSetRight(self.removeAdsButton.frame, size.width - size.width*buttonRight, YES);
}

@end
