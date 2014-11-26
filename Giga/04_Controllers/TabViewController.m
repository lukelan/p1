//
//  TabViewController.m
//  Giga
//
//  Created by Hoang Ho on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "TabViewController.h"
#import "HBTabBar.h"

#import "ListCompanyInfoViewController.h"
#import "ArticleViewController.h"
#import "BookmarksViewController.h"

#import "ArticleCategoryModel.h"

@interface TabViewController ()<HBTabBarDelegate>
{
    HBTabBar *hbTabBarA;
    HBTabBar *hbTabBarB;
    
    NSMutableArray *itemsA;
    NSMutableArray *itemsB;
    
    UIViewController *currentVC;
}

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadInterface];
}

- (void)loadInterface
{
    [self.smcMain setTitle:localizedString(@"Career Change") forSegmentAtIndex:0];
    [self.smcMain setTitle:localizedString(@"Part-time") forSegmentAtIndex:1];
    [self.smcMain setTitle:localizedString(@"Official Staff") forSegmentAtIndex:2];
    
    //Tab A
    itemsA = [NSMutableArray array];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Company Infor") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"New Topics") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Business") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Service") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Medical Line") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Nursing") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"IT-Creative") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Manual Labor") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Education") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Bookmark") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Settings") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    
    //a bit difference with notification
    UILabel *notificatonLabel = [[UILabel alloc] initWithFrame:CGRectMake(75 - 15, 0, 15, 15)];//75 is width of tab view
    notificatonLabel.backgroundColor = [UIColor redColor];
    notificatonLabel.text = @"10";
    notificatonLabel.layer.cornerRadius = notificatonLabel.frame.size.width/2;
    notificatonLabel.layer.masksToBounds = YES;
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Notification") type:ENUM_TAP_TYPE_ADVANCE contentView:notificatonLabel]];

    hbTabBarA = [[HBTabBar alloc] initWithWithFrame:self.tabContainerView.bounds items:itemsA];
    hbTabBarA.delegate = self;
    [self.tabContainerView addSubview:hbTabBarA];
    
    
//    itemsB = [NSMutableArray array];
//    for (int i = 0; i < [itemsA count]; i ++) {
//        [itemsB addObject:itemsA[i]];
//    }
//    hbTabBarB = [[HBTabBar alloc] initWithWithFrame:self.tabContainerView.bounds items:itemsB];
//    hbTabBarB.delegate = self;
//    [self.tabContainerView addSubview:hbTabBarB];
    
    hbTabBarB.hidden = YES;
    [hbTabBarA reloadData];
}

- (IBAction)smcValueChanged:(id)sender {
    
}

#pragma mark - HBTabBarDelegate

- (BOOL)HBTabBar:(HBTabBar*)tab shouldSelectAtIndex:(int)index
{
    return YES;
}

//ENUM_CAREER_CHANGE_BOOK_MARK,
//ENUM_CAREER_CHANGE_SETTINGS,
//ENUM_CAREER_CHANGE_NOTIFICATION

- (void)addViewController:(UIViewController*)vc
{
    [self addChildViewController:vc];
    
    vc.view.frame = self.contentView.bounds;
    
    [self.contentView addSubview:vc.view];
    [self.contentView bringSubviewToFront:vc.view];
}

- (void)HBTabBar:(HBTabBar*)tab didChangeItemIndex:(int)newIndex fromIndex:(int)oldIndex
{
    id newVC;
    if (tab == hbTabBarA) {
        switch (newIndex) {
            case ENUM_CAREER_CHANGE_COMPANY_INFO:
            {
                ListCompanyInfoViewController *tempVC = [[ListCompanyInfoViewController alloc] init];
                [self addViewController:tempVC];
                newVC = tempVC;
                break;
            }
                
            case ENUM_CAREER_CHANGE_BOOK_MARK:
            {
                BookmarksViewController *tempVC = [[BookmarksViewController alloc] init];
                [self addViewController:tempVC];
                newVC = tempVC;
                break;
            }
            
            case ENUM_CAREER_CHANGE_SETTINGS:
            {
                
                break;
            }
                
            case ENUM_CAREER_CHANGE_NOTIFICATION:
            {
                break;
            }
            default://list articles
            {
                ArticleViewController *articleVC = [ArticleViewController new];
                [self addViewController:articleVC];
                
                HBTabItem *item = itemsA[newIndex];
                ArticleCategoryModel *category = [ArticleCategoryModel new];
                category.categoryTitle = item.title;
                category.categoryID = [NSString stringWithFormat:@"%d",newIndex + 1];
                category.categoryType = newIndex + 1;
                articleVC.category = category;
                
                newVC = articleVC;
                break;
            }
        }
    }
    if (currentVC) {
        [currentVC removeFromParentViewController];
        [currentVC.view removeFromSuperview];
    }
    currentVC = newVC;
}
@end
