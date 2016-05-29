//
//  JKUnitTestsViewOperationsTests.m
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/21/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import <Specta/Specta.h>
#import <OCMock.h>
#import "JKUnitTestsDemoOperations.h"
#import "JKUnitTestsAlternativeOperation.h"

SpecBegin(OperationTests)

__block id operation;
__block JKUnitTestsAlternativeOperation* alternate;

describe(@"Verifying the demo operations class functionality", ^{
    beforeAll(^{
        operation = OCMClassMock([JKUnitTestsDemoOperations class]);
        alternate = OCMClassMock([JKUnitTestsAlternativeOperation class]);
        
        OCMStub([operation addNumbers:10 andNum2:30]).andReturn(40);
        OCMStub(ClassMethod([operation multiplyNumbers:10 andNum2:300])).andReturn(3000);
        OCMStub([alternate alwaysReturns1000]).andReturn(@"1000");
        OCMStub([operation myName]).andCall(alternate, @selector(alwaysReturns1000));
        
        [[[operation stub] andDo:^(NSInvocation* invocation) {
            NSString* firstArgument = nil;
            [invocation getArgument:&firstArgument atIndex:2];
            NSString* updatedReturnValue = [NSString stringWithFormat:@"%@ Appended to value", firstArgument];
            [invocation setReturnValue:&updatedReturnValue];
        }] invocationAlternateMethod:@"Leela"];
        
    });
    
    it(@"Verifying Mocking instance methods", ^{
        XCTAssert([operation addNumbers:10 andNum2:30] == 40);
    });
    
    it(@"Verifying Mocking class methods", ^{
        XCTAssert([JKUnitTestsDemoOperations multiplyNumbers:10 andNum2:300] == 3000);
    });
    
    it(@"Verifying the method calling bypass", ^{
        XCTAssert([[operation myName] isEqualToString:@"1000"]);
    });
    
    it(@"Verifying Block delegate using OCMock", ^{
        XCTAssert([[operation invocationAlternateMethod:@"Leela"] isEqualToString:@"Leela Appended to value"], @"Failed Failed failed");
    });
    
    it(@"Asynchronous Test", ^{
        JKUnitTestsDemoOperations* operation = [[JKUnitTestsDemoOperations alloc] init];
        XCTAssert(operation.operationComplete == NO);
        waitUntilTimeout(5.0, ^(DoneCallback done) {
            [operation asyncOperationWithBlock:^{
                XCTAssert(operation.operationComplete == YES);
                done();
            }];
        });
    });
    
});

SpecEnd
