//
//  HighScoreView.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-01.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "HighScoreView.h"
#import "HighScoreCell.h"
#import "StorageManager.h"

@interface HighScoreView ()

@property (nonatomic) StorageManager *storageManager;
@property (nonatomic) NSArray *highScores;

@end

@implementation HighScoreView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.storageManager = [StorageManager new];
        
        
//        [self.storageManager saveNewHighScore:@13 name:@"david"];
        
        self.highScores = [self.storageManager loadHighScores];
        
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"StandardCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:MyIdentifier];
    }
    NSDictionary *dict = [self.highScores objectAtIndex:indexPath.row];
    NSLog(@"dict %@",dict);
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [dict objectForKey:@"name"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [dict objectForKey:@"score"]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.highScores.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
