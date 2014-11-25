//
//  NormalArticleCell.h
//  Giga
//
//  Created by Hoang Ho on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "ArticleCell.h"

@interface NormalArticleCell : ArticleCell
@property (weak, nonatomic) IBOutlet UIImageView *imgArticleImage;

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnCompany;
- (IBAction)btnCompanyTouchUnInSide:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *lbComments;
@property (weak, nonatomic) IBOutlet UILabel *lbNumberComments;


@end
