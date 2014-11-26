//
//  CommentItem.h
//  Giga
//
//  Created by vandong on 11/27/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentItem : NSObject
@property(strong, nonatomic) NSString           *commentText;
@property(strong, nonatomic) NSString           *postDate;
@property(strong, nonatomic) NSMutableArray     *arReply;

@property(nonatomic) BOOL                       isReply; // to identify this is comment or reply
@end
