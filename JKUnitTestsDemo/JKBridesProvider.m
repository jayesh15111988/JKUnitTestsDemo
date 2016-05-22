//
//  JKBridesProvider.m
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/21/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import <BlocksKit/NSArray+BlocksKit.h>
#import "JKBride.h"
#import "JKBridesProvider.h"

@implementation JKBridesProvider

+ (RACSignal*)brides {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"brides" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray<JKBride*>* brides = [json[@"brides"] bk_map:^id(NSDictionary* br) {
        return [[JKBride alloc] initWithDictionary:br];
    }];
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:brides];
        return nil;
    }] delay:1.0];
}

@end
