//
//  JKUnitTestsDemoOperations.m
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/21/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import "JKUnitTestsDemoOperations.h"

@implementation JKUnitTestsDemoOperations

- (NSInteger)addNumbers:(NSInteger)num1 andNum2:(NSInteger)num2 {
    return num1 + num2;
}

+ (NSInteger)multiplyNumbers:(NSInteger)num1 andNum2:(NSInteger)num2 {
    return num1 * num2;
}

- (void)printOperation {
    NSLog(@"We are having some important operation right now");
}

- (NSString*)myName {
    return @"Jayesh Kawli";
}

- (NSString*)invocationAlternateMethod:(NSString*)brideName {
    return @"Chitali";
}

- (void)asyncOperationWithBlock:(Block)block {
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.operationComplete = YES;
        block();
    });
    
}

@end
