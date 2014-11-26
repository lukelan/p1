//
//  ArticleViewController.h
//  Giga
//
//  Created by Hoang Ho on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticleCategoryModel;

@interface ArticleViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) ArticleCategoryModel *category;

@property (weak, nonatomic) IBOutlet UITableView *tbArticles;
@end

