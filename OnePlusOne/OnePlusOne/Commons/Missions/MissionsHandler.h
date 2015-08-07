//
//  MissionsHandler.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-07-17.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Mission;

@interface MissionsHandler : NSObject

+ (instancetype)sharedHandler;

- (NSArray *)currentMissions;
- (void)completedMission:(Mission *)mission;

@end
