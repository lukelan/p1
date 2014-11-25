//
//  HomeCell.h
//  PickGirls
//
//  Created by PMT on 9/15/14.
//  Copyright (c) 2014 PMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgCell;
@property (weak, nonatomic) IBOutlet UILabel *lbState;
@property (weak, nonatomic) IBOutlet UIImageView *imgCmt;
@property (weak, nonatomic) IBOutlet UILabel *lbNumberCmt;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle1;
@property (weak, nonatomic) IBOutlet UILabel *lbNumberCmt1;
@property (weak, nonatomic) IBOutlet UIImageView *imgCmt1;
@property (weak, nonatomic) IBOutlet UILabel *lbState1;
@property (weak, nonatomic) IBOutlet UIImageView *imgPR;
@property (weak, nonatomic) IBOutlet UILabel *lbNumberCmt2;
@property (weak, nonatomic) IBOutlet UIImageView *imgCmt2;


- (void)setObject:(id)obj;
- (void)applyStyleIfNeed;

@end
