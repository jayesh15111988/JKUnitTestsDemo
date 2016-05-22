//
//  JKSpecificCasteBridesProvider.m
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/22/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import <BlocksKit/NSArray+BlocksKit.h>
#import "JKBridesProvider.h"
#import "JKBride.h"
#import "JKSpecificCasteBridesProvider.h"

@implementation JKSpecificCasteBridesProvider

- (RACSignal*)filterBridesMatchingCaste:(NSString*)caste {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[JKBridesProvider brides] subscribeNext:^(NSArray<JKBride*>* x) {
            NSArray<JKBride*>* filteredBrides = [x bk_select:^BOOL(JKBride* obj) {
                return [obj.cast isEqualToString:caste];
            }];
            [subscriber sendNext:filteredBrides];
        }];
        return nil;
    }];
}

@end
