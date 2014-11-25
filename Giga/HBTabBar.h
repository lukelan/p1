//
//  HBTabBar.h
//  DemoApp
//
//  Created by Hoang Ho on 11/18/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WidthItem 75
#define HeightItem 35
#define MarginItem 2
#define HeightExpandedItem 40
#define HeightBorderBottom 5

@class HBTabBar;

@protocol HBTabBarDelegate <NSObject>

@required
- (BOOL)HBTabBar:(HBTabBar*)tab shouldSelectAtIndex:(int)index;
- (void)HBTabBar:(HBTabBar*)tab didChangeItemIndex:(int)newIndex fromIndex:(int)oldIndex;
@end

@interface HBTabBar : UIView<UIScrollViewDelegate>
{
   UIScrollView *scrollView;
   NSArray *itemSources;
   
   int currenItem;
}
@property (weak, nonatomic) id<HBTabBarDelegate> delegate;
- (HBTabBar*)initWithWithFrame:(CGRect)frame items:(NSArray*)items;
- (void)reloadData;
- (int)currentItemIndex;
@end

@interface HBTabItem : UIButton
+ (id)buttonWithType:(UIButtonType)buttonType andFrame:(CGRect)frame;
@end
