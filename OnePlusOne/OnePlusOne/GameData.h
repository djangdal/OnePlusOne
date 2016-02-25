//
//  GameData.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-07.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject <NSCoding>

@property (nonatomic, readonly) NSMutableArray *completedMissionsIndexes;
@property (nonatomic, readonly) int highScore;
@property (nonatomic, readonly) int highestNumber;
@property (nonatomic, readonly) BOOL level2Unlocked;
@property (nonatomic, readonly) BOOL level3Unlocked;
@property (nonatomic, readonly) BOOL fullGameUnlocked;

@property (nonatomic, readonly) int level2ScoreRequired;
@property (nonatomic, readonly) int level3ScoreRequired;

+ (instancetype)sharedGameData;
- (void)completedMissionAtIndex:(NSUInteger)index;
- (void)newScore:(int)score;
- (void)unlockedFullGame;
- (void)unlockedLevel2;
- (void)unlockedLevel3;
- (void)reset;
- (void)save;

@end