//
//  InputCommentView.h
//  Giga
//
//  Created by VisiKardMacBookPro on 11/28/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@interface InputCommentView : UIView <HPGrowingTextViewDelegate>
{
    BOOL            isTwitterEnable;
    BOOL            isFacebookEnable;
    void (^completeBlock)(NSString *, BOOL, BOOL);
}
@property (weak, nonatomic) IBOutlet UIView             *containerView;
@property (weak, nonatomic) IBOutlet HPGrowingTextView  *textView;
@property (weak, nonatomic) IBOutlet UILabel            *lbShareTo;
@property (weak, nonatomic) IBOutlet UIButton           *btTwitter;
@property (weak, nonatomic) IBOutlet UIButton           *btFacebook;
@property (weak, nonatomic) IBOutlet UIButton           *btSend;

- (instancetype)initWithFrame:(CGRect)frame andCompleteBlock:(void (^)(NSString *text, BOOL isTwitterEnable, BOOL isFacebookEnable))block;

-(IBAction)btTwitter_Touched:(id)sender;
-(IBAction)btFacebook_Touched:(id)sender;
-(IBAction)btSend_Touched:(id)sender;
@end
