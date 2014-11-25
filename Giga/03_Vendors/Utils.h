//
//  Utils.h
//  Giga
//
//  Created by Hoang Ho on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject
+ (void)showHUDForView:(UIView*)v;
+ (void)showHUDForView:(UIView*)v message:(NSString*)msg;
+ (void)hideHUDForView:(UIView*)v;

//Object
+ (NSString*)autoDescribe:(id)instance;

NSString* localizedString(NSString *key);

UIFont* BOLD_FONT_WITH_SIZE(CGFloat size);
UIFont* NORMAL_FONT_WITH_SIZE(CGFloat size);
@end
