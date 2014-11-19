//
//  MainViewController.h
//  DemoApp
//
//  Created by Hoang Ho on 11/18/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *tabContainerView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *scMain;
- (IBAction)scMainValueChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIView *webContainerView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)btnCloseWebViewTouchUpInside:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@end
