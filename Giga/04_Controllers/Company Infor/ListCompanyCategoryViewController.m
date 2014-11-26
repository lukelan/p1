//
//  SearchCompanyViewController.m
//  Giga
//
//  Created by Hoang Ho on 11/26/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "ListCompanyCategoryViewController.h"
#import "CustomNavigationView.h"
#import "CompanyCategoryCell.h"
#import "CompanyCategoryModel.h"
#import "ListCompanyViewController.h"


#define CompanyCategoryCellID           @"CompanyCategoryCell"

@interface ListCompanyCategoryViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    CustomNavigationView *customNavigation;
    NSMutableArray *tableData;
}
@end

@implementation ListCompanyCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadInterface];
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
    customNavigation.lbTitle.text = self.title;
    void(^actionCallback)(ENUM_NAVIGATION_ACTION_TYPE) = ^(ENUM_NAVIGATION_ACTION_TYPE type)
    {
        if (type == ENUM_NAVIGATION_TYPE_BACK) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    [customNavigation addActionHandler:actionCallback];
    [self.headerView addSubview:customNavigation];
    
    //
    self.searchView.layer.cornerRadius = 5.0f;
    self.searchView.layer.borderWidth = 1.0f;
    self.searchView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.tfSearchField.font = NORMAL_FONT_WITH_SIZE(14);
    self.tfSearchField.placeholder = localizedString(@"Search");
    
    [self.tbCategories registerNib:[UINib nibWithNibName:CompanyCategoryCellID bundle:nil] forCellReuseIdentifier:CompanyCategoryCellID];
    self.tbCategories.rowHeight = 51;
}

- (void)loadData
{
    //sample data
    tableData = [NSMutableArray array];
    for (int i = 1; i <= 50; i++) {
        NSString *categoryID = [NSString stringWithFormat:@"%d",i];
        NSString *categoryTitle = RANDOM_STRING((rand() % 10) + 5);
        CompanyCategoryModel *category = [CompanyCategoryModel new];
        category.categoryID = categoryID;
        category.categoryTitle = categoryTitle;
        [tableData addObject:category];
    }
    [self.tbCategories reloadData];
}

- (IBAction)btnSearchTouchUpInside:(id)sender {
    //sample
    ListCompanyViewController *tempVC = [[ListCompanyViewController alloc] init];
    [self.navigationController pushViewController:tempVC animated:YES];
    
    CompanyCategoryModel *category = tableData[0];
    tempVC.category = category;
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
    CompanyCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CompanyCategoryCellID];
    [cell applyStyleIfNeed];
    
    CompanyCategoryModel *category = tableData[indexPath.row];
    [cell setObject:category];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListCompanyViewController *tempVC = [[ListCompanyViewController alloc] init];
    [self.navigationController pushViewController:tempVC animated:YES];
    
    CompanyCategoryModel *category = tableData[indexPath.row];
    tempVC.category = category;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [self btnSearchTouchUpInside:self.btnSearch];
    return YES;
}

@end
