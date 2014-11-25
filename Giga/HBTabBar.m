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
         CGRect frameButton = CGRectMake(startX, self.frame.size.height - HeightItem - HeightBorderBottom, WidthItem, HeightItem + 2);
         HBTabItem *btn = [HBTabItem buttonWithType:UIButtonTypeCustom andFrame:frameButton];
         [btn setBackgroundImage:[UIImage imageNamed:@"image-bg-white"] forState:UIControlStateNormal];
         [btn setBackgroundImage:[UIImage imageNamed:@"image-bg-blue"] forState:UIControlStateSelected];
         [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
         [btn setTitleColor:RGB(25, 178, 249) forState:UIControlStateNormal];
          [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
         btn.layer.cornerRadius = 3.0f;
         btn.layer.masksToBounds = YES;
          btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
          // you probably want to center it
          btn.titleLabel.textAlignment = NSTextAlignmentCenter;
         [btn setTitle:items[i] forState:UIControlStateNormal];

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
   for (UIButton *btn in scrollView.subviews) {
      if ([btn isKindOfClass:[UIButton class]]) {
         btn.selected = NO;
      }
   }
   if (currenItem == -1) {
      //select first item
      UIButton *firstBtn = (UIButton*)[scrollView viewWithTag:1];
      if (firstBtn) {
         [self clickOnItem:firstBtn];
      }
   }else{
      //if has one item was selected
      UIButton *currentBtn = (UIButton*)[scrollView viewWithTag:currenItem + 1];
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
            UIButton *lastBtn = (UIButton*)[scrollView viewWithTag:currenItem + 1];
            lastBtn.selected = NO;
         }
         btn.selected = YES;
         
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


@implementation HBTabItem

+ (id)buttonWithType:(UIButtonType)buttonType andFrame:(CGRect)frame
{
   HBTabItem *instance = [super buttonWithType:buttonType];
   instance.frame = frame;
   return instance;
}

- (void)setSelected:(BOOL)selected
{
   [super setSelected:selected];
   UIView *parentView = self.superview;
   int heightOfButton = self.selected ? HeightExpandedItem : HeightItem;
   self.frame = RECT_WITH_Y_HEIGHT(self.frame, parentView.frame.size.height - heightOfButton - HeightBorderBottom, heightOfButton + 2);
}

@end
