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
}

- (void)dealloc
{
    [self.tableData removeAllObjects];
    self.tableData = nil;
}

- (void)loadInterface
{
    customNavigation = [[CustomNavigationView alloc] initWithType:ENUM_NAVIGATION_TYPE_BACK frame:self.headerView.bounds];
    customNavigation.lbTitle.text = self.title;
    void(^actionCallback)(ENUM_NAVIGATION_ACTION_TYPE) = ^(ENUM_NAVIGATION_ACTION_TYPE type)
    {
        if (type == ENUM_NAVIGATION_TYPE_BACK) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    [customNavigation addActionHandler:actionCallback];
    [self.headerView addSubview:customNavigation];

    [self.tbCompanies registerNib:[UINib nibWithNibName:CompanyCellID bundle:nil] forCellReuseIdentifier:CompanyCellID];
    self.tbCompanies.rowHeight = [CompanyCell getCellHeight];
}

- (void)setTableData:(NSMutableArray *)tableData
{
    _tableData = tableData;
    [self.tbCompanies reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = self.tableData[section];
    NSArray *companies = dict[@"Companies"];
    return companies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:CompanyCellID];
    [cell applyStyleIfNeed];
    
    NSDictionary *dict = self.tableData[indexPath.section];
    NSArray *companies = dict[@"Companies"];
    
    CompanyModel *company = companies[indexPath.row];
    [cell setObject:company];
    
    return cell;
}

#define SECTION_HEIGHT 30.0f

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self tableView:tableView numberOfRowsInSection:section] == 0) {
        return 0;
    }
    return SECTION_HEIGHT;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, SECTION_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, SECTION_HEIGHT-1)];
    label.opaque = YES;
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    label.font = NORMAL_FONT_WITH_SIZE(15);
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    
    NSDictionary *dict = self.tableData[section];
    label.text = dict[@"CategoryName"];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(-20, SECTION_HEIGHT - 1, 400, 1)];
    lineImage.alpha = 0.8f;
    [lineImage setImage:[UIImage imageNamed:@"line-1"]];
    [view addSubview:lineImage];
    
    return view;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
