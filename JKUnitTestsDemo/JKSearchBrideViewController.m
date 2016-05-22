//
//  ViewController.m
//  JKUnitTestsDemo
//
//  Created by Jayesh Kawli Backup on 5/21/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <BlocksKit+UIKit.h>
#import "JKUnitTestingFilterViewController.h"
#import "JKBridesSearchViewModel.h"
#import "UISearchBar+RAC.h"
#import "JKBride.h"
#import "JKSearchBrideViewController.h"

@interface JKSearchBrideViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentationView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation JKSearchBrideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[JKBridesSearchViewModel alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"Filter" style:UIBarButtonItemStylePlain handler:^(id sender) {
        JKUnitTestingFilterViewController* filterVC = [[JKUnitTestingFilterViewController alloc] init];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:filterVC];
        [self presentViewController:nav animated:YES completion:NULL];
    }];
    [[[_searchBar rac_textSignal] ignore:nil] subscribeNext:^(id x) {
        _viewModel.searchString = x;
    }];
    
    [[_segmentationView rac_newSelectedSegmentIndexChannelWithNilValue:nil] subscribeNext:^(NSNumber* x) {
        _viewModel.searchByString  = [x integerValue] == 0 ? @"name" : @"cast";
    }];
    
    [[RACObserve(self.viewModel, searchedBrides) ignore:nil] subscribeNext:^(NSArray* brides) {
        [self.tableView reloadData];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.searchedBrides.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    JKBride* bride = _viewModel.searchedBrides[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", bride.name, bride.cast];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_viewModel selectBrideAtIndex:indexPath.row];
}

@end
