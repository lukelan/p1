//
//  ArticleViewController.m
//  Giga
//
//  Created by Hoang Ho on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "ArticleViewController.h"
#import "ArticleCategoryModel.h"
#import "NormalArticleCell.h"
#import "ArticleModel.h"
#import "SVPullToRefresh.h"
#import "MNMBottomPullToRefreshManager.h"

#define NormalArticleCellID                 @"NormalArticleCell"

@interface ArticleViewController()<MNMBottomPullToRefreshManagerClient>
{
    NSUInteger pageIndex;
    NSMutableArray *tableData;
    
    //refresh
    BOOL refreshing;
    
    //load more
    BOOL loadingMore;
    MNMBottomPullToRefreshManager *_loadMoreFooterView;
}
@end

@implementation ArticleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    pageIndex = 1;
    tableData  = [NSMutableArray array];
    [self loadInterface];
}


- (void)dealloc
{
    [tableData removeAllObjects];
    tableData = nil;
}

- (void)loadInterface
{
    _loadMoreFooterView = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f tableView:self.tbArticles withClient:self];
    
    [self.tbArticles registerNib:[UINib nibWithNibName:NormalArticleCellID bundle:nil] forCellReuseIdentifier:NormalArticleCellID];
    [self.tbArticles addPullToRefreshWithActionHandler:^{
        if ([self shouldLoadData:NO]) {
            pageIndex = 1;
            [self loadData];
        }else{
            [self performSelector:@selector(doneRefreshData) withObject:nil afterDelay:0.3f];
        }
    }];
    self.tbArticles.backgroundColor = RGB(226, 231, 237);
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.category.categoryType) forKey:@"category_id"];
    [params setObject:@(pageIndex) forKey:@"page"];
    
    [SharedAPIRequestManager operationWithType:ENUM_API_REQUEST_TYPE_GET_ARTICLE andPostMethodKind:YES andParams:params inView:self.view shouldCancelAllCurrentRequest:NO completeBlock:^(id responseObject) {
        if (pageIndex == 1) {
            [tableData removeAllObjects];
        }
        NSArray *result = responseObject;
        
        if ([result isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in result) {
                ArticleModel *article = [ArticleModel initWithJsonData:dict];
                [tableData addObject:article];
            }
        }
        [self.tbArticles reloadData];
        
        [self doneLoadMoreData];
        [self doneRefreshData];
    } failureBlock:^(NSError *error) {
        [self doneLoadMoreData];
        [self doneRefreshData];
    }];
}

- (void)setCategory:(ArticleCategoryModel *)category
{
    _category = category;
    refreshing = YES;
    [self loadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NormalArticleCell *normalCell = [tableView dequeueReusableCellWithIdentifier:NormalArticleCellID];
    [normalCell applyStyleIfNeed];
    
    ArticleModel *article = tableData[indexPath.row];
    [normalCell setObject:article];
    return normalCell;
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_loadMoreFooterView relocatePullToRefreshView];
    
    [_loadMoreFooterView tableViewScrolled];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_loadMoreFooterView tableViewReleased];
}

#pragma mark - Load More

-(void)doneLoadMoreData {
    loadingMore = NO;
    [_loadMoreFooterView tableViewReloadFinished];
    [_loadMoreFooterView refreshLastUpdatedDate:[NSDate date]];
}

-(void)doneRefreshData {
    refreshing = NO;
    [self.tbArticles.pullToRefreshView stopAnimating];
    [self.tbArticles.pullToRefreshView setSubtitle:[Utils getUpdatedStringFromDate:[NSDate date]] forState:SVPullToRefreshStateAll];
}

- (BOOL)shouldLoadData:(BOOL)isLoadMore
{
    if (isLoadMore) {
        if (tableData.count > 0 &&
            tableData.count % DEFAULT_PAGE_SIZE == 0 &&
            !loadingMore && !refreshing
            )
            return YES;
        return NO;
    }else{
        if (!loadingMore && !refreshing)
            return YES;
        return NO;
    }
}
- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager {
    if ([self shouldLoadData:YES]) {
        pageIndex = (tableData.count / DEFAULT_PAGE_SIZE) + 1;
        loadingMore = YES;
        [self loadData];
    }else{
        [self performSelector:@selector(doneLoadMoreData) withObject:nil afterDelay:0.3f];
    }
}
@end
