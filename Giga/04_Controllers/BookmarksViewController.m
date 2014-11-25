//
//  BookmarksViewController.m
//  Giga
//
//  Created by Hoang Ho on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "BookmarksViewController.h"

@interface BookmarksViewController ()
{
    NSMutableArray *tableData;
}
@end

@implementation BookmarksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadInterface];
    [self loadData];
}

- (void)loadInterface
{
    
}

- (void)loadData
{
 //load data here
    [self.tbBookmark reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableData.count == 0) {
        self.tbBookmark.hidden = YES;
        if (self.noBookmarkView.superview != self.view) {
            [self.view addSubview:self.noBookmarkView];
        }
    }else{
       self.tbBookmark.hidden = NO;
        if (self.noBookmarkView.superview == self.view) {
            [self.noBookmarkView removeFromSuperview];
        }
    }
    return tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
