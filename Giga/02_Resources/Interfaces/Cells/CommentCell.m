//
//  CommentCell.m
//  Giga
//
//  Created by vandong on 11/26/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"

#define height_title            25
#define height_button_bar       47;

#define Max100Percent                  120
#define MaxBlue                        200.0f

@interface CommentCell()<UIAlertViewDelegate>

@end

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
    self = ar[0];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
    
}
-(instancetype)initForReply {
    NSArray *ar = [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
    CommentCell *cell = ar[0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.btExpandColapse.hidden = YES;
    cell.btCountReply.hidden = YES;
    cell.lbName.frame = RECT_ADD_X(cell.lbName.frame, 31);
    cell.lbPostDate.frame = RECT_ADD_X(cell.lbPostDate.frame, 31);
    cell.vBtReport.frame = RECT_ADD_X(cell.vBtReport.frame, 31);
    cell.lbSeparateLine.frame = RECT_ADD_X(cell.lbSeparateLine.frame, 25);
    CGRect rect = RECT_WITH_X(cell.lbPostText.frame, 29);
    rect.size.width -= 29;
    cell.lbPostText.frame = rect;
    
    rect = RECT_ADD_X(cell.lbName.frame, -16);
    rect.size = CGSizeMake(11, 11);
    rect.origin.y = 8;
    UIImageView *imvReplyIcon = [[UIImageView alloc] initWithFrame:rect];
    imvReplyIcon.image = [UIImage imageNamed:@"icon_reply.png"];
    [cell addSubview:imvReplyIcon];
    
    return cell;
}


+(float)heightWithItem:(CommentModel *)item {
    float height = 0;
    height += height_title;// title height
    CGSize size;
    if (item.isReply) {
        size = [item.commentText sizeWithFont: [CommentCell fontForTextWithLike:item.numLike AndDisLike:item.numDisLike] constrainedToSize: CGSizeMake(275, 10000)];
    } else {
        size = [item.commentText sizeWithFont: [CommentCell fontForTextWithLike:item.numLike AndDisLike:item.numDisLike] constrainedToSize: CGSizeMake(304, 10000)];
    }
    
    height += size.height +2;
    
    height += height_button_bar;

    item.cellHeight = height;
    item.commentTextHeight = size.height + 2;
    return height;
}

+ (UIFont *)fontForTextWithLike:(NSInteger )numLike AndDisLike:(NSInteger )numDislike {
    return  (numLike >= numDislike)? [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:15] : [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14];
}

+ (UIColor *)colorForTextWithLike:(NSInteger )numLike AndDisLike:(NSInteger )numDislike {
    if (numLike > numDislike) {
        return ((numLike - numDislike) >= 100)? RGB(72, 175, 239) : RGB(102, 102, 102);
    }
    return RGB(149, 149, 149);
}


- (void)setContentWithItem:(CommentModel *)item {
    self.data = item;
    self.lbPostText.font = [CommentCell fontForTextWithLike:item.numLike AndDisLike:item.numDisLike];
    self.lbPostText.textColor = [CommentCell colorForTextWithLike:item.numLike AndDisLike:item.numDisLike];
    self.lbPostText.text = item.commentText;
    self.lbPostText.frame = RECT_WITH_HEIGHT(self.lbPostText.frame, item.commentTextHeight);
    self.vButtonContainer.frame = RECT_WITH_Y(self.vButtonContainer.frame, self.lbPostText.frame.origin.y + item.commentTextHeight +2);
    [self.btCountReply setTitle:[NSString stringWithFormat:@"%ld", item.arReply.count] forState: UIControlStateNormal];
    // calculate ratio
    float total = item.numLike + item.numDisLike;
    float result = item.numLike - item.numDisLike;
    
    self.lbSumVote.text = result >=0?[NSString stringWithFormat:@"+%.0f", result] : [NSString stringWithFormat:@"%.0f", result];
//    self.lbSumVote.font = self.lbPostText.font;
    self.lbSumVote.textColor = self.lbPostText.textColor;
    
    if (total < MaxBlue) {
        CGRect rect = self.vRatio.frame;
        rect.size.width = total / MaxBlue * Max100Percent;
        rect.origin.x = self.frame.size.width - 45 - rect.size.width;
        self.vRatio.frame = rect;
        
        self.lbRatioLike.frame = RECT_WITH_WIDTH(self.lbRatioLike.frame,(float)item.numLike  / total  * rect.size.width );
        
    } else {
        CGRect rect = self.vRatio.frame;
        rect.size.width = Max100Percent;
        rect.origin.x = self.frame.size.width - 45 - rect.size.width;
        self.vRatio.frame = rect;

        self.lbRatioLike.frame = RECT_WITH_WIDTH(self.lbRatioLike.frame, (float)item.numLike  / total  * rect.size.width );
    }
}

#pragma mark - IBActions

-(IBAction)btReport_Touched:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:localizedString(@"This comment is inappropriate") delegate:self cancelButtonTitle:localizedString(@"NO") otherButtonTitles:localizedString(@"OK"), nil];
    [alert show];
}
-(IBAction)btExpandColapse_Touched:(id)sender {
    if (self.delegate) {
        [self.delegate didTouchedExpandColapseForCell:self];
    }
}

-(IBAction)btLike_Touched:(id)sender {
    if (self.data.isVote == NO) {
        self.data.isVote = YES;
        self.data.numLike++;
        self.lbSumVote.text = [NSString stringWithFormat:@"%i", self.lbSumVote.text.intValue + 1];
        //need recalculate ratio
    }
}
-(IBAction)btDisLike_Touched:(id)sender {
    if (self.data.isVote == NO) {
        self.data.isVote = YES;
        self.data.numDisLike++;
        self.lbSumVote.text = [NSString stringWithFormat:@"%i", self.lbSumVote.text.intValue + 1];
        //need recalculate ratio        
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}
@end
