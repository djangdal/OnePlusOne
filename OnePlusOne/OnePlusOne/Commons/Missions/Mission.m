//
//  Mission.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-07.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "Mission.h"
#import "GameState.h"

@interface Mission ()

@property (nonatomic, copy) void (^completionBlock)(GameState *, Mission *);
@property (nonatomic) NSString *descriptionText;
@end

@implementation Mission

- (instancetype)initWithDescription:(NSString *)description completionBlock:(void (^)(GameState *, Mission *))block {
    self = [super init];
    if (self) {
        self.completionBlock = block;
        self.descriptionText = description;
        self.missionState = MissionStateOngoing;
    }
    
    return self;
}

- (BOOL)completedForGameState:(GameState *)gameState {
    if (self.missionState != MissionStateCompleted) {
        self.completionBlock(gameState, self);
    }
    
    return self.missionState == MissionStateCompleted;
}

@end
