//
//  JKUnitTestingFilterViewController.m
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/22/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import <BlocksKit/BlocksKit+UIKit.h>
#import "JKUnitTestingFilterViewController.h"

@interface JKUnitTestingFilterViewController ()

@end

@implementation JKUnitTestingFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    [self.activityIndicatorView startAnimating];
    self.nameField = [[UITextField alloc] init];
    self.passwordField = [[UITextField alloc] init];
    
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemDone handler:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
}

- (void)toggleSpinner {    
    if ([self.activityIndicatorView isAnimating]) {
        [self.activityIndicatorView stopAnimating];
    } else {
        [self.activityIndicatorView startAnimating];
    }
    self.actiAnimating = !self.actiAnimating;
}

- (BOOL)validateFields {
    return (self.nameField.text.length > 5 && self.passwordField.text.length > 5);
}

@end
