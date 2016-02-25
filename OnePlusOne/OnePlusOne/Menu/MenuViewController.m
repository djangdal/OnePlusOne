//
//  MenuViewController.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-24.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "StoreViewController.h"
#import "GameViewController.h"
#import "UIBezierPath+Paths.h"
#import "MenuViewController.h"
#import "ConfirmationView.h"
#import "NextLevelView.h"
#import "InAppManager.h"
#import "MissionsView.h"
#import "PathButton.h"
#import "GameData.h"
#import "Mission.h"

@interface MenuViewController ()

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIButton *level1Button;
@property (nonatomic) UIButton *level2Button;
@property (nonatomic) UIButton *level3Button;
@property (nonatomic) UIButton *resetProgressButton;
@property (nonatomic) UIButton *unlockFullGameButton;
@property (nonatomic) GameViewController *gameViewController;

@end

@implementation MenuViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.gameViewController = [[GameViewController alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor defaultDarkColor];
        self.titleLabel.text = @"One Plus One";
        
        self.level1Button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.level1Button.backgroundColor = [UIColor defaultDarkColor];
        [self.level1Button setTitleColor:[UIColor defaultWhiteColor] forState:UIControlStateNormal];
        [self.level1Button setTitle:@"Play level 1" forState:UIControlStateNormal];
        [self.level1Button addTarget:self action:@selector(level1ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.level2Button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.level2Button.backgroundColor = [UIColor defaultDarkColor];
        [self.level2Button setTitleColor:[UIColor defaultWhiteColor] forState:UIControlStateNormal];
        [self.level2Button setTitleColor:[UIColor defaultDisabledColor] forState:UIControlStateDisabled];
        [self.level2Button setTitle:@"Play level 2" forState:UIControlStateNormal];
        [self.level2Button addTarget:self action:@selector(level2ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.level3Button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.level3Button.backgroundColor = [UIColor defaultDarkColor];
        [self.level3Button setTitleColor:[UIColor defaultWhiteColor] forState:UIControlStateNormal];
        [self.level3Button setTitleColor:[UIColor defaultDisabledColor] forState:UIControlStateDisabled];
        [self.level3Button setTitle:@"Play level 3" forState:UIControlStateNormal];
        [self.level3Button addTarget:self action:@selector(level3ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.resetProgressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.resetProgressButton.backgroundColor = [UIColor defaultDarkColor];
        [self.resetProgressButton setTitleColor:[UIColor defaultWhiteColor] forState:UIControlStateNormal];
        [self.resetProgressButton setTitle:@"Reset progress" forState:UIControlStateNormal];
        [self.resetProgressButton addTarget:self action:@selector(resetButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.unlockFullGameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.unlockFullGameButton.backgroundColor = [UIColor defaultDarkColor];
        [self.unlockFullGameButton setTitleColor:[UIColor defaultWhiteColor] forState:UIControlStateNormal];
        [self.unlockFullGameButton setTitle:@"Unlock Full Game" forState:UIControlStateNormal];
        [self.unlockFullGameButton addTarget:self action:@selector(unlockFullGamePressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor defaultLightColor];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.level1Button];
    [self.view addSubview:self.level2Button];
    [self.view addSubview:self.level3Button];
    [self.view addSubview:self.resetProgressButton];
    [self.view addSubview:self.unlockFullGameButton];
    
    self.titleLabel.font = [UIFont fontWithName:@"helvetica" size:self.view.frame.size.height*0.05f];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.level2Button setEnabled:[GameData sharedGameData].level2Unlocked];
    [self.level3Button setEnabled:[GameData sharedGameData].level3Unlocked];
    [self layoutViews];
}

- (void)level1ButtonPressed:(UIButton *)button {
    [self.gameViewController playLevel:1];
    [self presentViewController:self.gameViewController animated:NO completion:nil];
}

- (void)level2ButtonPressed:(UIButton *)button {
    [self.gameViewController playLevel:2];
    [self presentViewController:self.gameViewController animated:NO completion:nil];
}

- (void)level3ButtonPressed:(UIButton *)button {
    if ([GameData sharedGameData].fullGameUnlocked) {
        [self.gameViewController playLevel:3];
        [self presentViewController:self.gameViewController animated:NO completion:nil];
    } else {
        [ConfirmationView DisplayConfirmationView:@"Unlock Full Game"
                                          message:@"You need to unlock the full game for this feature"
                                     confirmTitle:@"Full Game info"
                                    confirmAction:^void(){[self presentViewController:[StoreViewController new] animated:YES completion:nil];}];
    }
}

- (void)resetButtonPressed:(UIButton *)button {
    [ConfirmationView DisplayConfirmationView:@"Reset Progress"
                                      message:@"Are you sure you want to reset all progress?"
                                 confirmTitle:@"Reset"
                                confirmAction:^void(){
                                    [[GameData sharedGameData] reset];
                                    [self.level2Button setEnabled:[GameData sharedGameData].level2Unlocked];
                                    [self.level3Button setEnabled:[GameData sharedGameData].level3Unlocked];
                                    [self layoutViews];
                                }];
}

- (void)unlockFullGamePressed:(UIButton *)button {
//    [[GameData sharedGameData] unlockedFullGame];
    [self presentViewController:[StoreViewController new] animated:YES completion:nil];
}

- (void)layoutViews {
    CGSize size = self.view.frame.size;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = SKRectCenterHorizontallyInRect(self.titleLabel.frame, self.view.bounds);
    self.titleLabel.frame = SKRectSetY(self.titleLabel.frame, size.height*0.08);
    
    static CGFloat buttonTop = 0.1;
    static CGFloat buttonLeft = 0.13;
    static CGFloat buttonRight = 0.13;
    static CGFloat buttonSize = 0.08;
    static CGFloat buttonSectionSpacing = 0.13;
    CGFloat levelSpacing = [GameData sharedGameData].fullGameUnlocked ? 0.08 : 0.04;
    CGFloat buttonSpacing = [GameData sharedGameData].fullGameUnlocked ? 0.1 : 0.05;
    
    self.level1Button.frame = SKRectSetX(self.level1Button.frame, size.width*buttonLeft);
    self.level1Button.frame = SKRectSetY(self.level1Button.frame, CGRectGetMaxY(self.titleLabel.frame) + size.height*buttonTop);
    self.level1Button.frame = SKRectSetHeight(self.level1Button.frame, size.height*buttonSize);
    self.level1Button.frame = SKRectSetRight(self.level1Button.frame, size.width - size.width*buttonRight, YES);
    
    self.level2Button.frame = SKRectSetX(self.level2Button.frame, size.width*buttonLeft);
    self.level2Button.frame = SKRectSetY(self.level2Button.frame, CGRectGetMaxY(self.level1Button.frame) + size.height*levelSpacing);
    self.level2Button.frame = SKRectSetHeight(self.level2Button.frame, size.height*buttonSize);
    self.level2Button.frame = SKRectSetRight(self.level2Button.frame, size.width - size.width*buttonRight, YES);
    
    self.level3Button.frame = SKRectSetX(self.level3Button.frame, size.width*buttonLeft);
    self.level3Button.frame = SKRectSetY(self.level3Button.frame, CGRectGetMaxY(self.level2Button.frame) + size.height*levelSpacing);
    self.level3Button.frame = SKRectSetHeight(self.level3Button.frame, size.height*buttonSize);
    self.level3Button.frame = SKRectSetRight(self.level3Button.frame, size.width - size.width*buttonRight, YES);
    
    self.resetProgressButton.frame = SKRectSetX(self.resetProgressButton.frame, size.width*buttonLeft);
    self.resetProgressButton.frame = SKRectSetY(self.resetProgressButton.frame, CGRectGetMaxY(self.level3Button.frame) + size.height*buttonSectionSpacing);
    self.resetProgressButton.frame = SKRectSetHeight(self.resetProgressButton.frame, size.height*buttonSize);
    self.resetProgressButton.frame = SKRectSetRight(self.resetProgressButton.frame, size.width - size.width*buttonRight, YES);
    
    self.unlockFullGameButton.hidden = [GameData sharedGameData].fullGameUnlocked;
    self.unlockFullGameButton.frame = SKRectSetX(self.unlockFullGameButton.frame, size.width*buttonLeft);
    self.unlockFullGameButton.frame = SKRectSetY(self.unlockFullGameButton.frame, CGRectGetMaxY(self.resetProgressButton.frame) + size.height*buttonSpacing);
    self.unlockFullGameButton.frame = SKRectSetHeight(self.unlockFullGameButton.frame, size.height*buttonSize);
    self.unlockFullGameButton.frame = SKRectSetRight(self.unlockFullGameButton.frame, size.width - size.width*buttonRight, YES);
}

@end
