//
//  Utils.m
//  Giga
//
//  Created by Hoang Ho on 11/25/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "Utils.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

@implementation Utils

+ (void)showHUDForView:(UIView*)v
{
    [MBProgressHUD showHUDAddedTo:v
                         animated:YES];
}

+ (void)showHUDForView:(UIView*)v
               message:(NSString*)msg
{
    if (!msg)
        [MBProgressHUD showHUDAddedTo:v
                             animated:YES];
    else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:v
                                                  animated:YES];
        hud.labelText = msg;
    }
}

+ (void)hideHUDForView:(UIView*)v
{
    [MBProgressHUD hideHUDForView:v
                         animated:YES];
}


//Object
+ (NSString*)autoDescribe:(id)instance
{
    @try {
        NSString *headerString = [NSString stringWithFormat:@"%@:%p:: ",[instance class], instance];
        return [headerString stringByAppendingString:[self autoDescribe:instance classType:[instance class]]];
    }
    @catch (NSException *exception){
        return [instance description];
    }
    @finally {
        
    }
}

// Finds all properties of an object, and prints each one out as part of a string describing the class.
+ (NSString*)autoDescribe:(id)instance classType:(Class)classType
{
    NSUInteger count;
    objc_property_t *propList = class_copyPropertyList(classType, &count);
    NSMutableString *propPrint = [NSMutableString string];
    int numberLine = 3;
    for ( int i = 0; i < count; i++ )
    {
        objc_property_t property = propList[i];
        
        const char *propName = property_getName(property);
        NSString *propNameString =[NSString stringWithCString:propName encoding:NSASCIIStringEncoding];
        
        if(propName)
        {
            id value = [instance valueForKey:propNameString];
            [propPrint appendString:[NSString stringWithFormat:@"%@=%@ ; ", propNameString, value]];
            numberLine --;
            if (numberLine == 0){
                numberLine = 3;
                [propPrint appendString:@"\n"];
            }
        }
    }
    free(propList);
    
    
    // Now see if we need to map any superclasses as well.
    Class superClass = class_getSuperclass( classType );
    if ( superClass != nil && ! [superClass isEqual:[NSObject class]] )
    {
        NSString *superString = [self autoDescribe:instance classType:superClass];
        [propPrint appendString:superString];
    }
    
    return propPrint;
}


//localized strings
NSString* localizedString(NSString *key)
{
    static NSDictionary * jsonLanguage;
    if (!jsonLanguage) {
//        NSString* filePath = @"String_en";
//        NSString* fileRoot = [[NSBundle mainBundle]
//                              pathForResource:filePath ofType:@"txt"];
//        NSString* fileContents =
//        [NSString stringWithContentsOfFile:fileRoot
//                                  encoding:NSUTF8StringEncoding error:nil];
//        NSData *webData = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
//        
//        NSError *error;
//        jsonLanguage = [NSJSONSerialization JSONObjectWithData:webData options:0 error:&error];
    }
//    NSString *tt = [jsonLanguage objectForKey:key];
//    return tt ? tt: key;
    return key;
}

UIFont* BOLD_FONT_WITH_SIZE(CGFloat size)
{
    return [UIFont fontWithName:FONT_BOLD size:size];
}

UIFont* NORMAL_FONT_WITH_SIZE(CGFloat size)
{
    return [UIFont fontWithName:FONT_NORMAL size:size];
}

@end
