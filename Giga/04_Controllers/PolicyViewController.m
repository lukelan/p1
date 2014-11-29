//
//  PolicyViewController.m
//  Giga
//
//  Created by Tai Truong on 11/29/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "PolicyViewController.h"

#define kTermOfUseUrl @"http://girlspicks.co/notice_app.html"
#define kPolicyUrl @"http://girlspicks.co/policy_app.html"

@interface PolicyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)getBack:(id)sender;
@end

@implementation PolicyViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initInterface];
    NSString *url = nil;
    if (self.type == enumPolicyViewType_Policy) {
        url = kPolicyUrl;
    }
    else
    {
        url = kTermOfUseUrl;
    }
    if (url) [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

-(void)initInterface
{
    if (self.type == enumPolicyViewType_Policy) {
        self.titleLbl.text = localizedString(@"Policy");
    }
    else
    {
        self.titleLbl.text = localizedString(@"Term Of Use");
    }
}

#pragma mark - Actions

- (IBAction)getBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
