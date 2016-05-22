//
//  JKBride.h
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/21/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKBride : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* city;
@property (nonatomic, copy) NSString* cast;
@property (nonatomic, assign) BOOL married;
@property (nonatomic, copy) NSString* education;
@property (nonatomic, assign) NSInteger income;

- (instancetype)initWithDictionary:(NSDictionary*)brideInfo;

@end
