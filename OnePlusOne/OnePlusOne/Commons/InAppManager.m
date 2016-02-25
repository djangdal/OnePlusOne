//
//  InAppManager.m
//  OnePlusOne
//
//  Created by David Jangdal on 2016-02-13.
//  Copyright © 2016 David Jangdal. All rights reserved.
//

#import "InAppManager.h"
#import "GameData.h"
@interface InAppManager () <SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (nonatomic) NSUbiquitousKeyValueStore *storage;
@property (nonatomic) NSSet *productIdentifiers;

@property (nonatomic, readwrite) NSArray *products;
@end

@implementation InAppManager

+ (instancetype)sharedManager {
    static InAppManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [InAppManager new];
    });
    
    return sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.storage = [NSUbiquitousKeyValueStore defaultStore];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        self.productIdentifiers = [NSSet setWithObject:@"FullGame.NonConsumable"];
        self.products = [NSArray new];
        [self loadProducts];
    }
    return self;
}

- (void)removeTransactionObserver {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (void)loadProducts {
    NSLog(@"loading products");
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:self.productIdentifiers];
    request.delegate = self;
    [request start];
}

- (void)purchaseProduct:(SKProduct *)product {
    if(product)
        [[SKPaymentQueue defaultQueue] addPayment:[SKPayment paymentWithProduct:product]];
}

#pragma mark SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    if ([response.products count] > 0) {
        self.products = response.products;
        if (self.delegate != nil) {
            [self.delegate loadedProducts:self.products];
        }
    }
}

#pragma mark SKPaymentTransactionObserver

-(void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    NSLog(@"removed transactions");
    for (SKPaymentTransaction *transaction in transactions) {
        NSLog(@"removed: %@" ,transaction);
        if (self.delegate != nil) {
            [self.delegate finishedTransaction:transaction];
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    NSLog(@"got transaction");
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                break;
            case SKPaymentTransactionStateDeferred:
                break;
            case SKPaymentTransactionStateFailed:
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchased:
                [[GameData sharedGameData] unlockedFullGame];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [[GameData sharedGameData] unlockedFullGame];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            default:
                // For debugging
                NSLog(@"Unexpected transaction state %@", @(transaction.transactionState));
                break;
        }
    }
}

-(void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    NSLog(@"completed transtionc finished");
}

-(void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    NSLog(@"restorecompleted transactionfailed: %@", error);
}

@end
