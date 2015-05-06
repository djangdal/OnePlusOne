//
//  StorageManager.h
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-01.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageManager : NSObject

- (BOOL)saveNewHighScore:(NSNumber *)score name:(NSString *)name;
- (NSArray *)loadHighScores;

@end
