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
#import "InputCommentView.h"
#import "RelativeNewsViewController.h"


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
    self.text = text;
    CGSize size = [text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, 10000)];
    CGRect rect = self.frame;
    rect.size.height = size.height;
    self.frame = rect;
    
    return size.height;
}

-(float)newHeightWithContent:(NSString *)text andFont:(UIFont *)font {
    self.font = font;
    self.text = text;    
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
    
    self.btBookmark.layer.cornerRadius = 8;
    self.btBookmarkShort.layer.cornerRadius = 8;
    
    self.lbJobContentTitle.text = localizedString(@"Job Content");
    self.lbRecruitTargetTitle.text = localizedString(@"Recruit Target");
    self.lbLocationTitle.text = localizedString(@"Location");
    self.lbSalaryTitle.text = localizedString(@"Salary");
    
    /// update layout of detail view up to data
     NSRange range;
    NSString *source = @"j Careerは、留学先として日本を選択した外国籍留学生、日本での安住を目指す外国人への感謝の心、深い敬愛の念を起業の動機とし、外国籍留学生や在留外国人の皆さんが日本において幸せをつかむための様々なサポートを通し、日本社会のみならず、国際社会への貢献の一助となることを目指しています。近年、グローバル化に対応し社内公用語を英語にする日本企業が増えていますが、就職活動においては依然として日本独特の慣習が根強く残り、外国籍留学生や在留外国人にとって日本企業への就職はとても難しい状況といえます。 j Career はこのような状況を打破するべく、愛と感謝と情熱を持って全力で外国籍の皆さんをサポートし、日本において幸福な生涯を送れるようバックアップしていきたいと考えております。";
    

    if ([_recruitItem isMemberOfClass:[RecruitArticleModel class]]) {
    
        // job content
        range.location = rand() % (source.length / 2);
        range.length = rand() % (source.length - range.location);
        NSString *s = [source substringWithRange:range];
        float oldHeight = self.lbJobContentDetail.frame.size.height;
        float newHeight = [self.lbJobContentDetail newHeightWithContent:s];
        float delta = newHeight - oldHeight;
        for (UIView *v in self.vContentDetail.subviews) {
            if (v.frame.origin.y > self.lbJobContentDetail.frame.origin.y) {
                v.frame = RECT_ADD_Y(v.frame, delta);
            }
        }
        
        // recruit target
        range.location = rand() % (source.length / 2);
        range.length = rand() % (source.length - range.location);
        s = [source substringWithRange:range];
        oldHeight = self.lbRecruitTargetDetail.frame.size.height;
        newHeight = [self.lbRecruitTargetDetail newHeightWithContent:s];
        delta = newHeight - oldHeight;
        for (UIView *v in self.vContentDetail.subviews) {
            if (v.frame.origin.y > self.lbRecruitTargetDetail.frame.origin.y) {
                v.frame = RECT_ADD_Y(v.frame, delta);
            }
        }
        
        // location
        range.location = rand() % (source.length / 2);
        range.length = rand() % (source.length - range.location);
        s = [source substringWithRange:range];
        oldHeight = self.lbLocationDetail.frame.size.height;
        newHeight = [self.lbLocationDetail newHeightWithContent:s];
        delta = newHeight - oldHeight;
        for (UIView *v in self.vContentDetail.subviews) {
            if (v.frame.origin.y > self.lbLocationDetail.frame.origin.y) {
                v.frame = RECT_ADD_Y(v.frame, delta);
            }
        }
        
        self.vContentDetail.frame = RECT_WITH_HEIGHT(self.vContentDetail.frame, self.lbCommentSection.frame.origin.y + self.lbCommentSection.frame.size.height);
    }
    
    
    
    if ([_recruitItem isMemberOfClass:[ArticleModel class]]) {
        // news content
        range.location = rand() % (source.length / 2);
        range.length = rand() % (source.length - range.location);
        NSString *s = [source substringWithRange:range];

        float oldHeight = self.lbNewContent.frame.size.height;
        float newHeight = [self.lbNewContent newHeightWithContent:s];
        float delta = newHeight - oldHeight;
        for (UIView *v in self.vNewsDetail.subviews) {
            if (v.frame.origin.y > self.lbNewContent.frame.origin.y) {
                v.frame = RECT_ADD_Y(v.frame, delta);
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

#pragma mark - IBActions

- (IBAction)btOpenWebDetail_Touched:(id)sender {
    WebDetailViewController *vc = [WebDetailViewController new];
    [self.navigationController pushViewController:vc animated: YES];
}

- (IBAction)btBookmark_Touched:(id)sender {
    ((UIButton *)sender).backgroundColor = (isBookmark == YES)? [UIColor whiteColor] : RGB(0, 179, 255);
    [((UIButton *)sender) setTitleColor: (isBookmark == NO)? [UIColor whiteColor] : RGB(0, 179, 255) forState:UIControlStateNormal];

    NSString *message = isBookmark == YES? @"Unbookmark successfully" : @"Bookmark successfully";
    isBookmark = !isBookmark;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message: message delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)btRelativeInfo_Touched:(id)sender {
    RelativeNewsViewController *vc = [RelativeNewsViewController new];
    [self.navigationController pushViewController:vc animated: YES];
}

- (IBAction)btShare_Touched:(id)sender {
    [[ShareSocial share] showShareSelectionInView:self.view];
}

- (IBAction)btPostComment_Touched:(id)sender {
    InputCommentView *v = [[InputCommentView alloc] initWithFrame:self.view.frame andCompleteBlock:^(NSString *text, BOOL isTwitterEnable, BOOL isFacebookEnable) {
        CommentModel *newComment = [CommentModel new];
        newComment.commentText = text;
        newComment.numLike = 0;
        newComment.numDisLike = 0;
        newComment.arReply = [NSMutableArray new];
        NSDateFormatter *dateFormat = [NSDateFormatter new];
        dateFormat.dateFormat = [NSString stringWithFormat:@"yyyy%@MM%@dd%@ hh:mm", localizedString(@"年"), localizedString(@"月"), localizedString(@"日")];
        newComment.postDate = [dateFormat stringFromDate:[NSDate date]];

        [_arComment insertObject:newComment atIndex:0];
        [self.tbv reloadData];
        [self.tbv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }];
    [self.view addSubview:v];
}

-(IBAction)btBack_Touched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arComment.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    CommentModel *comment = _arComment[section - 1];
    if ([arExpandingSection indexOfObject: comment] != NSNotFound) {
        return comment.arReply.count + 2; // first cell is comment, last cell is input text for new reply
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == _arComment.count) {
        return 42;
    }
    return 0;
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
        
        if ([arExpandingSection indexOfObject: cellData] == NSNotFound) {
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
                [cell setOnTouchedAddReplyBlock:^(NSIndexPath *index) {
                    InputCommentView *v = [[InputCommentView alloc] initWithFrame:self.view.frame andCompleteBlock:^(NSString *text, BOOL isTwitterEnable, BOOL isFacebookEnable) {
                        CommentModel *newReply = [CommentModel new];
                        newReply.isReply = YES;
                        newReply.commentText = text;
                        newReply.numLike = 0;
                        newReply.numDisLike = 0;
                        NSDateFormatter *dateFormat = [NSDateFormatter new];
                        dateFormat.dateFormat = [NSString stringWithFormat:@"yyyy%@MM%@dd%@ hh:mm", localizedString(@"年"), localizedString(@"月"), localizedString(@"日")];
                        newReply.postDate = [dateFormat stringFromDate:[NSDate date]];

                        CommentModel *comment =_arComment[indexPath.section - 1];
                        [comment.arReply insertObject: newReply atIndex:0];
                        
                        [self.tbv beginUpdates];
                        [self.tbv reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:100];
                        [self.tbv endUpdates];
                        [self.tbv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index.section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                    }];
                    [self.view addSubview:v];
                }];
            }
            cell.indexPath = indexPath;
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
    if([arExpandingSection indexOfObject:cell.data] != NSNotFound) {
        // collapse
        [arExpandingSection removeObject:cell.data];
        [self.tbv beginUpdates];
        [self.tbv reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:100];
        [self.tbv endUpdates];

    } else {
        //expand
        [arExpandingSection addObject:cell.data];
        [self.tbv beginUpdates];
        [self.tbv reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:100];
        [self.tbv endUpdates];
    }
}


@end
