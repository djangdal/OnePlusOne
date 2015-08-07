//
//  MissionsHandler.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-07-17.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "MissionsHandler.h"
#import "MissionsFactory.h"
#import "Mission.h"
#import "GameData.h"

@interface MissionsHandler ()

@property (nonatomic) NSMutableArray *incompleteMissions;
@property (nonatomic) NSArray *allMissions;

@end

@implementation MissionsHandler

+ (instancetype)sharedHandler {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [MissionsHandler new];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.allMissions = [MissionsFactory allMissions];
        self.incompleteMissions = [NSMutableArray arrayWithArray:self.allMissions];
        
        NSMutableArray *completedMissionsIndexes = [[GameData sharedGameData] completedMissionsIndexes];
        NSMutableIndexSet *indexes = [NSMutableIndexSet new];
        [completedMissionsIndexes enumerateObjectsUsingBlock:^(NSNumber *index, NSUInteger idx, BOOL *stop) {
            [indexes addIndex:[index integerValue]];
        }];
        [self.incompleteMissions removeObjectsAtIndexes:indexes];
    }
    return self;
}

- (void)completedMission:(Mission *)mission {
    NSUInteger index = [self.allMissions indexOfObjectIdenticalTo:mission];
    [self.incompleteMissions removeObject:mission];
    [[GameData sharedGameData] completedMissionAtIndex:index];
}

- (NSArray *)currentMissions {
    if (self.incompleteMissions.count >= 3) {
        return @[[self.incompleteMissions objectAtIndex:0], [self.incompleteMissions objectAtIndex:1], [self.incompleteMissions objectAtIndex:2]];
    } else if (self.incompleteMissions.count >= 2) {
        return @[[self.incompleteMissions objectAtIndex:0], [self.incompleteMissions objectAtIndex:1]];
    } else if (self.incompleteMissions.count >= 1) {
        return @[[self.incompleteMissions objectAtIndex:0]];
    } else {
        return [NSArray new];
    }
}

//+ (NSArray *)nextMissions:(int)count {
//    NSArray *allMissions = [MissionsFactory allMissions];
//    NSMutableArray *missions = [NSMutableArray new];
//    int index = [[GameData sharedGameData] missionsCompleted];
//    while (missions.count < count && index < allMissions.count) {
//        [missions addObject:[allMissions objectAtIndex:index++]];
//    }
//    return missions;
//}

@end
