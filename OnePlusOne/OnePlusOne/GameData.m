//
//  GameData.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-07.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "GameData.h"

@interface GameData ()

@property (nonatomic) int highScore;
@property (nonatomic) int highestNumber;
@property (nonatomic) NSMutableArray *completedMissionsIndexes;

@end

@implementation GameData

static NSString * const GameDataCompletedMissionsKey = @"CompletedMissionsKey";
static NSString * const GameDataHighScoreKey = @"HighScoreKey";
static NSString * const GameDataHighestNumbereKey = @"HighestNumberKey";

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

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.completedMissionsIndexes forKey:GameDataCompletedMissionsKey];
    [encoder encodeInt:self.highScore forKey:GameDataHighScoreKey];
    [encoder encodeInt:self.highestNumber forKey:GameDataHighestNumbereKey];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if (self) {
        self.completedMissionsIndexes = [decoder decodeObjectForKey:GameDataCompletedMissionsKey] ? : [NSMutableArray new];
        self.highScore = [decoder decodeIntForKey:GameDataHighScoreKey];
        self.highestNumber = [decoder decodeIntForKey:GameDataHighestNumbereKey];
    }
    return self;
}

- (void)completedMissionAtIndex:(NSUInteger)index {
    [self.completedMissionsIndexes addObject:[NSNumber numberWithInteger:index]];
    [self save];
}

- (void)newScore:(int)score {
    if (score > self.highScore) {
        self.highScore = score;
        [self save];
    }
}

- (void)newNumber:(int)number {
    if (number > self.highestNumber) {
        self.highestNumber = number;
        [self save];
    }
}

- (void)reset {
    self.highScore = 0;
    self.highestNumber = 0;
    self.completedMissionsIndexes = [NSMutableArray new];
    [self save];
}

- (void)save {
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:self];
    [encodedData writeToFile:[GameData filePath] atomically:YES];
}

@end
