//
//  ListCompanyInfoViewController.h
//  Giga
//
//  Created by Hoang Ho on 11/26/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "BaseViewController.h"

@interface ListCompanyInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbSearchCompany;
- (IBAction)btnSearchCompanyTouchUpInside:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tbCompanyInfo;

@end

