//
//  InputCommentView.m
//  Giga
//
//  Created by VisiKardMacBookPro on 11/28/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "InputCommentView.h"

@implementation InputCommentView
@synthesize containerView;
@synthesize textView;

- (instancetype)initWithFrame:(CGRect)frame andCompleteBlock:(void (^)(NSString *text, BOOL isTwitterEnable, BOOL isFacebookEnable))block {
    self = [self initWithFrame:frame];
    completeBlock = block;
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] firstObject];
    self.frame = frame;
    
    self.btSend.layer.cornerRadius = 5;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification 
                                               object:nil];		

//    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, 240, 40)];
    textView.isScrollable = NO;
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
    textView.minNumberOfLines = 1;
    textView.maxNumberOfLines = 4;
    // you can also set the maximum height in points with maxHeight
    // textView.maxHeight = 200.0f;
    textView.returnKeyType = UIReturnKeyDefault; //just as an example
    textView.font = [UIFont systemFontOfSize:15.0f];
    textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    textView.placeholder = @"コメント入力";
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textView.layer.cornerRadius = 5;
    textView.layer.borderColor = RGB(102, 102, 102).CGColor;
    textView.layer.borderWidth = 1;
    textView.textColor = RGB(141, 141, 141);


    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToClose:)];
    [self addGestureRecognizer:tapGesture];

    [textView becomeFirstResponder];
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tapToClose:(UIGestureRecognizer *) gesture {
    [self removeFromSuperview];
    
}

//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and
    
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self convertRect:keyboardBounds toView:nil];
    
    // get a rect for the textView frame
    CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    containerView.frame = containerFrame;
    
    
    // commit animations
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // get a rect for the textView frame
    CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.bounds.size.height - containerFrame.size.height;
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    containerView.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}

#pragma mark - IBActions
-(IBAction)btTwitter_Touched:(id)sender {
    ((UIButton *)sender).selected = !isTwitterEnable;
    isTwitterEnable = !isTwitterEnable;
}

-(IBAction)btFacebook_Touched:(id)sender {
    ((UIButton *)sender).selected = !isFacebookEnable;
    isFacebookEnable = !isFacebookEnable;
}

-(IBAction)btSend_Touched:(id)sender {
    if (completeBlock) {
        completeBlock(textView.text, isTwitterEnable, isFacebookEnable);
    }
    [self removeFromSuperview];
}

#pragma mark - HPGrowingTextViewDelegate
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = textView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    textView.frame = r;
}



@end
