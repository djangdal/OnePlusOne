//
//  OptionsViewController.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-06-05.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "OptionsViewController.h"
#import "GameData.h"

@interface OptionsViewController ()

@property (nonatomic) UIButton *backButton;
@property (nonatomic) UIButton *resetButton;
@property (nonatomic) UIButton *unlockAllButton;
@property (nonatomic) UIButton *removeAdsButton;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *selectLevelLabel;
@property (nonatomic) NSArray *levelButtons;

@end

@implementation OptionsViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor defaultDarkColor];
        self.titleLabel.text = @"One Plus One";
        
        self.selectLevelLabel = [[UILabel alloc] init];
        self.selectLevelLabel.textColor = [UIColor defaultDarkColor];
        self.selectLevelLabel.text = @"Select level";
        
        
        NSMutableArray *levelButtons = [NSMutableArray new];
        for (int i=1; i<=12; i++) {
            UIButton *levelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            levelButton.backgroundColor = [UIColor defaultDarkColor];
            [levelButton addTarget:self action:@selector(levelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [levelButtons addObject:levelButton];
        }
        self.levelButtons = levelButtons;
        
        
        self.resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.resetButton.backgroundColor = [UIColor defaultDarkColor];
        [self.resetButton setTitle:@"Reset progress" forState:UIControlStateNormal];
        [self.resetButton addTarget:self action:@selector(resetButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.removeAdsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.removeAdsButton.backgroundColor = [UIColor defaultDarkColor];
        [self.removeAdsButton setTitle:@"Remove ads" forState:UIControlStateNormal];
        [self.removeAdsButton addTarget:self action:@selector(removeAdsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backButton.backgroundColor = [UIColor defaultDarkColor];
        [self.backButton setTitle:@"Back" forState:UIControlStateNormal];
        [self.backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.unlockAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.unlockAllButton.backgroundColor = [UIColor defaultDarkColor];
        [self.unlockAllButton setTitle:@"Unlock" forState:UIControlStateNormal];
        [self.unlockAllButton addTarget:self action:@selector(unlockAllLevels:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.selectLevelLabel];
    [self.view addSubview:self.resetButton];
    [self.view addSubview:self.removeAdsButton];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.unlockAllButton];
    [self.levelButtons enumerateObjectsUsingBlock:^(UIButton *levelButton, NSUInteger idx, BOOL *stop) {
        [self.view addSubview:levelButton];
    }];
    
    self.view.backgroundColor = [UIColor defaultLightColor];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:self.view.frame.size.width*0.12f];
    self.selectLevelLabel.font = [UIFont fontWithName:@"Helvetica" size:self.view.frame.size.width*0.07f];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGSize size = self.view.frame.size;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = SKRectCenterHorizontallyInRect(self.titleLabel.frame, self.view.bounds);
    self.titleLabel.frame = SKRectSetY(self.titleLabel.frame, 30);
    
    static CGFloat selectLevelTop = 0.07;
    static CGFloat selectLevelLeft = 0.08;
    [self.selectLevelLabel sizeToFit];
    self.selectLevelLabel.frame = SKRectSetX(self.selectLevelLabel.frame, size.width*selectLevelLeft);
    self.selectLevelLabel.frame = SKRectSetY(self.selectLevelLabel.frame, CGRectGetMaxY(self.titleLabel.frame) + size.height*selectLevelTop);
    
    static CGFloat levelTop = 0.01;
    static CGFloat levelLeft = 0.08;
    CGFloat levelSize = size.width*0.13;
    CGFloat levelSpacing = (size.width - levelSize*4 - size.width*levelLeft*2)/3;
    [self.levelButtons enumerateObjectsUsingBlock:^(UIButton *levelButton, NSUInteger idx, BOOL *stop) {
        unsigned long row = idx/4;
        unsigned long col = idx%4;
        if ([GameData sharedGameData].levelsUnlocked >= idx+1) {
            [levelButton setTitle:[NSString stringWithFormat:@"%lu",idx+1] forState:UIControlStateNormal];
            levelButton.enabled = true;
        } else {
            [levelButton setTitle:@"" forState:UIControlStateNormal];
            levelButton.enabled = false;
        }
        levelButton.frame = CGRectMake(size.width*levelLeft + col*(levelSpacing+levelSize), CGRectGetMaxY(self.selectLevelLabel.frame) + size.height*levelTop + row*(levelSpacing+levelSize), levelSize, levelSize);
    }];
    
    
    static CGFloat buttonsTop = 0.1;
    static CGFloat buttonsRight = 0.1;
    static CGFloat buttonsLeft = 0.1;
    static CGFloat buttonsSpacing = 0.05;
    static CGFloat buttonsHeight = 0.1;
    self.resetButton.frame = SKRectSetX(self.resetButton.frame, size.width*buttonsLeft);
    self.resetButton.frame = SKRectSetY(self.resetButton.frame, CGRectGetMaxY(((UIButton *)[self.levelButtons lastObject]).frame) + size.height*buttonsTop);
    self.resetButton.frame = SKRectSetRight(self.resetButton.frame, size.width/2 - size.width*buttonsSpacing, YES);
    self.resetButton.frame = SKRectSetHeight(self.resetButton.frame, size.height*buttonsHeight);
    
    self.removeAdsButton.frame = SKRectSetX(self.removeAdsButton.frame, size.width/2 + size.width*buttonsSpacing);
    self.removeAdsButton.frame = SKRectSetY(self.removeAdsButton.frame, CGRectGetMaxY(((UIButton *)[self.levelButtons lastObject]).frame) + size.height*buttonsTop);
    self.removeAdsButton.frame = SKRectSetRight(self.removeAdsButton.frame, size.width - size.width*buttonsRight, YES);
    self.removeAdsButton.frame = SKRectSetHeight(self.removeAdsButton.frame, size.height*buttonsHeight);
    
    
    static CGFloat backBottom = 0.03;
    static CGFloat backWidth = 0.2;
    static CGFloat backHeight = 0.1;
    self.backButton.frame = SKRectSetHeight(self.backButton.frame, size.height*backHeight);
    self.backButton.frame = SKRectSetWidth(self.backButton.frame, size.height*backWidth);
    self.backButton.frame = SKRectCenterHorizontallyInRect(self.backButton.frame, self.view.frame);
    self.backButton.frame = SKRectSetBottom(self.backButton.frame, size.height - size.height*backBottom, NO);
    
    self.unlockAllButton.frame = CGRectMake(10, size.height-60, 100, 50);
}

- (void)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)levelButtonPressed:(UIButton *)sender {
    int level = [sender.titleLabel.text intValue];
    [[GameData sharedGameData] goToLevel:level];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)resetButtonPressed:(id)sender {
    [[GameData sharedGameData] reset];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)removeAdsButtonPressed:(id)sender {
    NSLog(@"remove ads");
}

- (void)unlockAllLevels:(id)sender {
    [[GameData sharedGameData] unlockAllLevels];
    NSLog(@"unlock all");
}


@end
