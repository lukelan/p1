//
//  RecruitDetailViewController.m
//  Giga
//
//  Created by vandong on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "RecruitDetailViewController.h"
#import "WebDetailViewController.h"
#import "CommentModel.h"
#import "CommentCell.h"
#import "ShareSocial.h"
#import "recruitArticleModel.h"
#import "ArticleModel.h"
#import "CommentInputTextCell.h"

#define CellIdentifierRecruitInfo       @"CellIdentifierRecruitInfo"
#define CellIdentifierNewsInfo          @"CellIdentifierNewsInfo"

#define CellIdentifierComment           @"CellIdentifierComment"
#define CellIdentifierReply             @"CellIdentifierReply"
#define CellIdentifierInputReply        @"CellIdentifierInputReply"


@interface UILabel (sizewithtext)
-(float)newHeightWithContent:(NSString *)text;
-(float)newHeightWithContent:(NSString *)text andFont:(UIFont *)font;
@end

@implementation UILabel (sizewithtext)
-(float)newHeightWithContent:(NSString *)text {
    CGSize size = [text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, 10000)];
    CGRect rect = self.frame;
    rect.size.height = size.height;
    self.frame = rect;
    
    return size.height;
}

-(float)newHeightWithContent:(NSString *)text andFont:(UIFont *)font {
    self.font = font;
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width, 10000)];
    CGRect rect = self.frame;
    rect.size.height = size.height;
    self.frame = rect;
    
    return size.height;
}

@end


@interface RecruitDetailViewController ()<UITableViewDataSource, UITableViewDelegate, CommentCellDelegate>
{
    NSMutableArray      *arExpandingSection;
    BOOL                isBookmark;
}
@end

