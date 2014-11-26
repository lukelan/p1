//
//  ListCompanyInfoViewController.m
//  Giga
//
//  Created by Hoang Ho on 11/26/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "ListCompanyInfoViewController.h"
#import "ListCompanyCategoryViewController.h"

@interface ListCompanyInfoViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *tableData;
}
@end

@implementation ListCompanyInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnSearchCompanyTouchUpInside:(id)sender {
    ListCompanyCategoryViewController *searchCompanyVC = [[ListCompanyCategoryViewController alloc] init];
    searchCompanyVC.title = localizedString(@"Search Company");
    [self.parentViewController.navigationController pushViewController:searchCompanyVC animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
