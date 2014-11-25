//
//  SampleModel.h
//  Giga
//
//  Created by Hoang Ho on 11/19/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SampleModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *des;
@property (strong, nonatomic) NSDate *createdDate;
@property (strong, nonatomic) NSNumber *numberComment;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *linkUrl;
@property (strong, nonatomic) NSString *companySource;

- (instancetype)initWithIndex:(int)randomIndex;
@end
