//
//  StorageManager.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-01.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "StorageManager.h"

@interface StorageManager ()

@property NSUserDefaults *userDefaults;

@property (nonatomic) NSString *documentsDirectory;
@property (nonatomic) NSString *highScorePath;

@end

@implementation StorageManager

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [paths objectAtIndex:0];
        self.highScorePath = [self.documentsDirectory stringByAppendingPathComponent:@"HighScores"];
    }
    return self;
}

- (BOOL)saveNewHighScore:(NSNumber *)score name:(NSString *)name {
    NSArray *oldHighScores = [self loadHighScores];
    NSArray *newHighScores = [oldHighScores arrayByAddingObject:@{@"name": name, @"score": score}];
    return [newHighScores writeToFile:self.highScorePath atomically:YES];
}

- (NSArray *)loadHighScores {
    NSArray *highScores = [[NSArray alloc] initWithContentsOfFile:self.highScorePath];
    if (!highScores) {
        highScores = [NSArray new];
    }
    return highScores;
}

@end
