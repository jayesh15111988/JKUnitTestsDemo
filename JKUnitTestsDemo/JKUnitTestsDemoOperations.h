//
//  JKUnitTestsDemoOperations.h
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/21/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JKUnitTestsFileOperationDelegate <NSObject>

- (void)printOperation;

@end

typedef void (^Block)();

@interface JKUnitTestsDemoOperations : NSObject<JKUnitTestsFileOperationDelegate>

@property (nonatomic, assign) BOOL operationComplete;

- (NSInteger)addNumbers:(NSInteger)num1 andNum2:(NSInteger)num2;
+ (NSInteger)multiplyNumbers:(NSInteger)num1 andNum2:(NSInteger)num2;
- (NSString*)myName;
- (NSString*)invocationAlternateMethod:(NSString*)brideName;
- (void)asyncOperationWithBlock:(Block)block;

@end