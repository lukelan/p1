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
#import "CompanyModel.h"

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
    self.searchView.layer.borderWidth = 1.5f;
    self.searchView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.tfSearchField.font = NORMAL_FONT_WITH_SIZE(14);
    self.tfSearchField.placeholder = localizedString(@"Search by company name");
    
    [self.tbCategories registerNib:[UINib nibWithNibName:CompanyCategoryCellID bundle:nil] forCellReuseIdentifier:CompanyCategoryCellID];
    self.tbCategories.rowHeight = [CompanyCategoryCell getCellHeight];
}

- (void)loadData
{
    //sample data
    tableData = [NSMutableArray array];
    for (int i = 1; i <= 50; i++) {
        NSString *categoryID = [NSString stringWithFormat:@"%d",i];
        NSString *categoryTitle = RANDOM_STRING((rand() % 4) + 5);
        CompanyCategoryModel *category = [CompanyCategoryModel new];
        category.categoryID = categoryID;
        category.categoryTitle = categoryTitle;
        [tableData addObject:category];
    }
    [self.tbCategories reloadData];
}

- (IBAction)btnSearchTouchUpInside:(id)sender {
    ListCompanyViewController *tempVC = [[ListCompanyViewController alloc] init];
    tempVC.title = localizedString(@"Company Search Result");
    [self.navigationController pushViewController:tempVC animated:YES];
    
    //sample
    NSMutableArray *listData = [NSMutableArray array];
    int numberSection = 5;
    for (int i = 0; i < numberSection; i++) {
        CompanyCategoryModel *category = tableData[i];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:category.categoryTitle forKey:@"CategoryName"];
        NSMutableArray* listCompany = [NSMutableArray array];
        for (int j = 1; j <= ((rand() % 20) + 10); j++) {
            NSString *companyName = RANDOM_STRING((rand() % 10) + 5);
            NSString *companyDes = RANDOM_STRING((rand() % 30) + 15);
            CompanyModel *company = [CompanyModel new];
            company.categoryName = category.categoryTitle;
            company.companyName = companyName;
            company.companyDes = companyDes;
            [listCompany addObject:company];
        }
        [dict setObject:listCompany forKey:@"Companies"];
        
        [listData addObject:dict];
    }
    tempVC.tableData = listData;
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
    CompanyCategoryModel *category = tableData[indexPath.row];
    
    ListCompanyViewController *tempVC = [[ListCompanyViewController alloc] init];
    tempVC.title = localizedString(@"Company Search Result");
    [self.navigationController pushViewController:tempVC animated:YES];
    
    tempVC.category = category;
    
    NSString *categoryName = category.categoryTitle;
    
    //sample data
    NSMutableArray *listData = [NSMutableArray array];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:categoryName forKey:@"CategoryName"];
    NSMutableArray* listCompany = [NSMutableArray array];
    for (int i = 1; i <= 50; i++) {
        NSString *companyName = RANDOM_STRING((rand() % 10) + 5);
        NSString *companyDes = RANDOM_STRING((rand() % 30) + 15);
        CompanyModel *company = [CompanyModel new];
        company.categoryName = categoryName;
        company.companyName = companyName;
        company.companyDes = companyDes;
        [listCompany addObject:company];
    }
    [dict setObject:listCompany forKey:@"Companies"];
    
    [listData addObject:dict];
    tempVC.tableData = listData;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [self btnSearchTouchUpInside:self.btnSearch];
    return YES;
}

@end
