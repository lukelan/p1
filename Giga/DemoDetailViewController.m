//
//  DemoDetailViewController.m
//  Giga
//
//  Created by vandong on 11/19/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "DemoDetailViewController.h"
#import "HBMacros.h"
#import "SampleModel.h"

@interface DemoDetailViewController ()<UITextFieldDelegate>
{
    CGRect      rectShare;
    
    UIView      *vTabHideKeyboard;
    float       keyboardHeight;
}
@end

@implementation DemoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.srv addSubview: self.vContent];    
    self.srv.contentSize = self.vContent.bounds.size;
    rectShare = self.vShare.frame;
    
//    self.tf.inputAccessoryView = self.vShare;
    
    if (self.data) {
        self.lbTitle.text = self.data.title;
        self.lbDetail.text = self.data.des;
        self.lbCompanySource.text = self.data.companySource;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardWillShow:(NSNotification*)notification {
    if (keyboardHeight == 0) {
        NSDictionary* userInfo = [notification userInfo];
        CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        keyboardHeight = keyboardSize.height;
    }
    if (vTabHideKeyboard == nil) {
        vTabHideKeyboard = [[UIView alloc] initWithFrame:self.view.bounds];
        vTabHideKeyboard.backgroundColor = RGBA(0, 0, 0, 0.5);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        [vTabHideKeyboard addGestureRecognizer:tap];
    }
    [self.view addSubview: vTabHideKeyboard];
    [vTabHideKeyboard addSubview: self.vShare];
    self.vShare.frame = RECT_WITH_Y(self.vShare.frame, vTabHideKeyboard.frame.size.height - self.vShare.frame.size.height - keyboardHeight);
}

-(void)hideKeyboard {
    [vTabHideKeyboard removeFromSuperview];
    [self.vContent addSubview: self.vShare];
    self.vShare.frame = rectShare;
    
    [self.view endEditing:YES];
}

- (IBAction)btBack_Touched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
