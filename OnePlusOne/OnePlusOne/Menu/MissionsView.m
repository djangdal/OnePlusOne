//
//  MissionsView.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-07.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "MissionsView.h"
#import "MissionView.h"

@interface MissionsView ()

@property (nonatomic) MissionView *missionView1;
@property (nonatomic) MissionView *missionView2;
@property (nonatomic) MissionView *missionView3;

@end

@implementation MissionsView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor defaultDarkColor];
        
        self.missionView1 = [MissionView new];
        self.missionView2 = [MissionView new];
        self.missionView3 = [MissionView new];
        
        [self addSubview:self.missionView1];
        [self addSubview:self.missionView2];
        [self addSubview:self.missionView3];
        
//        [self displayMissions:[MissionsFactory nextMissions:3]];
    }
    return self;
}

- (void)displayNewMissions:(NSArray *)missions duration:(NSTimeInterval)duration {
    CGRect origRect1 = self.missionView1.frame;
    CGRect origRect2 = self.missionView2.frame;
    CGRect origRect3 = self.missionView3.frame;
    [UIView animateWithDuration:duration animations:^{
        self.missionView1.alpha = 0;
        self.missionView2.alpha = 0;
        self.missionView3.alpha = 0;
    } completion:^(BOOL finished) {
        [self displayMissions:missions];
        self.missionView1.frame = SKRectSetY(self.missionView1.frame, CGRectGetMinY(self.missionView1.frame)+260);
        self.missionView2.frame = SKRectSetY(self.missionView2.frame, CGRectGetMinY(self.missionView2.frame)+260);
        self.missionView3.frame = SKRectSetY(self.missionView3.frame, CGRectGetMinY(self.missionView3.frame)+260);
        self.missionView1.alpha = 1;
        self.missionView2.alpha = 1;
        self.missionView3.alpha = 1;
        [UIView animateWithDuration:duration animations:^{
            self.missionView1.frame = origRect1;
            self.missionView2.frame = origRect2;
            self.missionView3.frame = origRect3;
        }];
    }];
}

- (void)displayMissions:(NSArray *)missions {
    self.missionView1.hidden = YES;
    self.missionView2.hidden = YES;
    self.missionView3.hidden = YES;
    [missions enumerateObjectsUsingBlock:^(Mission *mission, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            [self.missionView1 displayMission:mission];
        }
        if (idx == 1) {
            [self.missionView2 displayMission:mission];
        }
        if (idx == 2) {
            [self.missionView3 displayMission:mission];
        }
    }];
}

- (void)layoutSubviews {
    CGSize size = self.frame.size;
    static CGFloat missionTop = 0.0;
    static CGFloat missionLeft = 0.03;
    static CGFloat missionRight = 0.0;
    static CGFloat missionBottom = 0.0;
    static CGFloat missionHeight = 0.30;
    
    self.missionView1.frame = SKRectSetX(self.missionView1.frame, size.width*missionLeft);
    self.missionView1.frame = SKRectSetY(self.missionView1.frame, size.height*missionTop);
    self.missionView1.frame = SKRectSetRight(self.missionView1.frame, size.width - size.width*missionRight, YES);
    self.missionView1.frame = SKRectSetHeight(self.missionView1.frame, size.height*missionHeight);
    
    self.missionView2.frame = SKRectSetX(self.missionView2.frame, size.width*missionLeft);
    self.missionView2.frame = SKRectSetHeight(self.missionView2.frame, size.height*missionHeight);
    self.missionView2.frame = SKRectSetRight(self.missionView2.frame, size.width - size.width*missionRight, YES);
    self.missionView2.frame = SKRectCenterVerticallyInRect(self.missionView2.frame, self.frame);
    
    self.missionView3.frame = SKRectSetX(self.missionView3.frame, size.width*missionLeft);
    self.missionView3.frame = SKRectSetRight(self.missionView3.frame, size.width - size.width*missionRight, YES);
    self.missionView3.frame = SKRectSetHeight(self.missionView3.frame, size.height*missionHeight);
    self.missionView3.frame = SKRectSetBottom(self.missionView3.frame, size.height - size.height*missionBottom, NO);
    
}

@end
