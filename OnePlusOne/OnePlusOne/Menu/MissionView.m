//
//  MissionView.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-05.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "MissionView.h"
#import "UIBezierPath+Paths.h"
#import "UIBezierPath+Helpers.h"
#import "PathView.h"
#import "Mission.h"

@interface MissionView ()

@property (nonatomic) PathView *statusView;
@property (nonatomic) UILabel *descriptionLabel;

@end

@implementation MissionView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.statusView = [[PathView alloc] initWithPath:[UIBezierPath checkMarkOnGoingPath] color:[UIColor defaultLightColor]];
        [self addSubview:self.statusView];
        
        self.descriptionLabel = [UILabel new];
        self.descriptionLabel.font = [UIFont fontWithName:@"helvetica" size:14];
        self.descriptionLabel.minimumScaleFactor = 0.8;
        self.descriptionLabel.numberOfLines = 2;
        self.descriptionLabel.adjustsFontSizeToFitWidth = YES;
        self.descriptionLabel.textColor = [UIColor defaultLightColor];
        [self addSubview:self.descriptionLabel];
    }
    return self;
}

- (void)displayMission:(Mission *)mission {
    self.hidden = NO;
    self.descriptionLabel.text = mission.descriptionText;
    if (mission.missionState == MissionStateOngoing) {
        self.statusView.path = [UIBezierPath checkMarkOnGoingPath];
    } else if (mission.missionState == MissionStateFailed) {
        self.statusView.path = [UIBezierPath checkMarkFailedPath];
    } else if (mission.missionState == MissionStateCompleted) {
        self.statusView.path = [UIBezierPath checkMarkCompletedPath];
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    CGSize size = self.frame.size;
    static CGFloat statusTop = 0.23;
    static CGFloat statusLeft = 0.03;
    static CGFloat statusBottom = 0.23;
    static CGFloat statusWidth = 0.10;
    self.statusView.frame = SKRectSetX(self.statusView.frame, size.width*statusLeft);
    self.statusView.frame = SKRectSetY(self.statusView.frame, size.height*statusTop);
    self.statusView.frame = SKRectSetWidth(self.statusView.frame, size.width*statusWidth);
    self.statusView.frame = SKRectSetBottom(self.statusView.frame, size.height - size.height*statusBottom, YES);
    
    static CGFloat descriptionTop = 0.06;
    static CGFloat descriptionLeft = 0.02;
    static CGFloat descriptionRight = 0.05;
    static CGFloat descriptionBottom = 0.05;
    self.descriptionLabel.frame = SKRectSetX(self.descriptionLabel.frame, CGRectGetMaxX(self.statusView.frame) + size.width*descriptionLeft);
    self.descriptionLabel.frame = SKRectSetY(self.descriptionLabel.frame, size.height*descriptionTop);
    self.descriptionLabel.frame = SKRectSetRight(self.descriptionLabel.frame, size.width - size.width*descriptionRight, YES);
    self.descriptionLabel.frame = SKRectSetBottom(self.descriptionLabel.frame, size.height - size.height*descriptionBottom, YES);
}

@end
