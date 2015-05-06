//
//  MenuViewController.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-24.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "MenuViewController.h"
#import "GameViewController.h"
#import "MissionView.h"

@interface MenuViewController ()

@property (nonatomic) UILabel *titleLabel;

@property (nonatomic) MissionView *missionView1;
@property (nonatomic) MissionView *missionView2;
@property (nonatomic) MissionView *missionView3;

@property (nonatomic) UIButton *startButton;
@property (nonatomic) UIButton *resumeButton;

@property (nonatomic) GameViewController *gameViewController;

@end

@implementation MenuViewController


- (instancetype)init {
    self = [super init];
    if (self) {
        self.gameViewController = [[GameViewController alloc] init];
        
        self.missionView1 = [MissionView new];
        self.missionView2 = [MissionView new];
        self.missionView3 = [MissionView new];
        
        self.startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.startButton.backgroundColor = [UIColor redColor];
        [self.startButton addTarget:self action:@selector(startButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.resumeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.resumeButton.backgroundColor = [UIColor redColor];
        [self.resumeButton addTarget:self action:@selector(resumeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.resumeButton setTitle:@"Resume" forState:UIControlStateNormal];
        [self.resumeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.resumeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    }
    return self;
}

- (IBAction)startButtonPressed:(UIButton *)button{
    [self.gameViewController startNewGame];
    [self presentViewController:self.gameViewController animated:NO completion:nil];
}

- (IBAction)resumeButtonPressed:(UIButton *)button{
    [self presentViewController:self.gameViewController animated:NO completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.startButton.frame = CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-100, 200, 50);
    self.resumeButton.frame = CGRectMake(self.view.frame.size.width/2-100, CGRectGetMaxY(self.startButton.frame)+50, 200, 50);
    self.resumeButton.enabled = self.gameViewController.gameOngoing;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.startButton];
    [self.view addSubview:self.resumeButton];
    
    [self.view addSubview:self.missionView1];
    [self.view addSubview:self.missionView2];
    [self.view addSubview:self.missionView3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
