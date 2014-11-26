//
//  CompanyModel.h
//  Giga
//
//  Created by Hoang Ho on 11/26/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "BaseModel.h"

@interface CompanyModel : BaseModel
@property (copy, nonatomic) NSString *categoryName;
@property (copy, nonatomic) NSString *companyName;
@property (copy, nonatomic) NSString *companyDes;
@property (copy, nonatomic) NSString *logoUrl;
@end
