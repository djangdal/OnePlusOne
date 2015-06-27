//
//  MissionsFactory.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-07.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "MissionsFactory.h"
#import "Mission.h"
#import "GameState.h"

@implementation MissionsFactory

+ (NSArray *)missionsForLevel:(int)level {
    static NSArray *missions;
    if (!missions) {
        missions = [MissionsFactory allMissions];
    }
    return [missions objectAtIndex:level-1];
}

+ (NSArray *)allMissions {
    NSMutableArray *allMissions = [NSMutableArray new];
    
    { //Missions for level 1
        Mission *mission1 = [[Mission alloc] initWithDescription:@"Get 12 points in one game" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 12 ? MissionStateCompleted : MissionStateOngoing;
        }];
        [allMissions addObject:@[mission1]];
    }
    
    
    
    { //Missions for level 2
        Mission *mission1 = [[Mission alloc] initWithDescription:@"Get more then 40 points in one game" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore > 40 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission2 = [[Mission alloc] initWithDescription:@"Place seven 1 tiles before 9 points" completionBlock:^void(GameState *gameState, Mission *mission){
            static int count = 0;
            if (mission.resetMission) {
                count = 0;
                mission.resetMission = NO;
            }
            if (mission.missionState != MissionStateFailed) {
                count = gameState.lastPlacedValue == 1 ? count+1 : count;
                if (gameState.totalScore >= 9) {
                    mission.missionState = MissionStateFailed;
                } else {
                    mission.missionState = count >= 7 ? MissionStateCompleted : MissionStateOngoing;
                }
            }
        }];
        [allMissions addObject:@[mission1, mission2]];
    }
    
    
    
    { //Missions for level 3
        Mission *mission1 = [[Mission alloc] initWithDescription:@"Place and merge three 2 tiles" completionBlock:^void(GameState *gameState, Mission *mission){
            static int count = 0;
            if (mission.resetMission) {
                count = 0;
                mission.resetMission = NO;
            }
            if (gameState.lastPlacedValue == 2 && gameState.lastPlacedTile.cellValue > 2) {
                count++;
            }
            mission.missionState = count >= 3 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission2 = [[Mission alloc] initWithDescription:@"Always have atleast 3 tiles free, and get 30 points" completionBlock:^void(GameState *gameState, Mission *mission){
            __block int count = 0;
            if (mission.missionState != MissionStateFailed) {
                [gameState.grid enumerateObjectsUsingBlock:^(NSArray *row, NSUInteger idx, BOOL *stop) {
                    [row enumerateObjectsUsingBlock:^(GridCellView *cell, NSUInteger idx, BOOL *stop) {
                        count = cell.cellValue == 0 ? count+1 : count;
                    }];
                }];
                if (count < 2) {
                    mission.missionState = MissionStateFailed;
                    return;
                }
                mission.missionState = gameState.totalScore >= 30 ? MissionStateCompleted : MissionStateOngoing;
            }
        }];
        Mission *mission3 = [[Mission alloc] initWithDescription:@"Get atleast 50 points in one game" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 50 ? MissionStateCompleted : MissionStateOngoing;
        }];
        [allMissions addObject:@[mission1, mission2, mission3]];
    }
    
    
    
    { //Missions for level 4
        Mission *mission1 = [[Mission alloc] initWithDescription:@"Get 100 points in one game" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 100 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission2 = [[Mission alloc] initWithDescription:@"Get a 9 tile" completionBlock:^void(GameState *gameState, Mission *mission){
            if (mission.missionState != MissionStateFailed) {
                mission.missionState = gameState.lastPlacedTile.cellValue == 9 ? MissionStateCompleted : MissionStateOngoing;
            }
        }];
        Mission *mission3 = [[Mission alloc] initWithDescription:@"Gain 20 points from one tile" completionBlock:^void(GameState *gameState, Mission *mission){
            static int lastScore = 0;
            if (mission.resetMission) {
                lastScore = 0;
                mission.resetMission = NO;
            }
            if (gameState.totalScore - lastScore > 20) {
                mission.missionState = MissionStateCompleted;
            }
            lastScore = gameState.totalScore;
        }];
        [allMissions addObject:@[mission1, mission2, mission3]];
    }
    
    
    
    { //Missions for level 5
        Mission *mission1 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission2 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission3 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        [allMissions addObject:@[mission1, mission2, mission3]];
    }
    
    
    
    { //Missions for level 6
        Mission *mission1 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission2 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission3 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        [allMissions addObject:@[mission1, mission2, mission3]];
    }
    
    
    
    { //Missions for level 7
        Mission *mission1 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission2 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission3 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        [allMissions addObject:@[mission1, mission2, mission3]];
    }
    
    
    
    { //Missions for level 8
        Mission *mission1 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission2 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission3 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        [allMissions addObject:@[mission1, mission2, mission3]];
    }
    
    
    
    { //Missions for level 9
        Mission *mission1 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission2 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission3 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        [allMissions addObject:@[mission1, mission2, mission3]];
    }
    
    
    
    { //Missions for level 10
        Mission *mission1 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission2 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission3 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        [allMissions addObject:@[mission1, mission2, mission3]];
    }
    
    
    
    { //Missions for level 11
        Mission *mission1 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission2 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission3 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        [allMissions addObject:@[mission1, mission2, mission3]];
    }
    
    
    
    { //Missions for level 12
        Mission *mission1 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission2 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        Mission *mission3 = [[Mission alloc] initWithDescription:@"Do some epic shit" completionBlock:^void(GameState *gameState, Mission *mission){
            mission.missionState = gameState.totalScore >= 1 ? MissionStateCompleted : MissionStateOngoing;
        }];
        [allMissions addObject:@[mission1, mission2, mission3]];
    }
    
    return allMissions;
}

@end
