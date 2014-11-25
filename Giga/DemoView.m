//
//  DemoView.m
//  DemoApp
//
//  Created by Hoang Ho on 11/18/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "DemoView.h"
#import "SampleModel.h"
#import "HomeCell.h"

#define HomeCellID      @"HomeCell"

@implementation DemoView

- (instancetype)initWithNumberData:(int)numberItem
{
    DemoView *instance = [[[NSBundle mainBundle] loadNibNamed:@"DemoView" owner:self options:nil] lastObject];
    [instance.tbMain registerNib:[UINib nibWithNibName:HomeCellID bundle:nil] forCellReuseIdentifier:HomeCellID];
    instance.tbMain.rowHeight = 80;
    
    NSMutableArray *temps = [NSMutableArray new];
    for (int i = 0; i < numberItem; i++) {
        int randomIndex = rand() % 10;
        SampleModel *item = [[SampleModel alloc] initWithIndex:randomIndex];
        [temps addObject:item];
    }
    instance.tableData = temps;
    return instance;
}


- (void)dealloc
{
    [_tableData removeAllObjects];
    _tableData = nil;
}

- (void)setTableData:(NSMutableArray *)tableData
{
    _tableData = tableData;
    [self.tbMain reloadData];
}

#pragma mark - UITableVieDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellID];
    [cell applyStyleIfNeed];
    SampleModel *model = self.tableData[indexPath.row];
    [cell setObject:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SampleModel *model = self.tableData[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(DemoViewDidSelectItem:)]) {
        [self.delegate DemoViewDidSelectItem:model];
    }
}
@end
