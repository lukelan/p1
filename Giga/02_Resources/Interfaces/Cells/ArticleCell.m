//
//  ArticleCell.m
//  Giga
//
//  Created by Hoang Ho on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "ArticleCell.h"

@implementation ArticleCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setObject:(id)obj
{
    model = obj;
}

- (void)applyStyleIfNeed{
    
}
@end
