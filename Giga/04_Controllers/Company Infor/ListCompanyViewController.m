//
//  ListCompanyViewController.m
//  Giga
//
//  Created by Hoang Ho on 11/26/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "ListCompanyViewController.h"
#import "CustomNavigationView.h"
#import "CompanyCell.h"
#import "CompanyModel.h"
#import "CompanyCategoryModel.h"

#define CompanyCellID           @"CompanyCell"

@interface ListCompanyViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    CustomNavigationView *customNavigation;
    NSMutableArray *tableData;
}
@end

@implementation ListCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadInterface];
}

- (void)setCategory:(CompanyCategoryModel *)category
{
    _category =category;
    customNavigation.lbTitle.text = self.category.categoryTitle;
    
    [self loadData];
}

- (void)dealloc
{
    [tableData removeAllObjects];
    tableData = nil;
}

- (void)loadInterface
{
    customNavigation = [[CustomNavigationView alloc] initWithType:ENUM_NAVIGATION_TYPE_BACK frame:self.headerView.bounds];
    customNavigation.lbTitle.text = self.category.categoryTitle;
    void(^actionCallback)(ENUM_NAVIGATION_ACTION_TYPE) = ^(ENUM_NAVIGATION_ACTION_TYPE type)
    {
        if (type == ENUM_NAVIGATION_TYPE_BACK) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    [customNavigation addActionHandler:actionCallback];
    [self.headerView addSubview:customNavigation];

    [self.tbCompanies registerNib:[UINib nibWithNibName:CompanyCellID bundle:nil] forCellReuseIdentifier:CompanyCellID];
    self.tbCompanies.rowHeight = 101;
}

- (void)loadData
{
    //sample data
    tableData = [NSMutableArray array];
    for (int i = 1; i <= 50; i++) {
        NSString *categoryName = RANDOM_STRING((rand() % 10) + 5);
        NSString *companyName = RANDOM_STRING((rand() % 10) + 5);
        NSString *companyDes = RANDOM_STRING((rand() % 30) + 15);
        CompanyModel *company = [CompanyModel new];
        company.categoryName = categoryName;
        company.companyName = companyName;
        company.companyDes = companyDes;
        [tableData addObject:company];
    }
    [self.tbCompanies reloadData];
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
    CompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:CompanyCellID];
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
