//
//  JKUnitTestingNetworkSutbs.m
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/22/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import "JKBride.h"
#import "JKBridesProvider.h"
#import "JKSpecificCasteBridesProvider.h"
#import <BlocksKit/NSArray+BlocksKit.h>
#import <OCMock.h>
#import <Specta.h>


SpecBegin(NetworkStubTests)

__block id networkRequestMock;
__block NSArray<JKBride*>* brides;

beforeAll(^{
    networkRequestMock = OCMClassMock([JKBridesProvider class]);
    
    NSDictionary* bridesDict = @{
                                 @"success": @1,
                                 @"brides": @[
                                         @{
                                             @"first_name": @"Berta",
                                             @"last_name": @"Johnson",
                                             @"city": @"Boston",
                                             @"cast": @"Wanjari",
                                             @"married": @1,
                                             @"education": @"masters",
                                             @"income": @60000
                                             },
                                         @{
                                             @"first_name": @"Leena",
                                             @"last_name": @"Crident",
                                             @"city": @"Pune",
                                             @"cast": @"CKP",
                                             @"married": @0,
                                             @"education": @"bachelors",
                                             @"income": @30000
                                             }
                                         ]
                                 };
    brides = [bridesDict[@"brides"] bk_map:^id(id obj) {
        return [[JKBride alloc] initWithDictionary:obj];
    }];
    
    OCMStub(ClassMethod([networkRequestMock brides])).andReturn([RACSignal return:brides]);
});

describe(@"Testing is filtering brides on specific caste gives desired result", ^{
    it(@"Testing the filtered brides data", ^{
        JKSpecificCasteBridesProvider* specificBrideProvider = [[JKSpecificCasteBridesProvider alloc] init];
        [[specificBrideProvider filterBridesMatchingCaste:@"CKP"] subscribeNext:^(NSArray* brides) {
            JKBride* filteredBride = [brides firstObject];
            XCTAssertTrue([filteredBride.name isEqualToString:@"Leena Crident"]);
            XCTAssertTrue([filteredBride.city isEqualToString:@"Pune"]);
            XCTAssertTrue([filteredBride.education isEqualToString:@"bachelors"]);
        }];
    });
});

SpecEnd
