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

+ (instancetype)sharedGameData;
- (void)completedMissionAtIndex:(NSUInteger)index;
- (void)newScore:(int)score;
- (void)reset;
- (void)save;

@end