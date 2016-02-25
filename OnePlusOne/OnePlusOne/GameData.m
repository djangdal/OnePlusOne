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
@property (nonatomic) BOOL fullGameUnlocked;
@property (nonatomic) BOOL level2Unlocked;
@property (nonatomic) BOOL level3Unlocked;
@property (nonatomic) NSMutableArray *completedMissionsIndexes;

@property (nonatomic) int level2ScoreRequired;
@property (nonatomic) int level3ScoreRequired;

@end

@implementation GameData

static NSString * const GameDataCompletedMissionsKey = @"CompletedMissionsKey";
static NSString * const GameDataHighScoreKey = @"HighScoreKey";
static NSString * const GameDataHighestNumbereKey = @"HighestNumberKey";
static NSString * const GameDataFullGameUnlockedKey = @"FullGameUnlockedKey";
static NSString * const GameDataLevel2UnlockedKey = @"GameDataLevel2UnlockedKey";
static NSString * const GameDataLevel3UnlockedKey = @"GameDataLevel3UnlockedKey";

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
    [encoder encodeBool:self.fullGameUnlocked forKey:GameDataFullGameUnlockedKey];
    [encoder encodeBool:self.level2Unlocked forKey:GameDataLevel2UnlockedKey];
    [encoder encodeBool:self.level3Unlocked forKey:GameDataLevel3UnlockedKey];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if (self) {
        self.completedMissionsIndexes = [decoder decodeObjectForKey:GameDataCompletedMissionsKey] ? : [NSMutableArray new];
        self.highScore = [decoder decodeIntForKey:GameDataHighScoreKey];
        self.highestNumber = [decoder decodeIntForKey:GameDataHighestNumbereKey];
        self.fullGameUnlocked = [decoder decodeBoolForKey:GameDataFullGameUnlockedKey];
        self.level2Unlocked = [decoder decodeBoolForKey:GameDataLevel2UnlockedKey];
        self.level3Unlocked = [decoder decodeBoolForKey:GameDataLevel3UnlockedKey];
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.level2ScoreRequired = 60;
    self.level3ScoreRequired = 430;
}

- (void)unlockedFullGame {
    self.fullGameUnlocked = true;
    [self save];
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

- (void)unlockedLevel2 {
    self.level2Unlocked = true;
    [self save];
}

- (void)unlockedLevel3 {
    self.level3Unlocked = true;
    [self save];
}

- (void)reset {
    self.highScore = 0;
    self.highestNumber = 0;
    self.level2Unlocked = false;
    self.level3Unlocked = false;
    self.fullGameUnlocked = false;
    self.completedMissionsIndexes = [NSMutableArray new];
    [self save];
}

- (void)save {
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:self];
    [encodedData writeToFile:[GameData filePath] atomically:YES];
}

@end
