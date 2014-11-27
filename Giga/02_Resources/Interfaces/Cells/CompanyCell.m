//
//  CompanyCell.m
//  Giga
//
//  Created by Hoang Ho on 11/26/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "CompanyCell.h"
#import "CompanyModel.h"
#import "UIImageView+WebCache.h"

@implementation CompanyCell

- (void)applyStyleIfNeed{
    if (isAppliedStyle) {
        return;
    }
    isAppliedStyle = YES;
    self.lbCategory.font = NORMAL_FONT_WITH_SIZE(12);
    self.lbCompanyDes.font = NORMAL_FONT_WITH_SIZE(12);
    self.lbCompanyName.font = BOLD_FONT_WITH_SIZE(14);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setObject:(id)obj
{
    [super setObject:obj];
    CompanyModel *company = obj;
//    self.lbCategory.text = company.categoryName;
    self.lbCategory.text = RANDOM_STRING(5);
    self.lbCompanyName.text = company.companyName;
    self.lbCompanyDes.text = company.companyDes;
    if (company.logoUrl && company.logoUrl.length > 0) {
        [self.imgCompanyLogo sd_setImageWithURL:[NSURL URLWithString:company.logoUrl]];
    }
}

+ (CGFloat)getCellHeight
{
    return 101;
}
@end
