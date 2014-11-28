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
    self.lbCompanyDes.font = NORMAL_FONT_WITH_SIZE(12);
    self.lbCompanyName.font = BOLD_FONT_WITH_SIZE(14);
    self.lbRecruitType.font = NORMAL_FONT_WITH_SIZE(12);
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
    
    //for recruit value
    if (recruit.recruitFromValue > 0 && recruit.recruitToValue > 0) {
        NSString *msg =[NSString stringWithFormat:@"月給 \n%d万~%d万円",recruit.recruitFromValue, recruit.recruitToValue];
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:msg];
        NSRange fromValueRange = [msg rangeOfString:STRINGIFY_INT(recruit.recruitFromValue)
                                            options:NSLiteralSearch
                                              range:NSMakeRange(0, msg.length)];
        
        NSRange toValueRange = [msg rangeOfString:STRINGIFY_INT(recruit.recruitToValue)
                                          options:NSBackwardsSearch
                                            range:NSMakeRange(0, msg.length)];

        [attrStr setFont:NORMAL_FONT_WITH_SIZE(13)
                   color:[UIColor whiteColor]
                 atRange:NSMakeRange(0, msg.length)
                  string:msg];

        [attrStr setFont:NORMAL_FONT_WITH_SIZE(20)
                              color:[UIColor whiteColor]
                            atRange:fromValueRange
                             string:msg];
        [attrStr setFont:NORMAL_FONT_WITH_SIZE(20)
                              color:[UIColor whiteColor]
                            atRange:toValueRange
                             string:msg];
        self.lbRecruitValue.attributedText = attrStr;
    }else
        self.lbRecruitValue.text = @"";
}

@end


@implementation NSMutableAttributedString (Extension)
- (void)setFont:(UIFont*)font
          color:(UIColor*)color
        atRange:(NSRange)range
         string:(NSString*)msg
{
    if (color && range.location < msg.length) {
        [self addAttribute:NSForegroundColorAttributeName value:color range:range];
        [self addAttribute:NSFontAttributeName value:font range:range];
    }
}
@end