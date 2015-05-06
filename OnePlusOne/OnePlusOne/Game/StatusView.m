//
//  StatusView.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-27.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "StatusView.h"
#import "HighScoreView.h"

@interface StatusView ()

@property (nonatomic) UILabel *scoreLabel;
@property (nonatomic) UILabel *nextNumberLabel;
@property (nonatomic) UIButton *restartButton;
@property (nonatomic) UIButton *quitButton;

@property (nonatomic) HighScoreView *highScoreView;

@property (nonatomic, weak) id<StatusViewDelegate> delegate;

@end

@implementation StatusView

CGFloat const kButtonWidth = 100;
CGFloat const kButtonHeight = 30;
CGFloat const kMargin = 30;

- (instancetype)initWithDelegate:(id<StatusViewDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.backgroundColor = [UIColor colorWithRed:1 green:0.68f blue:0 alpha:1];
        
        self.scoreLabel = [[UILabel alloc] init];
        [self updateScoreTo:0];
        [self addSubview:self.scoreLabel];
        
        self.nextNumberLabel = [[UILabel alloc] init];
        [self addSubview:self.nextNumberLabel];
        
        self.quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.quitButton.backgroundColor = [UIColor purpleColor];
        [self.quitButton setTitle:@"Quit" forState:UIControlStateNormal];
        [self.quitButton addTarget:self action:@selector(quitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.quitButton];
        
        self.restartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.restartButton.backgroundColor = [UIColor purpleColor];
        [self.restartButton setTitle:@"Restart" forState:UIControlStateNormal];
        [self.restartButton addTarget:self action:@selector(restartButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.restartButton];
        
        self.highScoreView = [[HighScoreView alloc] init];
        [self addSubview:self.highScoreView];
    }
    return self;
}

- (void)restartButtonPressed:(UIButton *)sender{
    [self.delegate resetButtonPressed];
}

- (void)quitButtonPressed:(UIButton *)sender{
    [self.delegate quitButtonPressed];
}

- (void)layoutSubviews{
    self.restartButton.frame = CGRectMake(kMargin/2, kMargin, kButtonWidth, kButtonHeight);
    
    self.quitButton.frame = CGRectMake(kMargin/2, CGRectGetMaxY(self.restartButton.frame)+kMargin , kButtonWidth, kButtonHeight);
    
    [self.scoreLabel sizeToFit];
    self.scoreLabel.frame = CGRectMake(kMargin/2, CGRectGetMaxY(self.quitButton.frame)+kMargin, self.scoreLabel.frame.size.width, self.scoreLabel.frame.size.height);
    
    [self.nextNumberLabel sizeToFit];
    self.nextNumberLabel.frame = CGRectMake(kMargin/2,CGRectGetMaxY(self.scoreLabel.frame)+kMargin, self.nextNumberLabel.frame.size.width, self.nextNumberLabel.frame.size.height);
    
    self.highScoreView.frame = CGRectMake(self.bounds.size.width/2-kMargin, kMargin/2, self.bounds.size.width/2+kMargin/2, self.bounds.size.height-kMargin);
}

- (void)updateScoreTo:(int)score{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", score];
    [self setNeedsLayout];
}

- (void)showNextNumber:(int)number {
    self.nextNumberLabel.text = [NSString stringWithFormat:@"Next number: %i", number];
    [self setNeedsLayout];
}

@end
