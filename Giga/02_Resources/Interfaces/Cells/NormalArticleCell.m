//
//  NormalArticleCell.m
//  Giga
//
//  Created by Hoang Ho on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "NormalArticleCell.h"
#import "ArticleModel.h"
#import "UIImageView+WebCache.h"

@implementation NormalArticleCell


- (void)applyStyleIfNeed
{
    if (isAppliedStyle) return;
    isAppliedStyle = YES;
    UIFont *lbFont = NORMAL_FONT_WITH_SIZE(12);
    self.lbComments.font = self.lbNumberComments.font = self.btnCompany.titleLabel.font = lbFont;
    self.lbTitle.font = BOLD_FONT_WITH_SIZE(14);
    
    self.lbComments.text = localizedString(@"Comments");
}

- (IBAction)btnCompanyTouchUnInSide:(id)sender {
}

- (void)setObject:(id)obj
{
    [super setObject:obj];
    if ([obj isKindOfClass:[ArticleModel class]]) {
        ArticleModel *article = (ArticleModel*)obj;
        self.lbTitle.text = article.title;
        self.lbNumberComments.text = [NSString stringWithFormat:@"%d",article.numberComment.intValue];
        [self.btnCompany setTitle:article.site forState:UIControlStateNormal];
        if (article.numberComment.integerValue >= 50) {
            self.lbNumberComments.font = BOLD_FONT_WITH_SIZE(14);
        }else
            self.lbNumberComments.font = NORMAL_FONT_WITH_SIZE(13);
        
        int titleLeftMargin = 5;
        if (article.imageUrl && article.imageUrl.length > 0) {
            self.imgArticleImage.hidden = NO;
            self.commentView.frame = RECT_WITH_X(self.commentView.frame, self.imgArticleImage.frame.origin.x - self.commentView.frame.size.width - titleLeftMargin);
            [self.imgArticleImage sd_setImageWithURL:[NSURL URLWithString:article.imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
            self.lbTitle.frame = RECT_WITH_WIDTH(self.lbTitle.frame, self.imgArticleImage.frame.origin.x - titleLeftMargin * 2);
        }else{
            self.imgArticleImage.hidden = YES;
            self.commentView.frame = RECT_WITH_X(self.commentView.frame, self.frame.size.width - self.commentView.frame.size.width - titleLeftMargin);
            self.lbTitle.frame = RECT_WITH_WIDTH(self.lbTitle.frame, self.frame.size.width - titleLeftMargin * 2);
        }
    }
}

#define HOMETABLE_CELL_DESCRIPTION_MAX_HEIGHT 55.0f
#define HOMETABLE_CELL_READMORE_HEIGHT 15.0f
#define HOMETABLE_CELL_DESCRIPTION_EXPAND_DELTA 10.0f//use it for TTTAttributedLabel

-(void)layoutSubviews
{
    [super layoutSubviews];
    float delta = [[[UIDevice currentDevice] systemVersion] floatValue] < 7 ? HOMETABLE_CELL_DESCRIPTION_MAX_HEIGHT : HOMETABLE_CELL_DESCRIPTION_MAX_HEIGHT - 2;
    delta += HOMETABLE_CELL_DESCRIPTION_EXPAND_DELTA;
    
    CGRect desRect = self.lbTitle.frame;
    CGSize desSize = [self.lbTitle.text sizeWithFont:self.lbTitle.font constrainedToSize:CGSizeMake(desRect.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    desRect.size.height = desSize.height > HOMETABLE_CELL_DESCRIPTION_MAX_HEIGHT ? delta: desSize.height + 5 ;
    self.lbTitle.frame = desRect;

    self.lbTitle.frame = desRect;
}
@end
