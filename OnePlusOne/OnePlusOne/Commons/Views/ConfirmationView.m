//
//  ConfirmationView.m
//  OnePlusOne
//
//  Created by David Jangdal on 2016-01-26.
//  Copyright © 2016 David Jangdal. All rights reserved.
//

#import "ConfirmationView.h"
#import "UIColors+Application.h"

@interface ConfirmationView ()

@property (nonatomic) UIView *backgroundView;
@property (nonatomic) UIView *blurView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *messageLabel;
@property (nonatomic) UIButton *cancelButton;
@property (nonatomic) UIButton *confirmationButton;
@property (nonatomic, copy) void (^confirmationAction)();

@end

@implementation ConfirmationView

+ (void)DisplayConfirmationView:(NSString *)title
                        message:(NSString *)message
                   confirmTitle:(NSString *)confirmTitle
                  confirmAction:(void(^)())action {
    [self DisplayConfirmationView:title message:message confirmTitle:confirmTitle closeTitle:@"Cancel" confirmAction:action];
}

+ (void)DisplayConfirmationView:(NSString *)title
                        message:(NSString *)message
                   confirmTitle:(NSString *)confirmTitle
                     closeTitle:(NSString *)closeTitle
                  confirmAction:(void(^)())action {
    
    ConfirmationView* confirmationView = [ConfirmationView new];
    confirmationView.titleLabel.text = title;
    confirmationView.messageLabel.text = message;
    confirmationView.confirmationAction = action;
    [confirmationView.confirmationButton setTitle:confirmTitle forState:UIControlStateNormal];
    [confirmationView.cancelButton setTitle:closeTitle forState:UIControlStateNormal];
    
    [[UIApplication sharedApplication].keyWindow addSubview:confirmationView];
    confirmationView.frame = [UIApplication sharedApplication].keyWindow.rootViewController.view.bounds;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            self.backgroundView = [UIView new];
            self.backgroundView.backgroundColor = [UIColor defaultWhiteColor];
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            self.blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            self.blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        }
        else {
            self.backgroundColor = [UIColor defaultDarkColor];
        }
        
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.minimumScaleFactor = 0.5;
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.textColor = [UIColor defaultDarkColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.messageLabel = [UILabel new];
        self.messageLabel.font = [UIFont fontWithName:@"Helvetica" size:19];
        self.messageLabel.textColor = [UIColor defaultDarkColor];
        self.messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.minimumScaleFactor = 0.5;
        self.messageLabel.adjustsFontSizeToFitWidth = YES;
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelButton.backgroundColor = [UIColor defaultDarkColor];
        [self.cancelButton setTitleColor:[UIColor defaultWhiteColor] forState:UIControlStateNormal];
        [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
        
        self.confirmationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.confirmationButton.backgroundColor = [UIColor defaultDarkColor];
        [self.confirmationButton setTitleColor:[UIColor defaultWhiteColor] forState:UIControlStateNormal];
        [self.confirmationButton addTarget:self action:@selector(confirmationPressed) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.blurView];
        [self addSubview:self.backgroundView];
        [self.backgroundView addSubview:self.titleLabel];
        [self.backgroundView addSubview:self.messageLabel];
        [self.backgroundView addSubview:self.cancelButton];
        [self.backgroundView addSubview:self.confirmationButton];
    }
    return self;
}

- (void)layoutSubviews {
    self.blurView.frame = self.bounds;
    self.backgroundView.frame = CGRectMake(self.bounds.size.width*0.15, self.bounds.size.height*0.25, self.bounds.size.width*0.7, self.bounds.size.height*0.5);
    
    CGSize size = self.backgroundView.frame.size;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = SKRectSetWidth(self.titleLabel.frame, size.width*0.8);
    self.titleLabel.frame = SKRectCenterInRect(self.titleLabel.frame, self.backgroundView.frame);
    self.titleLabel.frame = SKRectSetY(self.titleLabel.frame, size.height*0.03f);
    
    static CGFloat messageMargins = 0.1;
    self.messageLabel.frame = SKRectSetY(self.messageLabel.frame, CGRectGetMaxY(self.titleLabel.frame) + size.height*0.02);
    self.messageLabel.frame = SKRectSetX(self.messageLabel.frame, size.width*messageMargins);
    self.messageLabel.frame = SKRectSetRight(self.messageLabel.frame, size.width - size.width*messageMargins, YES);
    self.messageLabel.frame = SKRectSetHeight(self.messageLabel.frame, size.height*0.3);
    
//    static CGFloat buttonBottom = 0.1;
//    static CGFloat buttonMargins = 0.05;
//    static CGFloat buttonWidth = 0.4;
//    static CGFloat buttonHeight = 0.1;
    
    static CGFloat buttonBottom = 0.08;
    static CGFloat buttonHeight = 0.15;
    static CGFloat buttonWidth = 0.75;
    
    self.cancelButton.frame = SKRectSetHeight(self.cancelButton.frame, size.width*buttonHeight);
    self.cancelButton.frame = SKRectSetWidth(self.cancelButton.frame, size.width*buttonWidth);
    self.cancelButton.frame = SKRectCenterHorizontallyInRect(self.cancelButton.frame, self.backgroundView.frame);
    self.cancelButton.frame = SKRectSetBottom(self.cancelButton.frame, size.height - size.height*buttonBottom, NO);
    
    self.confirmationButton.frame = SKRectSetHeight(self.confirmationButton.frame, size.width*buttonHeight);
    self.confirmationButton.frame = SKRectSetWidth(self.confirmationButton.frame, size.width*buttonWidth);
    self.confirmationButton.frame = SKRectCenterHorizontallyInRect(self.confirmationButton.frame, self.backgroundView.frame);
    self.confirmationButton.frame = SKRectSetBottom(self.confirmationButton.frame, CGRectGetMinY(self.cancelButton.frame) - size.height*buttonBottom, NO);
//    
//    self.confirmationButton.frame = SKRectSetHeight(self.confirmationButton.frame, size.width*buttonSize);
//    self.confirmationButton.frame = SKRectSetRight(self.confirmationButton.frame, size.width - size.width*buttonRight, YES);
//    self.confirmationButton.frame = SKRectSetX(self.confirmationButton.frame, size.width*buttonLeft);
//    self.confirmationButton.frame = SKRectSetBottom(self.confirmationButton.frame, CGRectGetMinY(self.cancelButton.frame) - size.height*buttonBottom, NO);
    
//    self.confirmationButton.frame = SKRectSetWidth(self.confirmationButton.frame, size.width*buttonWidth);
//    self.confirmationButton.frame = SKRectSetHeight(self.confirmationButton.frame, size.width*buttonHeight);
//    self.confirmationButton.frame = SKRectSetRight(self.confirmationButton.frame, size.width - size.width*buttonMargins, NO);
//    self.confirmationButton.frame = SKRectSetBottom(self.confirmationButton.frame, size.height - size.height*buttonBottom, NO);
    
}

- (void)cancelPressed {
    [self removeFromSuperview];
}

- (void)confirmationPressed {
    self.confirmationAction();
    [self removeFromSuperview];
}


@end
