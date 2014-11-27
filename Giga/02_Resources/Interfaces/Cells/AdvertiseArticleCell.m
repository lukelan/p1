//
//  AdvertiseArticleCell.m
//  Giga
//
//  Created by Hoang Ho on 11/27/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "AdvertiseArticleCell.h"
#import "AdsModel.h"
#import "UIImageView+WebCache.h"

@implementation AdvertiseArticleCell

+ (CGFloat)getCellHeight
{
    return 91;
}

- (void)applyStyleIfNeed
{
    if (isAppliedStyle) return;
    isAppliedStyle = YES;
    
    self.lbAdsTitle.font = BOLD_FONT_WITH_SIZE(12);
    self.lbAdsDes.font = BOLD_FONT_WITH_SIZE(14);
    self.lbAdsSource.font = NORMAL_FONT_WITH_SIZE(12);
    
    self.lbComments.text = localizedString(@"Comment");
    self.lbComments.font = NORMAL_FONT_WITH_SIZE(12);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setObject:(id)obj
{
    [super setObject:obj];
    AdsModel *article = obj;
    self.lbAdsTitle.text = article.adsTitle;
    self.lbAdsSource.text = article.adsSource;
    self.lbAdsDes.text = article.adsDes;
    
    self.lbNumberComments.text = [NSString stringWithFormat:@"%d",article.numberComment.intValue];
    if (article.numberComment.integerValue >= 50) {
        self.lbNumberComments.font = BOLD_FONT_WITH_SIZE(15);
    }else
        self.lbNumberComments.font = NORMAL_FONT_WITH_SIZE(13);
    
    if (article.adsImageUrl && article.adsImageUrl.length > 0) {
        [self.imgAdsImage sd_setImageWithURL:[NSURL URLWithString:article.adsImageUrl]];
    }
}

@end
