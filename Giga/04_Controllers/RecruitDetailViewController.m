//
//  RecruitDetailViewController.m
//  Giga
//
//  Created by vandong on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "RecruitDetailViewController.h"
#import "WebDetailViewController.h"
#import "CommentItem.h"

@interface RecruitDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger           expandingSection;
    NSMutableArray      *ar
}
@end

@implementation RecruitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lbJobContentTitle.text = localizedString(@"Job Content");
    self.lbRecruitTargetTitle.text = localizedString(@"Recruit Target");
    self.lbLocationTitle.text = localizedString(@"Location");
    self.lbSalaryTitle.text = localizedString(@"Salary");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setValueForContent {
    // set value for label in detail
}


- (IBAction)btOpenWebDetail_Touched:(id)sender {
    WebDetailViewController *vc = [WebDetailViewController new];
    [self.navigationController pushViewController:vc animated: YES];
}

- (IBAction)btBookmark_Touched:(id)sender {
    
}

- (IBAction)btRelativeInfo_Touched:(id)sender {
    
}

- (void)loadComment {
    
}


#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arComment.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    CommentItem *comment = _arComment[section - 1];
    if (section == expandingSection) {
        return comment.arReply.count + 2;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.vContentDetail.frame.size.height;
    }
    
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableHeaderCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentTableHeaderCell"];
            [cell addSubview: self.vContentDetail];
        }
        return cell;
    }
}

@end
