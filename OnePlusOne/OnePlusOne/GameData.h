//
//  GameData.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-07.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject <NSCoding>

//@property (nonatomic, readonly) int level;
//@property (nonatomic, readonly) int levelsUnlocked;

+ (instancetype)sharedGameData;
//- (void)goToLevel:(int)level;
//- (void)levelUp;
- (void)reset;
- (void)save;
//- (void)unlockAllLevels;

@end