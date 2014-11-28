//
//  RelativeNewsViewController.m
//  Giga
//
//  Created by vandong on 11/29/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "RelativeNewsViewController.h"

@interface RelativeNewsViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation RelativeNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btBack_Touched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
@end
