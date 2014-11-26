//
//  CommentCell.m
//  Giga
//
//  Created by vandong on 11/26/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "CommentCell.h"
#import "CommentItem.h"

#define height_title            25
#define height_button_bar       40;

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initForComment {
    NSArray *ar = [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
    CommentCell *cell = ar[0];
    
    return cell;
    
}
-(instancetype)initForReply {
    NSArray *ar = [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
    CommentCell *cell = ar[0];
    cell.btExpandColapse.hidden = YES;
    cell.btCountReply.hidden = YES;
    return cell;
}


+(float)heightWithItem:(CommentItem *)item {
    float height = 0;
    height += height_title;// title height
    CGSize size = [item.commentText sizeWithFont:[UIFont fontWithName:@"" size:14] constrainedToSize: CGSizeMake(304, 20000)];
    height += size.height;
    
    height += height_button_bar;
    
    return height;
}

- (void)setContentWithItem:(CommentItem *)item {
    self.data = item;
    self.lbPostText.text = item.commentText;
}

-(IBAction)btReport_Touched:(id)sender {
    
}
-(IBAction)btExpandColapse_Touched:(id)sender {
    if (self.delegate) {
        [self.delegate didTouchedExpandColapseForCell:self];
    }
}
@end
