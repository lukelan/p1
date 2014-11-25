//
//  ArticleModel.m
//  Giga
//
//  Created by Hoang Ho on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel

+ (instancetype)initWithJsonData:(NSDictionary*)json
{
    ArticleModel *instance = [[ArticleModel alloc] init];
    if (instance) {
        instance.articleID = json[@"article_id"];
        instance.categoryID = json[@"category_id"];
        instance.title = json[@"title"];
        instance.site = json[@"site"];
        instance.overview = json[@"overview"];
        instance.sourceUrl = json[@"url"];
        instance.numberComment = json[@"cmt_count"];
        instance.imageUrl = json[@"image"];
        instance.createdDate = json[@"updated_at"];
        instance.updatedDate = json[@"created_at"];
    }
    return instance;
}
@end
