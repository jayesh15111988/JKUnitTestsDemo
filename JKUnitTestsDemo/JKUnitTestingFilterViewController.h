//
//  JKUnitTestingFilterViewController.h
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/22/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKUnitTestingFilterViewController : UIViewController

@property (nonatomic, strong) UIActivityIndicatorView* activityIndicatorView;
@property (nonatomic, strong) UITextField* nameField;
@property (nonatomic, strong) UITextField* passwordField;
@property (nonatomic, assign) BOOL invalidInputFlag;
@property (nonatomic, assign) BOOL actiAnimating;

- (void)toggleSpinner;
- (BOOL)validateFields;
- (void)showErrorMessage;

@end
