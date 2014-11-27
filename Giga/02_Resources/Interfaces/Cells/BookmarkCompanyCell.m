//
//  BookmarkCompanyCell.m
//  Giga
//
//  Created by Hoang Ho on 11/27/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "BookmarkCompanyCell.h"
#import "UIImageView+WebCache.h"
#import "CompanyModel.h"

@implementation BookmarkCompanyCell

- (void)applyStyleIfNeed{
    if (isAppliedStyle) {
        return;
    }
    isAppliedStyle = YES;
    self.lbCompanyName.font = BOLD_FONT_WITH_SIZE(14);
    self.lbCompanyDes.font = NORMAL_FONT_WITH_SIZE(12);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setObject:(id)obj
{
    [super setObject:obj];
    CompanyModel *company = obj;
    self.lbCompanyName.text = company.companyName;
    self.lbCompanyDes.text = company.companyDes;
    self.imgCompany.image = RANDOM_IMAGE(rand() % 100);
}

+ (CGFloat)getCellHeight
{
    return 91;
}
@end
