//
//  SettingViewController.m
//  Giga
//
//  Created by Tai Truong on 11/29/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "SettingViewController.h"
#import "PolicyViewController.h"
#import <MessageUI/MessageUI.h>
#import <SHSegueBlocks/SHSegueBlocks.h>

@interface SettingViewController () <MFMailComposeViewControllerDelegate>
- (IBAction)policyBtnTouchUpInside:(id)sender;
- (IBAction)termOfUseTouchUpInside:(id)sender;
- (IBAction)emailBtnTouchUpInside:(id)sender;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)policyBtnTouchUpInside:(id)sender {
    [self.parentViewController SH_performSegueWithIdentifier:SEGUE_TAB_TO_POLICY_CONTROLLER andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
        PolicyViewController *controller = [theSegue destinationViewController];
        controller.type = enumPolicyViewType_Policy;
    }];
//    PolicyViewController *controller = [[PolicyViewController alloc] init];
//    controller.type = enumPolicyViewType_Policy;
//    [self.parentViewController.navigationController pushViewController:controller animated:YES];
}

- (IBAction)termOfUseTouchUpInside:(id)sender {
    [self.parentViewController SH_performSegueWithIdentifier:SEGUE_TAB_TO_POLICY_CONTROLLER andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
        PolicyViewController *controller = [theSegue destinationViewController];
        controller.type = enumPolicyViewType_TermOfUse;
    }];
//    PolicyViewController *controller = [[PolicyViewController alloc] init];
//    controller.type = enumPolicyViewType_TermOfUse;
//    [self.parentViewController.navigationController pushViewController:controller animated:YES];
}

- (IBAction)emailBtnTouchUpInside:(id)sender {
    [self showMail:@""];
}

#pragma mark - Private Methods

- (void)showMail:(NSString*)file {
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
    mail.mailComposeDelegate  = self;
    [mail setToRecipients:[NSArray arrayWithObjects:@"support@bravo-global.co", nil]];
    [mail setSubject:@""];
    
    
    [mail setMessageBody:file isHTML:YES];
    
    mail.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    if ([MFMailComposeViewController canSendMail]) {
        [self.parentViewController presentViewController:mail animated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HIDE" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HIDE1" object:nil];
        }];
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail was cancelled");
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail was save");
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail was sent");
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail was Failed");
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        default:
            break;
    }
    
    //  [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