@implementation RecruitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arExpandingSection = [NSMutableArray new];
    
    
    [self loadInterface];
    
    
    
    // for sample demo
    [self createTestData];
    [self.tbv reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setValueForContent {
    // set value for label in detail
}

- (void)loadInterface {
    self.lbEmployeeType.layer.masksToBounds = YES;
    self.lbEmployeeType.layer.cornerRadius = 3;
    
    self.lbJobContentTitle.text = localizedString(@"Job Content");
    self.lbRecruitTargetTitle.text = localizedString(@"Recruit Target");
    self.lbLocationTitle.text = localizedString(@"Location");
    self.lbSalaryTitle.text = localizedString(@"Salary");
    
    return;
    
    /// update layout of detail view up to data
    if ([_recruitItem isMemberOfClass:[RecruitArticleModel class]]) {
    
        // job content
        NSString *s = @"dfdf";
        float oldHeight = self.lbJobContentDetail.frame.size.height;
        float newHeight = [self.lbJobContentDetail newHeightWithContent:s];
        float delta = newHeight - oldHeight;
        for (UIView *v in self.vContentDetail.subviews) {
            if (v.frame.origin.y > self.lbJobContentDetail.frame.origin.y) {
                v.frame = RECT_ADD_HEIGHT(v.frame, delta);
            }
        }
        // recruit target
        s = @"dfdf";
        oldHeight = self.lbRecruitTargetDetail.frame.size.height;
        newHeight = [self.lbRecruitTargetDetail newHeightWithContent:s];
        delta = newHeight - oldHeight;
        for (UIView *v in self.vContentDetail.subviews) {
            if (v.frame.origin.y > self.lbRecruitTargetDetail.frame.origin.y) {
                v.frame = RECT_ADD_HEIGHT(v.frame, delta);
            }
        }
        
        // location
        s = @"dfdf";
        oldHeight = self.lbLocationDetail.frame.size.height;
        newHeight = [self.lbLocationDetail newHeightWithContent:s];
        delta = newHeight - oldHeight;
        for (UIView *v in self.vContentDetail.subviews) {
            if (v.frame.origin.y > self.lbLocationDetail.frame.origin.y) {
                v.frame = RECT_ADD_HEIGHT(v.frame, delta);
            }
        }
        
        self.vContentDetail.frame = RECT_WITH_HEIGHT(self.vContentDetail.frame, self.lbCommentSection.frame.origin.y + self.lbCommentSection.frame.size.height);
    }
    
    if ([_recruitItem isMemberOfClass:[ArticleModel class]]) {
        // news content
        NSString *s = @"dfdf";
        float oldHeight = self.lbNewContent.frame.size.height;
        float newHeight = [self.lbNewContent newHeightWithContent:s];
        float delta = newHeight - oldHeight;
        for (UIView *v in self.vNewsDetail.subviews) {
            if (v.frame.origin.y > self.lbNewContent.frame.origin.y) {
                v.frame = RECT_ADD_HEIGHT(v.frame, delta);
            }
        }
        
        self.vNewsDetail.frame = RECT_ADD_HEIGHT(self.vNewsDetail.frame, delta + 5);

    }
    
    
}

- (void)createTestData {
    self.arComment = [NSMutableArray new];
    
    NSString *sComment = @"在作为六本木新城的门口的Roku-Roku Plaza，约8m高的象征树登场。细致的结构的树根据被内侧放出的光像比赛那样变成各种各样的表情。另外，颜色根据时间变化，轻松用多彩的美渗进白以及红色，彩红色，琥珀色能抱住。而且和树的光在周围连动，发亮的\"OLED\"(有机EL)被镶嵌，有摇曳的光在空间展开。";
    NSString *sReply =@"在WEST WALK的南侧楼梯井登场的圣诞节装饰品\"Snowy Air Chandelier\"作为设计师邀请在动机制作鸟的羽毛键的艺术家、小松宏诚实他，是atisutikku，并且上演幻想的圣诞节。有无数闪耀的羽毛的吊灯根据上升气流溜溜地旋转。一边装满光，一边精彩地发出光芒。";
    
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    dateFormat.dateFormat = [NSString stringWithFormat:@"yyyy%@MM%@dd%@ hh:mm", localizedString(@"年"), localizedString(@"月"), localizedString(@"日")];

    NSInteger numerComment = 0;
    if ([_recruitItem isMemberOfClass:[RecruitArticleModel class]]) {
        numerComment = ((RecruitArticleModel*)_recruitItem).numberComment;
    }
    if ([_recruitItem isMemberOfClass:[ArticleModel class]]) {
        numerComment = ((ArticleModel*)_recruitItem).numberComment.integerValue;
    }

    for (int i = 0; i < numerComment; i++) {
        CommentModel *comment = [CommentModel new];
        comment.isReply = NO;
        comment.commentText = [sComment substringFromIndex:rand()% sComment.length];
        comment.numLike = rand() %200;
        comment.numDisLike = rand() %200;
        comment.postDate = [dateFormat stringFromDate:[NSDate date]];
        
        int numReply = rand()%10;
        comment.arReply = [NSMutableArray new];
        for (int j = 0; j < numReply; j++) {
            CommentModel *reply = [CommentModel new];
            reply.isReply = YES;
            reply.commentText = [sReply substringFromIndex:rand()% sReply.length];
            reply.numLike = rand() %200;
            reply.numDisLike = rand() %200;
            reply.postDate = [dateFormat stringFromDate:[NSDate date]];
            
            [comment.arReply addObject:reply];
        }
        [_arComment addObject:comment];
    }
}


- (IBAction)btOpenWebDetail_Touched:(id)sender {
    WebDetailViewController *vc = [WebDetailViewController new];
    [self.navigationController pushViewController:vc animated: YES];
}

- (IBAction)btBookmark_Touched:(id)sender {
    NSString *message = isBookmark == YES? @"Unbookmark successfully" : @"Bookmark successfully";
    isBookmark = !isBookmark;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message: message delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)btRelativeInfo_Touched:(id)sender {
    
}

- (IBAction)btShare_Touched:(id)sender {
    [[ShareSocial share] showShareSelectionInView:self.view];
}
-(IBAction)btBack_Touched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadComment {
    
}


#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arComment.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    if ([arExpandingSection indexOfObject:@(section)] != NSNotFound) {
         CommentModel *comment = _arComment[section - 1];
        return comment.arReply.count + 2; // first cell is comment, last cell is input text for new reply
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([_recruitItem isMemberOfClass:[RecruitArticleModel class]]) {
            // Recruit detail info view
            return self.vContentDetail.bounds.size.height;
        }
        if ([_recruitItem isMemberOfClass:[ArticleModel class]]) {
            // Recruit detail info view
            return self.vNewsDetail.bounds.size.height;
        }
        return 0;
    }
    
     if (indexPath.row == 0) {
         CommentModel *cellData = _arComment[indexPath.section - 1];
         return [CommentCell heightWithItem:cellData];
     } else {
         CommentModel *item = _arComment[indexPath.section - 1];
         if (item.arReply.count +1 == indexPath.row) {
             return CommentInputTextCellHeight;
         }
         CommentModel *cellData = item.arReply[indexPath.row-1];
         return [CommentCell heightWithItem:cellData];
     }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([_recruitItem isMemberOfClass:[RecruitArticleModel class]]) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifierRecruitInfo];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierRecruitInfo];
                [cell addSubview: self.vContentDetail];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
        if ([_recruitItem isMemberOfClass:[ArticleModel class]]) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifierNewsInfo];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierNewsInfo];
                [cell addSubview: self.vNewsDetail];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;

        }
    }
    
    CommentModel  *cellData;
    if (indexPath.row == 0) {
        cellData = _arComment[indexPath.section - 1];
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierComment];
        if (cell == nil) {
            cell = [[CommentCell alloc] initForComment];
            cell.delegate = self;
        }
        cell.indexPath = indexPath;
        [cell setContentWithItem:cellData];
        if ([arExpandingSection indexOfObject: @(indexPath.section)] == NSNotFound) {
            cell.btExpandColapse.selected = NO;
        } else {
            cell.btExpandColapse.selected = YES;
        }
        return cell;
    } else {
        CommentModel *item = _arComment[indexPath.section - 1];
        if (item.arReply.count + 1 == indexPath.row) {
            // cell input new reply
            CommentInputTextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierInputReply];
            if (cell == nil) {
                cell = [CommentInputTextCell new];
            }
            return cell;
        } else {
            cellData = item.arReply[indexPath.row - 1];
            CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierReply];
            if (cell == nil) {
                cell = [[CommentCell alloc] initForReply];
                cell.delegate = self;
            }
            cell.indexPath = indexPath;
            [cell setContentWithItem:cellData];
            return cell;
        }

    }
    return nil;
}

#pragma mark - CommentCellDelegate
- (void)didTouchedExpandColapseForCell:(CommentCell *)cell {
    NSIndexPath *indexPath = cell.indexPath;
    if([arExpandingSection indexOfObject:@(indexPath.section)] != NSNotFound) {
        // collapse
        [arExpandingSection removeObject:@(indexPath.section)];
        [self.tbv beginUpdates];
        [self.tbv reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:100];
        [self.tbv endUpdates];

    } else {
        //expand
        [arExpandingSection addObject:@(indexPath.section)];
        [self.tbv beginUpdates];
        [self.tbv reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:100];
        [self.tbv endUpdates];
    }
}


@end
