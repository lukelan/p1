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
#import "RecruitArticleViewController.h"
#import "SettingViewController.h"

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
    [self.smcMain setTitle:localizedString(@"Part-time Job") forSegmentAtIndex:1];
    
    //Tab A
    itemsA = [NSMutableArray array];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Company\nInformation") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Topic") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Economy") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"IT") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Medical Care・Welfare・Care") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Food, Service and Education") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Human Resources") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Social・Political") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Entertainment") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Financial\nReal Estate") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Job") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Bookmark") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Settings") type:ENUM_TAP_TYPE_SIMPLE contentView:nil]];
    
    //a bit difference with notification
    int marginRight = 1;
    int heightOfLabel = 17;
    UILabel *notificatonLabel = [[UILabel alloc] initWithFrame:CGRectMake(75 - heightOfLabel - marginRight, (35 - heightOfLabel)/2, heightOfLabel, heightOfLabel)];//75 is width of tab view, 35 is height of tabView
    notificatonLabel.backgroundColor = RGB(255, 150, 0);
    notificatonLabel.text = @"9";
    notificatonLabel.font = NORMAL_FONT_WITH_SIZE(12);
    notificatonLabel.textColor = [UIColor whiteColor];
    notificatonLabel.layer.cornerRadius = notificatonLabel.frame.size.width/2;
    notificatonLabel.layer.masksToBounds = YES;
    notificatonLabel.textAlignment = NSTextAlignmentCenter;
    [itemsA addObject:[HBTabItem initWithTitle:localizedString(@"Notifications") type:ENUM_TAP_TYPE_ADVANCE contentView:notificatonLabel]];

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
                
            case ENUM_CAREER_CHANGE_ECONOMY:
            {
                RecruitArticleViewController *tempVC = [[RecruitArticleViewController alloc] init];
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
                SettingViewController *tempVC = [[SettingViewController alloc] init];
                [self addViewController:tempVC];
                newVC = tempVC;
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
