//
//  DemoDetailViewController.h
//  Giga
//
//  Created by vandong on 11/19/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoDetailViewController : UIViewController

@property(weak, nonatomic) IBOutlet UIScrollView                *srv;
@property(strong, nonatomic) IBOutlet UIView                    *vContent;
@property(weak, nonatomic) IBOutlet UITextField                 *tf;
@property(strong, nonatomic) IBOutlet UIView                    *vShare;
- (IBAction)btBack_Touched:(id)sender;
@end
