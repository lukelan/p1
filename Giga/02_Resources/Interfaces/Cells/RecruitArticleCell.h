//
//  RecruitArticleCell.h
//  Giga
//
//  Created by Hoang Ho on 11/27/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "BaseCell.h"

@interface RecruitArticleCell : BaseCell
@property (weak, nonatomic) IBOutlet UIImageView *imgCompanyLogo;
@property (weak, nonatomic) IBOutlet UILabel *lbRecruitValue;
@property (weak, nonatomic) IBOutlet UILabel *lbRecruitType;
@property (weak, nonatomic) IBOutlet UIButton *btnCompany;
@property (weak, nonatomic) IBOutlet UILabel *lbCompanyName;
@property (weak, nonatomic) IBOutlet UILabel *lbCompanyDes;

@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *lbComments;
@property (weak, nonatomic) IBOutlet UILabel *lbNumberComments;

@end


@interface NSMutableAttributedString (Extension)
- (void)setFont:(UIFont*)font
          color:(UIColor*)color
        atRange:(NSRange)range
         string:(NSString*)msg;
@end