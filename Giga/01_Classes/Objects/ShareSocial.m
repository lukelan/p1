//
//  ShareSocial.m
//  Giga
//
//  Created by vandong on 11/27/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "ShareSocial.h"
#import "AppDelegate.h"
#import <Social/Social.h>

@interface ShareSocial() <UIActionSheetDelegate>

@end

@implementation ShareSocial
+ (ShareSocial *)share {
    static ShareSocial  *_instance;
    static dispatch_once_t dispatch_one;
        dispatch_once(&dispatch_one, ^{
            _instance = [ShareSocial new];
        });

    return _instance;
}

- (void)showShareSelectionInView:(UIView *)view {
    UIActionSheet *actionSheet1 = [[UIActionSheet alloc]
                                   initWithTitle:@""
                                   delegate:self
                                   cancelButtonTitle: localizedString(@"Cancel")
                                   destructiveButtonTitle:nil
                                   otherButtonTitles:localizedString(@"Facebook"),localizedString(@"Twitter"), localizedString(@"LINE"), localizedString(@"Copy Link"), nil];
    
//    AppDelegate *app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    [actionSheet1 showInView: view];
}

#pragma mark - functions share
- (void)showFacebook:(NSString*)file {
    AppDelegate *app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = app.window.rootViewController;
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [controller setInitialText:[NSString stringWithFormat:@"%@　#ガールズピックス", @"_articleObj.title"]];
    [controller addURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://girlspicks.co/article.html?id=%@&cat_id=%@",@"article_id",@"category_id"]]];
    
    [vc presentViewController:controller animated:YES completion:nil];
    
    SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultCancelled) {
            
            NSLog(@"delete");
            
        }else if (result == SLComposeViewControllerResultDone) {
            //            [Common showAlert:@"Shared successfully"];
            
            
//            [self.view addSubview:postDoneBaseView];
//            postDoneBaseView.alpha = 0.0;
//            postDoneBaseView.center = self.view.center;
//            
//            [UIView animateWithDuration:0.1f
//                             animations:^{
//                                 postDoneBaseView.alpha = 1.0;
//                             }
//                             completion:^(BOOL finished){
//                             }];
            
        }
        else
            
        {
            NSLog(@"post");
        }
        
        //   [composeController dismissViewControllerAnimated:YES completion:Nil];
    };
    controller.completionHandler =myBlock;
}


-(void)sendTwitter{
    AppDelegate *app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = app.window.rootViewController;

    SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [composeController setInitialText:[NSString stringWithFormat:@"%@　#ガールズピックス", @"_articleObj.title"]];
    [composeController addURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://girlspicks.co/article.html?id=%@&cat_id=%@",@"article_id",@"category_id"]]];
    [composeController addImage:[UIImage imageNamed:@"Icon-60.png"]];
    [vc presentViewController:composeController
                       animated:YES completion:nil];
    
    SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultCancelled) {
            
            NSLog(@"delete");
            
        }else if (result == SLComposeViewControllerResultDone) {
            //            [Common showAlert:@"Shared successfully"];
            
//            [self.view addSubview:postDoneBaseView];
//            postDoneBaseView.alpha = 0.0;
//            postDoneBaseView.center = self.view.center;
//            
//            [UIView animateWithDuration:0.1f
//                             animations:^{
//                                 postDoneBaseView.alpha = 1.0;
//                             }
//                             completion:^(BOOL finished){
//                             }];
            
        }
        else
            
        {
            NSLog(@"post");
        }
        
        //   [composeController dismissViewControllerAnimated:YES completion:Nil];
    };
    composeController.completionHandler =myBlock;
    
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"selected index: %i", buttonIndex);
    if (buttonIndex == 0){
        [self showFacebook:@""];
    }else if (buttonIndex == 1){
        [self sendTwitter];
    }else if (buttonIndex == 2){
//        [self sendLine];
    }else if (buttonIndex == 3){
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:@"http://girlspicks.co/article.html?id=%@&cat_id=%@",@"article_id",@"category_id"];
    }
}
@end
