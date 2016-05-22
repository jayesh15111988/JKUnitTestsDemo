//
//  UISearchBar+RAC.h
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/21/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (RAC)<UISearchBarDelegate>

- (RACSignal *)rac_textSignal;

@end
