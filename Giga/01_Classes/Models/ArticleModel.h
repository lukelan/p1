//
//  ArticleModel.h
//  Giga
//
//  Created by Hoang Ho on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "BaseModel.h"

@interface ArticleModel : BaseModel
@property (copy, nonatomic) NSString *articleID;
@property (copy, nonatomic) NSString *categoryID;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *site;
@property (copy, nonatomic) NSString *overview;
@property (copy, nonatomic) NSString *sourceUrl;
@property (copy, nonatomic) NSNumber *numberComment;
@property (copy, nonatomic) NSString *imageUrl;
@property (copy, nonatomic) NSDate *createdDate;
@property (copy, nonatomic) NSDate *updatedDate;

+ (instancetype)initWithJsonData:(NSDictionary*)json;
@end
