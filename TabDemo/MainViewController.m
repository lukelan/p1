//
//  MainViewController.m
//  DemoApp
//
//  Created by Hoang Ho on 11/18/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "MainViewController.h"
#import "HBTabBar.h"
#import "DemoView.h"
#import "SampleModel.h"
#import "HBMacros.h"

#import "SettingsView.h"
#import "DemoDetailViewController.h"

@interface MainViewController ()<HBTabBarDelegate, DemoViewDelegate, UIWebViewDelegate>
{
   HBTabBar *hbTabBarA;
   HBTabBar *hbTabBarB;
   
   NSMutableArray *itemsA;
   NSMutableArray *itemsB;
   
   DemoView *currentView;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   
   //Tab A
   itemsA = [NSMutableArray array];
    NSArray *strs = @[@"上場\n企業情報", @"トピック", @"経済", @"IT", @"医療・福祉・介護", @"食・サービス・教育", @"人事", @"社会・政治", @"芸能", @"金融・不動産", @"求人", @"ブクマ", @"設定", @"お知らせ", @"Noブクマ"];
   for (int i = 0; i < [strs count]; i ++) {
      [itemsA addObject:strs[i]];
   }
   hbTabBarA = [[HBTabBar alloc] initWithWithFrame:self.tabContainerView.bounds items:itemsA];
   hbTabBarA.delegate = self;
   [self.tabContainerView addSubview:hbTabBarA];
   
   
   itemsB = [NSMutableArray array];
    for (int i = 0; i < [strs count]; i ++) {
        [itemsB addObject:strs[i]];
    }
   hbTabBarB = [[HBTabBar alloc] initWithWithFrame:self.tabContainerView.bounds items:itemsB];
   hbTabBarB.delegate = self;
   [self.tabContainerView addSubview:hbTabBarB];
   
   hbTabBarB.hidden = YES;
   [hbTabBarA reloadData];
}

- (IBAction)scMainValueChanged:(id)sender {
   if(hbTabBarA.hidden){
      hbTabBarA.hidden = NO;
      hbTabBarB.hidden = YES;
      [hbTabBarA reloadData];
   }else{
      hbTabBarB.hidden = NO;
      hbTabBarA.hidden = YES;
      [hbTabBarB reloadData];
   }
}

#pragma mark - HBTabBarDelegate

- (BOOL)HBTabBarShouldSelectAtIndex:(int)index
{
   return YES;
}

- (void)HBTabBarDidChangeItemIndex:(int)newIndex fromIndex:(int)oldIndex
{
//   NSString *imageName = nil;
//    switch (newIndex) {
//        case 0:
//            imageName = @"image-sample-01";
//            break;
//        case 1:
//            imageName = @"image-sample-02";
//            break;
//        case 2:
//            imageName = @"image-sample-03";
//            break;
//        case 3:
//            imageName = @"image-sample-04";
//            break;
//        case 4:
//            imageName = @"image-sample-05";
//            break;
//            
//        default:
//            break;
//    }
    
    switch (newIndex) {
        case 12: // setting
        {
            SettingsView *aView = [SettingsView new];
            aView.frame = self.contentView.bounds;
            [self.contentView addSubview:aView];
            [self.contentView bringSubviewToFront:aView];
            
            if (currentView) {
                [currentView removeFromSuperview];
            }
        }
            break;
            
        default:
        {
            int numberItem = (rand() % 20) + 15;
            DemoView *aView = [[DemoView alloc] initWithNumberData:numberItem];
            aView.delegate =self;
            aView.frame = self.contentView.bounds;
            [self.contentView addSubview:aView];
            [self.contentView bringSubviewToFront:aView];
            
            if (currentView) {
                [currentView removeFromSuperview];
            }
            currentView = aView;
        }
            break;
    }

    
}


#pragma mark - ROTATE


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (BOOL) automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers
{
   return YES;
}

//For iO6

// iOS 6.x and later
- (BOOL)shouldAutorotate {
   if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft ||
       [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
      return NO;
   }
   if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) {
      return YES;
   }
   return NO;
}
//for ios 7
- (NSUInteger)supportedInterfaceOrientations {
   //for ipad
   return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutomaticallyForwardRotationMethods
{
   return  YES;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
   return  YES;
}

#pragma mark - DemoViewDelegate

- (void)DemoViewDidSelectItem:(id)obj
{
    SampleModel *model = obj;
    if (model.linkUrl) {//open link url
        [self showWebView:YES url:model.linkUrl];
    }else//open detail
    {
        DemoDetailViewController *vc = [DemoDetailViewController new];
        vc.data = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)showWebView:(BOOL)show url:(NSString*)url
{
    if (show) {
        [self.view addSubview:self.webContainerView];
        [self.view bringSubviewToFront:self.webContainerView];
        self.webView.delegate =self;
        [self.activity startAnimating];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        self.webContainerView.frame = RECT_WITH_Y(self.view.bounds, self.view.bounds.size.height);
        [UIView animateWithDuration:0.5f animations:^{
            self.webContainerView.frame =self.view.bounds;
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            self.webContainerView.frame = RECT_WITH_Y(self.webContainerView.frame, self.webContainerView.frame.size.height);
        } completion:^(BOOL finished) {
            [self.webContainerView removeFromSuperview];
        }];
    }
}

- (IBAction)btnCloseWebViewTouchUpInside:(id)sender {
    [self showWebView:NO url:nil];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activity stopAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activity stopAnimating];
}
@end
