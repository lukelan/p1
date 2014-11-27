//
//  RecruitArticleCell.m
//  Giga
//
//  Created by Hoang Ho on 11/27/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "RecruitArticleCell.h"
#import "RecruitArticleModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@implementation RecruitArticleCell
+ (CGFloat)getCellHeight
{
    return 141;
}

- (void)applyStyleIfNeed{
    if (isAppliedStyle) {
        return;
    }
    isAppliedStyle = YES;
    self.lbCompanyDes.font = NORMAL_FONT_WITH_SIZE(13);
    self.lbCompanyName.font = BOLD_FONT_WITH_SIZE(14);
    self.lbRecruitType.font = NORMAL_FONT_WITH_SIZE(13);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setObject:(id)obj
{
    [super setObject:obj];
    RecruitArticleModel *recruit = obj;
    //nil object
    self.imgCompanyLogo.image = RANDOM_IMAGE(rand() % 100);
    self.lbCompanyName.text = recruit.companyName;
    self.lbCompanyDes.text = recruit.companyDes;
    self.lbRecruitType.text = recruit.recruitType;
    self.lbRecruitValue.text = [NSString stringWithFormat:@"月給 \n%d万~%d万円",recruit.recruitFromValue, recruit.recruitToValue];
    if (recruit.recruitImageUrl) {
        [self.imgCompanyLogo sd_setImageWithURL:[NSURL URLWithString:recruit.recruitImageUrl]];
    }
    
    if (recruit.recruitLogoUrl) {
        [self.btnCompany sd_setBackgroundImageWithURL:[NSURL URLWithString:recruit.recruitLogoUrl] forState:UIControlStateNormal];
    }
    self.lbNumberComments.text = [NSString stringWithFormat:@"%d",recruit.numberComment];
    if (recruit.numberComment >= 50) {
        self.lbNumberComments.font = BOLD_FONT_WITH_SIZE(15);
    }else
        self.lbNumberComments.font = NORMAL_FONT_WITH_SIZE(13);
//    if (recruit.isNew) {
//        
//    }
//    self.lbRecruitType.text = [NSString stringWithFormat:@"%@・%@\n%@",RANDOM_STRING(3),RANDOM_STRING(4),RANDOM_STRING(8)];
}
@end
