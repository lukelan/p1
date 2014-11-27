//
//  HBTabBar.m
//  DemoApp
//
//  Created by Hoang Ho on 11/18/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "HBTabBar.h"
#import "HBMacros.h"

@implementation HBTabBar

- (HBTabBar*)initWithWithFrame:(CGRect)frame items:(NSArray *)items
{
   if(self = [super initWithFrame:frame]){
      self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
      
      scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
      scrollView.contentSize = self.bounds.size;
      scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
      scrollView.delegate = self;
      scrollView.showsHorizontalScrollIndicator = scrollView.showsVerticalScrollIndicator = NO;
      [self addSubview:scrollView];
      
      //items
      
      int startX = 0;
      for (int i = 0; i < items.count; i++) {
          HBTabItem *item = items[i];
         CGRect frameButton = CGRectMake(startX, self.frame.size.height - HeightItem - HeightBorderBottom, WidthItem, HeightItem + 2);
          HBTabItemView *btn = [HBTabItemView tabViewWithItem:item andFrame:frameButton];

         btn.tag = i + 1;
         [btn addTarget:self action:@selector(clickOnItem:) forControlEvents:UIControlEventTouchUpInside];
         [scrollView addSubview:btn];
         startX += WidthItem + MarginItem;
      }
      scrollView.contentSize = CGSizeMake(startX, self.frame.size.height);
      
      UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - HeightBorderBottom, startX, HeightBorderBottom)];
      bottomLineView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
      bottomLineView.backgroundColor = RGB(25, 178, 249);
      [scrollView addSubview:bottomLineView];
      
      currenItem = -1;
   }
   return self;
}

- (void)reloadData
{
   for (HBTabItemView *btn in scrollView.subviews) {
      if ([btn isKindOfClass:[HBTabItemView class]]) {
         btn.selected = NO;
      }
   }
   if (currenItem == -1) {
      //select first item
      HBTabItemView *firstTabView = (HBTabItemView*)[scrollView viewWithTag:1];
      if (firstTabView) {
         [self clickOnItem:firstTabView.mainButton];
      }
   }else{
      //if has one item was selected
      HBTabItemView *currentBtn = (HBTabItemView*)[scrollView viewWithTag:currenItem + 1];
      currentBtn.selected = YES;

       BOOL shouldSelect = [self.delegate HBTabBar:self shouldSelectAtIndex:currenItem];
      if (shouldSelect) {
         [self.delegate HBTabBar:self didChangeItemIndex:currenItem fromIndex:currenItem];
      }
   }
}

- (void)clickOnItem:(UIButton*)btn
{
   int itemIndex = btn.tag - 1;
   if (currenItem != itemIndex) {
      BOOL shouldSelect = [self.delegate HBTabBar:self shouldSelectAtIndex:itemIndex];
      if (shouldSelect) {
         [self.delegate HBTabBar:self didChangeItemIndex:itemIndex fromIndex:currenItem];
         
         if (currenItem != -1) {
            HBTabItemView *lastTabView = (HBTabItemView*)[scrollView viewWithTag:currenItem + 1];
            lastTabView.selected = NO;
         }
         HBTabItemView *currentTabView = (HBTabItemView*)[scrollView viewWithTag:btn.tag];
         currentTabView.selected = YES;
         
         currenItem = itemIndex;
         //scroll to center
         [self scrollToIndex:currenItem];
         
      }
   }
}


- (void)scrollToIndex:(int)index
{
   int buttonTag = index + 1;
   UIButton *btn = (UIButton*)[scrollView viewWithTag:buttonTag];
   
   CGPoint desOffset = CGPointMake(btn.frame.origin.x - (scrollView.frame.size.width/2 - btn.frame.size.width /2), 0);
   if (desOffset.x < 0) {
      desOffset.x = 0;
   }
   if (desOffset.x > scrollView.contentSize.width - scrollView.frame.size.width) {
      desOffset.x = scrollView.contentSize.width - scrollView.frame.size.width;
   }
   [scrollView setContentOffset:desOffset animated:YES];
}

- (int)currentItemIndex
{
   return currenItem;
}
@end


@implementation HBTabItemView
@synthesize imgBackground, lbTitle, mainButton;

+ (instancetype)tabViewWithItem:(HBTabItem*)item andFrame:(CGRect)frame
{
    HBTabItemView *instance = [[HBTabItemView alloc] initWithFrame:frame];
    instance.backgroundColor = [UIColor clearColor];
    
    instance.imgBackground = [[UIImageView alloc] initWithFrame:instance.bounds];
    instance.imgBackground.contentMode = UIViewContentModeScaleToFill;
    instance.imgBackground.image = [UIImage imageNamed:@"image-bg-white"];
    instance.imgBackground.userInteractionEnabled = NO;
    instance.imgBackground.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    instance.lbTitle = [[UILabel alloc] initWithFrame:instance.bounds];
    instance.lbTitle.numberOfLines = 0;
    instance.lbTitle.textAlignment = NSTextAlignmentCenter;
    instance.lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
    instance.backgroundColor = [UIColor clearColor];
    instance.lbTitle.text = item.title;
    [instance.lbTitle setFont:[UIFont systemFontOfSize:14.0f]];
    instance.lbTitle.userInteractionEnabled = NO;
    
    instance.layer.cornerRadius = 3.0f;
    instance.layer.masksToBounds = YES;
    
    instance.mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    instance.mainButton.backgroundColor = [UIColor clearColor];
    instance.mainButton.frame = instance.bounds;
    
    [instance addSubview:instance.imgBackground];
    [instance addSubview:instance.lbTitle];
    [instance addSubview:instance.mainButton];

    
    if (item.type == ENUM_TAP_TYPE_ADVANCE) {
        [instance addSubview:item.subContentView];
        [instance bringSubviewToFront:item.subContentView];
        instance.lbTitle.textAlignment = NSTextAlignmentLeft;
    }
    return instance;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    self.mainButton.selected = self.selected;
    [imgBackground setImage:[UIImage imageNamed:self.selected ?  @"image-bg-blue" :  @"image-bg-white"]];
    [lbTitle setTextColor:self.selected ? [UIColor whiteColor] : RGB(25, 178, 249) ];
   UIView *parentView = self.superview;
   int heightOfButton = self.selected ? HeightExpandedItem : HeightItem;
   self.frame = RECT_WITH_Y_HEIGHT(self.frame, parentView.frame.size.height - heightOfButton - HeightBorderBottom, heightOfButton + 2);
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self.mainButton addTarget:target action:action forControlEvents:controlEvents];
}

- (void)setTag:(NSInteger)tag
{
    [super setTag:tag];
    self.mainButton.tag = tag;
}
@end


@implementation HBTabItem
+ (instancetype)initWithTitle:(NSString*)title type:(ENUM_TAP_TYPE)type contentView:(UIView*)contentView
{
    HBTabItem *instance = [[HBTabItem alloc] init];
    instance.title = title;
    instance.type = type;
    instance.subContentView = contentView;
    return instance;
}

@end
