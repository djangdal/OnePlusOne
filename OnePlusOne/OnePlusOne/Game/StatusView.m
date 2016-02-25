//
//  StatusView.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-27.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "StatusView.h"
#import "MissionsView.h"
#import "MissionsFactory.h"
#import "GameData.h"

@interface StatusView ()

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *scoreLabel;
@property (nonatomic) UILabel *scoreTitleLabel;
@property (nonatomic) UILabel *highScoreLabel;
@property (nonatomic) UILabel *highScoreTitleLabel;
@property (nonatomic) UILabel *targetScoreLabel;
@property (nonatomic) UILabel *targetScoreTitleLabel;

@end

@implementation StatusView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor defaultDarkColor];
        
        self.titleLabel = [self addLabelWithText:@"One Plus One"];
        
        self.scoreLabel = [self addLabelWithText:@"0"];
        self.scoreLabel.textAlignment = NSTextAlignmentCenter;
        self.scoreLabel.clipsToBounds = NO;
        self.scoreLabel.adjustsFontSizeToFitWidth = YES;
        self.scoreLabel.minimumScaleFactor = 0.4;
        self.scoreTitleLabel = [self addLabelWithText:@"Score"];
        
        self.highScoreLabel = [self addLabelWithText:[NSString stringWithFormat:@"%i", [GameData sharedGameData].highScore]];
        self.highScoreLabel.textAlignment = NSTextAlignmentCenter;
        self.highScoreLabel.clipsToBounds = NO;
        self.highScoreLabel.adjustsFontSizeToFitWidth = YES;
        self.highScoreLabel.minimumScaleFactor = 0.4;
        self.highScoreTitleLabel = [self addLabelWithText:@"Best"];
        
        self.targetScoreLabel = [self addLabelWithText:@"0"];
        self.targetScoreLabel.textAlignment = NSTextAlignmentCenter;
        self.targetScoreLabel.clipsToBounds = NO;
        self.targetScoreLabel.adjustsFontSizeToFitWidth = YES;
        self.targetScoreLabel.minimumScaleFactor = 0.4;
        self.targetScoreTitleLabel = [self addLabelWithText:@"Goal"];
    }
    return self;
}

- (UILabel *)addLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor defaultLightColor];
    label.text = text;
    [self addSubview:label];
    return label;
}

- (void)layoutSubviews {
    CGSize size = self.frame.size;
    
    static CGFloat fontSize = 0.05;
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:size.width*0.06];
    self.scoreLabel.font = [UIFont fontWithName:@"Helvetica" size:size.width*fontSize];
    self.scoreTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:size.width*fontSize];
    self.targetScoreLabel.font = [UIFont fontWithName:@"Helvetica" size:size.width*fontSize];
    self.targetScoreTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:size.width*fontSize];
    self.highScoreLabel.font = [UIFont fontWithName:@"Helvetica" size:size.width*fontSize];
    self.highScoreTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:size.width*fontSize];
    
    static CGFloat titleLeft = 0.03;
    
    CGFloat labelSpacing = IsIphone4 ? -0.02 : 0.02;
    CGFloat labelsTop = IsIphone4 ? 0 : 0.03;
    
    static CGFloat scoreLeft = 0.05;
    static CGFloat targetLeft = 0.065;
    static CGFloat highScoreLeft = 0.065;
    static CGFloat labelWidth = 0.17;

    [self.titleLabel sizeToFit];
    self.titleLabel.frame = SKRectCenterVerticallyInRect(self.titleLabel.frame, self.bounds);
    self.titleLabel.frame = SKRectSetX(self.titleLabel.frame, size.width*titleLeft);
    
    [self.scoreLabel sizeToFit];
    [self.scoreTitleLabel sizeToFit];
    
    [self.targetScoreLabel sizeToFit];
    [self.targetScoreTitleLabel sizeToFit];
    
    [self.highScoreLabel sizeToFit];
    [self.highScoreTitleLabel sizeToFit];
    
    self.scoreTitleLabel.frame = SKRectSetX(self.scoreTitleLabel.frame, CGRectGetMaxX(self.titleLabel.frame) + size.width*scoreLeft);
    self.scoreTitleLabel.frame = SKRectSetY(self.scoreTitleLabel.frame, size.height*labelsTop);
    self.scoreLabel.frame = self.scoreTitleLabel.frame;
    self.scoreLabel.frame = SKRectSetWidth(self.scoreLabel.frame, size.width*labelWidth);
    self.scoreLabel.frame = SKRectSetX(self.scoreLabel.frame, CGRectGetMidX(self.scoreTitleLabel.frame) - CGRectGetWidth(self.scoreLabel.frame)/2);
    self.scoreLabel.frame = SKRectSetY(self.scoreLabel.frame, CGRectGetMaxY(self.scoreTitleLabel.frame) + size.height*labelSpacing);
    
    self.targetScoreTitleLabel.frame = SKRectSetX(self.targetScoreTitleLabel.frame, CGRectGetMaxX(self.scoreTitleLabel.frame) + size.width*targetLeft);
    self.targetScoreTitleLabel.frame = SKRectSetY(self.targetScoreTitleLabel.frame, size.height*labelsTop);
    self.targetScoreLabel.frame = self.targetScoreTitleLabel.frame;
    self.targetScoreLabel.frame = SKRectSetWidth(self.targetScoreLabel.frame, size.width*labelWidth);
    self.targetScoreLabel.frame = SKRectSetX(self.targetScoreLabel.frame, CGRectGetMidX(self.targetScoreTitleLabel.frame) - CGRectGetWidth(self.targetScoreLabel.frame)/2);
    self.targetScoreLabel.frame = SKRectSetY(self.targetScoreLabel.frame, CGRectGetMaxY(self.targetScoreTitleLabel.frame) + size.height*labelSpacing);
    
    self.highScoreTitleLabel.frame = SKRectSetX(self.highScoreTitleLabel.frame, CGRectGetMaxX(self.targetScoreTitleLabel.frame) + size.width*highScoreLeft);
    self.highScoreTitleLabel.frame = SKRectSetY(self.highScoreTitleLabel.frame, size.height*labelsTop);
    self.highScoreLabel.frame = self.highScoreTitleLabel.frame;
    self.highScoreLabel.frame = SKRectSetWidth(self.highScoreLabel.frame, size.width*labelWidth);
    self.highScoreLabel.frame = SKRectSetX(self.highScoreLabel.frame, CGRectGetMidX(self.highScoreTitleLabel.frame) - CGRectGetWidth(self.highScoreLabel.frame)/2);
    self.highScoreLabel.frame = SKRectSetY(self.highScoreLabel.frame, CGRectGetMaxY(self.highScoreTitleLabel.frame) + size.height*labelSpacing);
}

- (void)updateScoreTo:(int)score {
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", score];
    self.highScoreLabel.text = [NSString stringWithFormat:@"%i", [GameData sharedGameData].highScore];
    [self setNeedsLayout];
}

- (void)updateTargetScoreForLevel:(int)level {
    int scoreRequired;
    if (level == 1) {
        scoreRequired = [GameData sharedGameData].level2ScoreRequired;
    } else if (level == 2) {
        scoreRequired = [GameData sharedGameData].level3ScoreRequired;
    } else {
        scoreRequired = [GameData sharedGameData].level3ScoreRequired*1.75;
    }
    
    [self.targetScoreLabel setText:[NSString stringWithFormat:@"%i", scoreRequired]];
}

@end
