//
//  StatusView.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-27.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "StatusView.h"
#import "HighScoreView.h"
#import "MissionsView.h"
#import "GameData.h"

@interface StatusView ()

@property (nonatomic) NSArray *missions;
@property (nonatomic) UILabel *scoreLabel;
@property (nonatomic) UILabel *levelLabel;
@property (nonatomic) UILabel *scoreTitleLabel;
@property (nonatomic) MissionsView *missionsView;

@end

@implementation StatusView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor defaultDarkColor];
        
        self.scoreLabel = [[UILabel alloc] init];
        self.scoreLabel.text = @"0";
        self.scoreLabel.textColor = [UIColor defaultLightColor];
        
        self.scoreTitleLabel = [[UILabel alloc] init];
        self.scoreTitleLabel.text = @"Score:";
        self.scoreTitleLabel.textColor = [UIColor defaultLightColor];
        
        self.levelLabel = [[UILabel alloc] init];
        self.levelLabel.textColor = [UIColor defaultLightColor];
        
        self.missionsView = [MissionsView new];
        
        [self addSubview:self.missionsView];
        [self addSubview:self.scoreLabel];
        [self addSubview:self.scoreTitleLabel];
        [self addSubview:self.levelLabel];
    }
    return self;
}

- (void)layoutSubviews {
    self.levelLabel.text = [NSString stringWithFormat:@"Level %i objectives:", [GameData sharedGameData].level];
    
    CGSize size = self.frame.size;
    
    static CGFloat levelTop = 0.1;
    static CGFloat levelLeft = 0.05;
    [self.levelLabel sizeToFit];
    self.levelLabel.frame = SKRectSetX(self.levelLabel.frame, size.width*levelLeft);
    self.levelLabel.frame = SKRectSetY(self.levelLabel.frame, size.height*levelTop);
    
    static CGFloat scoreLeft = 0.05;
    static CGFloat scoreBottom = 0.05;
    static CGFloat scoreSpacing = 0.05;
    [self.scoreLabel sizeToFit];
    [self.scoreTitleLabel sizeToFit];
    self.scoreLabel.frame = SKRectSetX(self.scoreLabel.frame, size.width*scoreLeft);
    self.scoreLabel.frame = SKRectSetBottom(self.scoreLabel.frame, size.height - size.height*scoreBottom, NO);
    self.scoreTitleLabel.frame = SKRectSetX(self.scoreTitleLabel.frame, size.width*scoreLeft);
    self.scoreTitleLabel.frame = SKRectSetBottom(self.scoreTitleLabel.frame, CGRectGetMinY(self.scoreLabel.frame) - size.height*scoreSpacing, NO);
    
    static CGFloat missionsTop = 0.05;
    static CGFloat missionsLeft = 0.44;
    static CGFloat missionsRight = 0.0;
    static CGFloat missionsBottom = 0.06;
    self.missionsView.frame = SKRectSetX(self.missionsView.frame, size.width*missionsLeft);
    self.missionsView.frame = SKRectSetY(self.missionsView.frame, size.height*missionsTop);
    self.missionsView.frame = SKRectSetRight(self.missionsView.frame, size.width - size.width*missionsRight, YES);
    self.missionsView.frame = SKRectSetBottom(self.missionsView.frame, size.height - size.height*missionsBottom, YES);
}

- (void)updateMissionsStatus:(NSArray *)missions {
    self.missions = missions;
    [self.missionsView displayMissions:self.missions];
}

- (void)updateScoreTo:(int)score {
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", score];
    [self setNeedsLayout];
}

@end
