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

@property (nonatomic) UILabel *scoreLabel;
@property (nonatomic) UILabel *scoreTitleLabel;
@property (nonatomic) UILabel *highScoreLabel;
@property (nonatomic) UILabel *highScoreTitleLabel;
@property (nonatomic) UILabel *completionsLevel;
@property (nonatomic) MissionsView *missionsView;

@end

@implementation StatusView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor defaultDarkColor];
        
        self.scoreLabel = [self addLabelWithText:@"0"];
        self.scoreLabel.textAlignment = NSTextAlignmentCenter;
        self.scoreTitleLabel = [self addLabelWithText:@"Score"];
        
        self.highScoreLabel = [self addLabelWithText:[NSString stringWithFormat:@"%i", [GameData sharedGameData].highScore]];
        self.highScoreLabel.textAlignment = NSTextAlignmentCenter;
        self.highScoreTitleLabel = [self addLabelWithText:@"Best"];
        
        self.completionsLevel = [self addLabelWithText:[NSString stringWithFormat:@"%lu / %lu completed",
                                                        (unsigned long)[[GameData sharedGameData].completedMissionsIndexes count],
                                                        (unsigned long)[MissionsFactory allMissions].count]];
        
        self.missionsView = [MissionsView new];
        [self addSubview:self.missionsView];
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
    
    static CGFloat completionsTop = 0.1;
    static CGFloat completionsLeft = 0.05;
    [self.completionsLevel sizeToFit];
    self.completionsLevel.frame = SKRectSetX(self.completionsLevel.frame, size.width*completionsLeft);
    self.completionsLevel.frame = SKRectSetY(self.completionsLevel.frame, size.height*completionsTop);
    
    static CGFloat scoreLeft = 0.05;
    static CGFloat scoreBottom = 0.05;
    static CGFloat scoreSpacing = 0.05;
    [self.scoreLabel sizeToFit];
    [self.scoreTitleLabel sizeToFit];
    self.scoreLabel.frame = SKRectSetX(self.scoreLabel.frame, size.width*scoreLeft);
    self.scoreLabel.frame = SKRectSetWidth(self.scoreLabel.frame, self.scoreTitleLabel.frame.size.width);
    self.scoreLabel.frame = SKRectSetBottom(self.scoreLabel.frame, size.height - size.height*scoreBottom, NO);
    self.scoreTitleLabel.frame = SKRectSetX(self.scoreTitleLabel.frame, size.width*scoreLeft);
    self.scoreTitleLabel.frame = SKRectSetBottom(self.scoreTitleLabel.frame, CGRectGetMinY(self.scoreLabel.frame) - size.height*scoreSpacing, NO);
    
    static CGFloat highScoreLeft = 0.13;
    [self.highScoreLabel sizeToFit];
    [self.highScoreTitleLabel sizeToFit];
    self.highScoreLabel.frame = SKRectSetX(self.highScoreLabel.frame, CGRectGetMaxX(self.scoreTitleLabel.frame) + size.width*highScoreLeft);
    self.highScoreLabel.frame = SKRectSetBottom(self.highScoreLabel.frame, size.height - size.height*scoreBottom, NO);
    self.highScoreLabel.frame = SKRectSetWidth(self.highScoreLabel.frame, self.highScoreTitleLabel.frame.size.width);
    self.highScoreTitleLabel.frame = SKRectSetX(self.highScoreTitleLabel.frame, CGRectGetMaxX(self.scoreTitleLabel.frame) + size.width*highScoreLeft);
    self.highScoreTitleLabel.frame = SKRectSetBottom(self.highScoreTitleLabel.frame, CGRectGetMinY(self.highScoreLabel.frame) - size.height*scoreSpacing, NO);
    
    static CGFloat missionsTop = 0.05;
    static CGFloat missionsLeft = 0.44;
    static CGFloat missionsRight = 0.0;
    static CGFloat missionsBottom = 0.06;
    self.missionsView.frame = SKRectSetX(self.missionsView.frame, size.width*missionsLeft);
    self.missionsView.frame = SKRectSetY(self.missionsView.frame, size.height*missionsTop);
    self.missionsView.frame = SKRectSetRight(self.missionsView.frame, size.width - size.width*missionsRight, YES);
    self.missionsView.frame = SKRectSetBottom(self.missionsView.frame, size.height - size.height*missionsBottom, YES);
}

- (void)displayMissions:(NSArray *)missions {
    [self.missionsView displayMissions:missions];
    self.completionsLevel.text = [NSString stringWithFormat:@"%lu / %lu completed",
                                  (unsigned long)[[GameData sharedGameData].completedMissionsIndexes count],
                                  (unsigned long)[MissionsFactory allMissions].count];
}

- (void)updateScoreTo:(int)score {
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", score];
    self.highScoreLabel.text = [NSString stringWithFormat:@"%i", [GameData sharedGameData].highScore];
    [self setNeedsLayout];
}

@end
