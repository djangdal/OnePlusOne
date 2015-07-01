//
//  GameData.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-07.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "GameData.h"

@interface GameData ()

//@property (nonatomic) int level;
//@property (nonatomic) int levelsUnlocked;

@end

@implementation GameData

//static NSString * const GameDataLevelKey = @"LevelKey";
//static NSString * const GameDataLevelsUnlockedKey = @"LevelsUnlockedKey";

+ (instancetype)sharedGameData {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self loadInstance];
    });
    
    return sharedInstance;
}

+ (NSString *)filePath {
    static NSString * filePath = nil;
    if (!filePath) {
        filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"gamedata"];
    }
    return filePath;
}

+ (instancetype)loadInstance {
    NSData *decodedData = [NSData dataWithContentsOfFile:[GameData filePath]];
    if (decodedData) {
        GameData *gameData = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
        return gameData;
    }
    
    return [[GameData alloc] init];
}

//- (void)levelUp {
//    self.level++;
//    if (self.level > self.levelsUnlocked) {
//        self.levelsUnlocked = self.level;
//    }
//    [self save];
//}

//- (void)goToLevel:(int)level {
//    if (level <= self.levelsUnlocked) {
//        self.level = level;
//        [self save];
//    }
//}

- (void)encodeWithCoder:(NSCoder *)encoder {
//    [encoder encodeInt:self.level forKey:GameDataLevelKey];
//    [encoder encodeInt:self.levelsUnlocked forKey:GameDataLevelsUnlockedKey];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if (self) {
//        self.level = [decoder decodeIntForKey:GameDataLevelKey];
//        self.levelsUnlocked = [decoder decodeIntForKey:GameDataLevelsUnlockedKey];
    }
    return self;
}

- (void)reset {
//    self.level = 1;
//    self.levelsUnlocked = 1;
    [self save];
}

- (void)save {
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:self];
    [encodedData writeToFile:[GameData filePath] atomically:YES];
}

//- (void)unlockAllLevels {
//    self.levelsUnlocked = 12;
//    [self save];
//}

@end
