//
//  ListCompanyInfoViewController.m
//  Giga
//
//  Created by Hoang Ho on 11/26/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "ListCompanyInfoViewController.h"
#import "ListCompanyCategoryViewController.h"
#import "BookmarkCompanyCell.h"
#import "CompanyModel.h"

#define BookmarkCompanyCellID               @"BookmarkCompanyCell"

@interface ListCompanyInfoViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *tableData;
}
@end

@implementation ListCompanyInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadInterface];
    [self loadData];
}

- (void)loadInterface{
    self.lbSearchCompany.text = localizedString(@"Search Company");
    self.lbBookmarkCompanies.text = localizedString(@"Bookmark Companies");
    [self.tbCompanyInfo registerNib:[UINib nibWithNibName:BookmarkCompanyCellID bundle:nil] forCellReuseIdentifier:BookmarkCompanyCellID];
    self.tbCompanyInfo.rowHeight = [BookmarkCompanyCell getCellHeight];
}

- (void)loadData{
    //sample Data
    //sample data
    tableData = [NSMutableArray array];
    for (int i = 1; i <= 50; i++) {
        NSString *categoryName = RANDOM_STRING((rand() % 10) + 5);
        NSString *companyName = RANDOM_STRING((rand() % 5) + 5);
        NSString *companyDes = RANDOM_STRING((rand() % 30) + 15);
        CompanyModel *company = [CompanyModel new];
        company.categoryName = categoryName;
        company.companyName = companyName;
        company.companyDes = companyDes;
        [tableData addObject:company];
    }
    [self.tbCompanyInfo reloadData];
}

- (IBAction)btnSearchCompanyTouchUpInside:(id)sender {
    ListCompanyCategoryViewController *searchCompanyVC = [[ListCompanyCategoryViewController alloc] init];
    searchCompanyVC.title = localizedString(@"Company Search");
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookmarkCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:BookmarkCompanyCellID];
    [cell applyStyleIfNeed];
    
    
    CompanyModel *company = tableData[indexPath.row];
    [cell setObject:company];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
