//
//  JKBridesSearchViewModel.m
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/21/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import "JKBridesProvider.h"
#import "JKBridesSearchViewModel.h"

@interface JKBridesSearchViewModel ()

@property (nonatomic, copy) NSArray<JKBride*>* brides;

@end

@implementation JKBridesSearchViewModel

- (instancetype)init {
    self = [super init];
    if (!self) { return nil; }
    _searchByString = @"name";
    _searchString = @"";
    [[JKBridesProvider brides] subscribeNext:^(id x) {
        self.brides = x;
        self.searchedBrides = x;
    }];
    
    [[RACObserve(self, searchByString) ignore:nil] subscribeNext:^(id x) {
        [self searchBrides];
    }];
    
    [[RACObserve(self, searchString) ignore:nil] subscribeNext:^(id x) {
        [self searchBrides];
    }];
    
    return self;
}

- (void)searchBrides {
    
    if ([_searchString isEqualToString:@""]) {
        self.searchedBrides = _brides;
    } else {
        NSPredicate* brideSearchPredicate = [NSPredicate predicateWithFormat:@"%K contains[cd] %@", _searchByString, _searchString];
        self.searchedBrides = [_brides filteredArrayUsingPredicate:brideSearchPredicate];
    }
}

- (void)selectBrideAtIndex:(NSInteger)index {
    _selectedBride = _searchedBrides[index];
}

@end
