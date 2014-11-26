//
//  WebDetailViewController.m
//  Giga
//
//  Created by vandong on 11/26/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "WebDetailViewController.h"

@interface WebDetailViewController ()

@end

@implementation WebDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lbBtShareTitle.text = localizedString(@"Share");
 
    if (self.pageLink.length > 0) {
        [self.wvContent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.pageLink]]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btBack_Touched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btShare_Touched:(id)sender {
    
}


@end
