//
//  ConfirmationView.h
//  OnePlusOne
//
//  Created by David Jangdal on 2016-01-26.
//  Copyright © 2016 David Jangdal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmationView : UIView

+ (void)DisplayConfirmationView:(NSString *)title
                        message:(NSString *)message
                   confirmTitle:(NSString *)confirmTitle
                  confirmAction:(void(^)())action;

+ (void)DisplayConfirmationView:(NSString *)title
                        message:(NSString *)message
                   confirmTitle:(NSString *)confirmTitle
                     closeTitle:(NSString *)closeTitle
                  confirmAction:(void(^)())action;
@end
