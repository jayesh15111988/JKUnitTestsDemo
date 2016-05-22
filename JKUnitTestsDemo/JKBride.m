//
//  JKBride.m
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/21/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import "JKBride.h"

@implementation JKBride

- (instancetype)initWithDictionary:(NSDictionary*)brideInfo {
    self = [super init];
    if (!self) { return nil; }
    _name = [NSString stringWithFormat:@"%@ %@", brideInfo[@"first_name"], brideInfo[@"last_name"]];
    _city = brideInfo[@"city"];
    _cast = brideInfo[@"cast"];
    _married = [brideInfo[@"married"] boolValue];
    _education = brideInfo[@"education"];
    _income = [brideInfo[@"income"] integerValue];
    return self;
}

@end
