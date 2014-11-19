//
//  SettingsView.m
//  Giga
//
//  Created by vandong on 11/19/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import "SettingsView.h"

@implementation SettingsView

- (instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] lastObject];
    
    return self;
}
@end
