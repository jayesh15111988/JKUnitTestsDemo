//
//  JKBridesSearchViewModel.h
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/21/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JKBride;

@interface JKBridesSearchViewModel : NSObject

@property (nonatomic, copy) NSArray<JKBride*>* searchedBrides;
@property (nonatomic, strong) JKBride* selectedBride;
@property (nonatomic, copy) NSString* searchByString;
@property (nonatomic, copy) NSString* searchString;

- (instancetype)init;
- (void)searchBrides;
- (void)selectBrideAtIndex:(NSInteger)index;

@end
