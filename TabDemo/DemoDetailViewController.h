//
//  DemoDetailViewController.h
//  Giga
//
//  Created by vandong on 11/19/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SampleModel;

@interface DemoDetailViewController : UIViewController

@property(weak, nonatomic) IBOutlet UIScrollView                *srv;
@property(strong, nonatomic) IBOutlet UIView                    *vContent;
@property(weak, nonatomic) IBOutlet UITextField                 *tf;
@property(strong, nonatomic) IBOutlet UIView                    *vShare;
@property(weak, nonatomic) IBOutlet UILabel                     *lbTitle;
@property(weak, nonatomic) IBOutlet UILabel                     *lbDetail;
@property(weak, nonatomic) IBOutlet UILabel                     *lbCompanySource;

@property (strong, nonatomic) SampleModel                       *data;
- (IBAction)btBack_Touched:(id)sender;
@end
