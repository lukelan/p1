//
//  AppDelegate.h
//  TabDemo
//
//  Created by Hoang Ho on 11/18/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController        *nav;

-(UIStoryboard*)mainStoryboard;
@end
