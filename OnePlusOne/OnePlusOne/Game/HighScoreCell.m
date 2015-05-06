//
//  HighScoreCell.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-01.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "HighScoreCell.h"

@interface HighScoreCell ()

@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *scoreLabel;

@end

@implementation HighScoreCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"init");
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setScore

@end
