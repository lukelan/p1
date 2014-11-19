//
//  DemoView.h
//  DemoApp
//
//  Created by Hoang Ho on 11/18/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DemoViewDelegate <NSObject>

@required
- (void)DemoViewDidSelectItem:(id)obj;
@end

@interface DemoView : UIView<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) id<DemoViewDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *tableData;
- (instancetype)initWithNumberData:(int)numberItem;
@property (weak, nonatomic) IBOutlet UITableView *tbMain;


@end
