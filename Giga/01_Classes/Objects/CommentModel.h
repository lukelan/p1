//
//  CommentItem.h
//  Giga
//
//  Created by vandong on 11/27/14.
//  Copyright (c) 2014 Hoang Ho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface CommentModel : BaseModel
@property(strong, nonatomic) NSString           *commentText;
@property(strong, nonatomic) NSString           *postDate;
@property(strong, nonatomic) NSMutableArray     *arReply;
@property(nonatomic) NSInteger                  numLike;
@property(nonatomic) NSInteger                  numDisLike;

@property(nonatomic) BOOL                       isReply; // to identify this is comment or reply
@property(nonatomic) BOOL                       isVote;
// for layout of cell
@property(nonatomic) float                      cellHeight;
@property(nonatomic) float                      commentTextHeight;
@end
