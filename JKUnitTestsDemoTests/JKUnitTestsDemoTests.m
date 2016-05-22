//
//  JKUnitTestsDemoTests.m
//  JKUnitTestsDemoTests
//
//  Created by Jayesh Kawli Backup on 5/21/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import <Specta/Specta.h>
#import <OCMock/OCMock.h>
#import <XCTest/XCTest.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <BlocksKit/NSArray+BlocksKit.h>
#import "JKSearchBrideViewController.h"
#import "JKBride.h"
#import "JKBridesSearchViewModel.h"
#import "JKBridesProvider.h"

SpecBegin(ViewModelTests)

__block NSArray<JKBride*>* brides;
__block JKBridesSearchViewModel* viewModel;
__block JKSearchBrideViewController* vc;
__block UINavigationController* navController;

beforeAll(^{
    
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
                   },
                   @{
                       @"first_name": @"Jacqueline",
                       @"last_name": @"Sharp",
                       @"city": @"Virar",
                       @"cast": @"Pachkalshi",
                       @"married": @0,
                       @"education": @"bachelors",
                       @"income": @10000
                   }
                   ]
        };
    
    brides = [bridesDict[@"brides"] bk_map:^id(id obj) {
        return [[JKBride alloc] initWithDictionary:obj];
    }];
    id classMock = OCMClassMock([JKBridesProvider class]);
    OCMStub(ClassMethod([classMock brides])).andReturn([RACSignal return:brides]);
    
    viewModel = [[JKBridesSearchViewModel alloc] init];
});

describe(@"Verifying the model creation", ^{
    
    it(@"Moel Creation", ^{
        JKBride* firstBride = [brides firstObject];
        JKBride* lastBride = [brides lastObject];
        
        XCTAssert([firstBride.name isEqualToString:@"Berta Johnson"]);
        XCTAssert([firstBride.city isEqualToString:@"Boston"]);
        XCTAssert([firstBride.cast isEqualToString:@"Wanjari"]);
        XCTAssert(firstBride.married == true);
        XCTAssert([firstBride.education isEqualToString:@"masters"]);
        
        XCTAssert([lastBride.name isEqualToString:@"Jacqueline Sharp"]);
        XCTAssert([lastBride.city isEqualToString:@"Virar"]);
        XCTAssert([lastBride.cast isEqualToString:@"Pachkalshi"]);
        XCTAssert(lastBride.married == false);
        XCTAssert([lastBride.education isEqualToString:@"bachelors"]);
        
    });
});


describe(@"Verifying view model creation", ^{
    it(@"View Model Creation", ^{
        JKBride* firstBride = viewModel.searchedBrides[0];
        XCTAssert([firstBride.name isEqualToString:@"Berta Johnson"]);
        XCTAssert([firstBride.city isEqualToString:@"Boston"]);
        XCTAssert([firstBride.cast isEqualToString:@"Wanjari"]);
        XCTAssert(firstBride.married == true);
        XCTAssert([firstBride.education isEqualToString:@"masters"]);
        
        JKBride* secondBride = viewModel.searchedBrides[1];
        XCTAssert([secondBride.name isEqualToString:@"Leena Crident"]);
        XCTAssert([secondBride.city isEqualToString:@"Pune"]);
        XCTAssert([secondBride.cast isEqualToString:@"CKP"]);
        XCTAssert(secondBride.married == false);
        XCTAssert([secondBride.education isEqualToString:@"bachelors"]);
    });
});

describe(@"Verifying the selection of row", ^{
    it(@"Bride Selection", ^{
        [viewModel selectBrideAtIndex:2];
        JKBride* selectedBride = viewModel.selectedBride;
        XCTAssert([selectedBride.name isEqualToString:@"Jacqueline Sharp"]);
        XCTAssert([selectedBride.city isEqualToString:@"Virar"]);
        XCTAssert([selectedBride.cast isEqualToString:@"Pachkalshi"]);
        XCTAssert(selectedBride.married == false);
        XCTAssert([selectedBride.education isEqualToString:@"bachelors"]);
    });

});

describe(@"Verifying is view is displayed on the screen", ^{
    
    before(^{
        navController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
        vc = (JKSearchBrideViewController*)navController.topViewController;
        vc.viewModel = viewModel;
        [UIApplication sharedApplication].keyWindow.rootViewController = navController;
    });
    
    it(@"Verifying the valid views", ^{
        XCTAssertNotNil(navController.topViewController);
        XCTAssertNotNil(vc.view);
    });
    
    it(@"Verifying the number of rows", ^{
        XCTAssert([vc tableView:[UITableView new] numberOfRowsInSection:0] == 3);
    });
    
    it(@"Verifying the cell model", ^{
        UITableViewCell* firstCell = [vc tableView:[UITableView new] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        XCTAssert([firstCell.textLabel.text isEqualToString:@"Berta Johnson"]);
        
        UITableViewCell* secondCell = [vc tableView:[UITableView new] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        XCTAssert([secondCell.textLabel.text isEqualToString:@"Leena Crident"]);
    });
    
    it(@"Verifying the cell selection makes appropriate model selected on search view model", ^{
        [vc tableView:[UITableView new] didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        JKBride* selectedBride = viewModel.selectedBride;
        XCTAssert([selectedBride.name isEqualToString:@"Berta Johnson"]);
        XCTAssert([selectedBride.city isEqualToString:@"Boston"]);
        XCTAssert([selectedBride.cast isEqualToString:@"Wanjari"]);
        XCTAssert(selectedBride.married == true);
        XCTAssert([selectedBride.education isEqualToString:@"masters"]);
    });

});


SpecEnd