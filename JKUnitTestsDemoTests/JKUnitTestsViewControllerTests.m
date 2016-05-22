//
//  JKUnitTestsViewControllerTests.m
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/22/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import <Specta/Specta.h>
#import <OCMock/OCMock.h>
#import <XCTest/XCTest.h>
#import "JKUnitTestingFilterViewController.h"

@interface JKUnitTestsViewControllerTests : XCTestCase

@property (nonatomic, strong) id mockFilterViewController;
@property (nonatomic, strong) JKUnitTestingFilterViewController* filterVC;

@end

@implementation JKUnitTestsViewControllerTests

- (void)setUp {
    [super setUp];
    self.filterVC = [[JKUnitTestingFilterViewController alloc] init];
    self.mockFilterViewController = [OCMockObject partialMockForObject:self.filterVC];
}

- (void)testValidValues {
    id nameField = [OCMockObject mockForClass:[UITextField class]];
    [[[nameField stub] andReturn:@"asdadasda"] text];
    id passwordField = [OCMockObject mockForClass:[UITextField class]];
    [[[passwordField stub] andReturn:@"asdasdasd as das"] text];
    OCMStub([self.mockFilterViewController nameField]).andReturn(nameField);
    OCMStub([self.mockFilterViewController passwordField]).andReturn(passwordField);
    XCTAssertEqual([self.mockFilterViewController validateFields], YES);
}

- (void)testInvalidValues {
    id nameField = [OCMockObject mockForClass:[UITextField class]];
    [[[nameField stub] andReturn:@""] text];
    id passwordField = [OCMockObject mockForClass:[UITextField class]];
    [[[passwordField stub] andReturn:@""] text];
    OCMStub([self.mockFilterViewController nameField]).andReturn(nameField);
    OCMStub([self.mockFilterViewController passwordField]).andReturn(passwordField);
    XCTAssertEqual([self.mockFilterViewController validateFields], NO);
}

- (void)testSpinnerLoad {
    XCTAssertEqual([self.mockFilterViewController actiAnimating], NO);
    [self.mockFilterViewController toggleSpinner];
    XCTAssertEqual([self.mockFilterViewController actiAnimating], YES);
}

@end
