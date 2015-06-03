//
//  Mission.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-07.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MissionStateOngoing,
    MissionStateFailed,
    MissionStateCompleted,
} MissionState;

@class GameState;

@interface Mission : NSObject

- (instancetype)initWithDescription:(NSString *)description completionBlock:(void (^)(GameState *, Mission *))block;

@property (nonatomic, readonly) NSString *descriptionText;
@property (nonatomic) MissionState missionState;
@property (nonatomic) BOOL resetMission;

- (BOOL)completedForGameState:(GameState *)gameState;

@end
