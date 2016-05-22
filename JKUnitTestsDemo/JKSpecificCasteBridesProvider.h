//
//  JKSpecificCasteBridesProvider.h
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/22/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Foundation/Foundation.h>

@interface JKSpecificCasteBridesProvider : NSObject

- (RACSignal*)filterBridesMatchingCaste:(NSString*)caste;

@end
