//
//  GameData.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-07.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "GameData.h"

@interface GameData ()

@property (nonatomic) int level;

@end

@implementation GameData

static NSString * const GameDataLevelKey = @"LevelKey";

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

- (void)levelUp {
    self.level++;
    [self save];
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:self.level forKey:GameDataLevelKey];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if (self) {
        self.level = [decoder decodeIntForKey:GameDataLevelKey];
    }
    return self;
}

- (void)reset {
    self.level = 1;
    [self save];
}

- (void)save {
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:self];
    [encodedData writeToFile:[GameData filePath] atomically:YES];
}

@end
