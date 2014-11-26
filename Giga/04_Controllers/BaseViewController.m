//
//  BaseViewController.m
//  Giga
//
//  Created by Hoang Ho on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#define SharedAppDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])

- (instancetype)init
{
    @try {
        self = [[SharedAppDelegate mainStoryboard] instantiateViewControllerWithIdentifier:[self.class description]];
    }
    @catch (NSException *exception) {
        self = [super init];
//        if (!self) {
//        }
    }

    return self;
}

#pragma mark - ROTATE

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (BOOL) automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers
{
    return YES;
}

//For iO6

// iOS 6.x and later
- (BOOL)shouldAutorotate {
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft ||
        [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
        return NO;
    }
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) {
        return YES;
    }
    return NO;
}
//for ios 7
- (NSUInteger)supportedInterfaceOrientations {
    //for ipad
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutomaticallyForwardRotationMethods
{
    return  YES;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return  YES;
}

@end
