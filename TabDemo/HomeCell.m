//
//  Homeself.m
//  PickGirls
//
//  Created by PMT on 9/15/14.
//  Copyright (c) 2014 PMT. All rights reserved.
//

#import "HomeCell.h"
#import "SampleModel.h"

@interface HomeCell ()
{
    SampleModel *item;
    BOOL isApplidStyle;
}
@end

@implementation HomeCell


- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

- (void)applyStyleIfNeed
{
    if (isApplidStyle) {
        return;
    }
    isApplidStyle = YES;
}

- (void)setObject:(id)obj
{
    item = obj;
 
    self.lbTitle.text = self.lbTitle1.text = item.title;
    self.lbNumberCmt1.text = [NSString stringWithFormat:@"%d",item.numberComment.intValue];
    self.lbNumberCmt.text = [NSString stringWithFormat:@"%d",item.numberComment.intValue];
    self.lbNumberCmt2.text = [NSString stringWithFormat:@"%d",item.numberComment.intValue];
    self.imgCell.image = item.image;
    self.lbState.text = item.companySource;
    self.lbState1.text = item.companySource;
    
    self.imgPR.hidden = YES;
    
    if (item.numberComment.intValue > 50) {
        UIFont *newFont = [UIFont fontWithName:@"HiraKakuProN-W6" size:15];
        self.lbTitle.font = newFont;
        self.lbTitle1.font = newFont;
        newFont = [UIFont fontWithName:@"HiraKakuProN-W6" size:13];
        self.lbNumberCmt.font = newFont;
        self.lbNumberCmt1.font = newFont;
        self.lbNumberCmt2.font = newFont;
        
        self.lbNumberCmt.textColor = [UIColor colorWithRed:242.0f/255.0f green:97.0f/255.0f blue:111.0f/255.0f alpha:1.0f];
        self.lbNumberCmt1.textColor = [UIColor colorWithRed:242.0f/255.0f green:97.0f/255.0f blue:111.0f/255.0f alpha:1.0f];
        self.lbNumberCmt2.textColor = [UIColor colorWithRed:242.0f/255.0f green:97.0f/255.0f blue:111.0f/255.0f alpha:1.0f];
        self.lbTitle.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
        self.lbTitle1.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
    }else{
        self.imgCmt.image = [UIImage imageNamed:@"ic_count_cmt2.png"];
        self.imgCmt1.image = [UIImage imageNamed:@"ic_count_cmt2.png"];
        self.imgCmt2.image = [UIImage imageNamed:@"ic_count_cmt2.png"];
        
        UIFont *newFont = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
        self.lbTitle.font = newFont;
        self.lbTitle1.font = newFont;
        newFont = [UIFont fontWithName:@"HiraKakuProN-W3" size:11];
        self.lbNumberCmt.font = newFont;
        self.lbNumberCmt1.font = newFont;
        self.lbNumberCmt2.font = newFont;
        
        
        
        self.lbNumberCmt.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
        self.lbNumberCmt1.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
        self.lbNumberCmt2.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
        self.lbTitle.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        self.lbTitle1.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    }
    
    if (item.image != nil) {
        
        self.lbTitle.hidden = NO;
        self.lbNumberCmt.hidden = NO;
        self.imgCell.hidden = NO;
        self.imgCmt.hidden = NO;
        self.lbState.hidden = NO;
        
        self.lbTitle1.hidden = YES;
        self.lbNumberCmt1.hidden = YES;
        self.imgCmt1.hidden = YES;
        self.lbState1.hidden = YES;
        
        //画像なしコメントアリの場合に表示する追加のラベルを非表示
        self.lbNumberCmt2.hidden = YES;
        self.imgCmt2.hidden = YES;
        
    }else{
        
        self.lbTitle.hidden = YES;
        self.imgCell.hidden = YES;
        self.lbState.hidden = YES;
        
        self.lbTitle1.hidden = NO;
        self.imgCell.image = nil;
        self.lbState1.hidden = NO;
        
        
        self.lbNumberCmt.hidden = YES; //コメント数　画像あり
        self.imgCmt.hidden = YES; //コメント画像　画像あり
        
        
        self.lbNumberCmt2.hidden = NO; //コメント数　画像なし コメント1以上
        self.imgCmt2.hidden = NO; //コメント画像　画像なし コメント1以上
        
        self.lbNumberCmt1.hidden = NO; //コメント数　画像なし コメント0
        self.imgCmt1.hidden = NO; //コメント画像　画像なし コメント0
        
        
        if (item.numberComment.intValue > 0){ //コメント1以上
            
            self.lbNumberCmt1.hidden = YES; //コメント数　画像なし コメント0
            self.imgCmt1.hidden = YES; //コメント画像　画像なし コメント0
            self.lbState.hidden = NO;
            self.lbState1.hidden = YES;
            
        } else { //コメントなし
            self.lbNumberCmt2.hidden = YES; //コメント数　画像なし コメント1以上
            self.imgCmt2.hidden = YES; //コメント画像　画像なし コメント1以上
        }
        
    }
    if (item.linkUrl) {
        self.imgPR.hidden = NO;
        self.lbState.hidden = self.lbState1.hidden = YES;
    }else{
        self.lbState.hidden = item.numberComment.intValue < 0;
        self.lbState1.hidden = !self.lbState.hidden;
    }
}
@end

