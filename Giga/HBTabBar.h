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


typedef enum {
    ENUM_TAP_TYPE_SIMPLE,
    ENUM_TAP_TYPE_ADVANCE
}ENUM_TAP_TYPE;

@interface HBTabItem :NSObject
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) ENUM_TAP_TYPE type;
@property (strong, nonatomic) UIView *subContentView;
+ (instancetype)initWithTitle:(NSString*)title type:(ENUM_TAP_TYPE)type contentView:(UIView*)contentView;
@end

@interface HBTabItemView : UIView
@property (assign, nonatomic) BOOL selected;
@property (strong, nonatomic) UIButton *mainButton;
@property (strong, nonatomic) UIImageView *imgBackground;
@property (strong, nonatomic) UILabel *lbTitle;
+ (instancetype)tabViewWithItem:(HBTabItem*)item andFrame:(CGRect)frame;

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
