//
//  PYFrameMode.m
//  微信例子
//
//  Created by 何东洲 on 15/12/18.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import "PYFrameMode.h"

@implementation PYFrameMode
-(void)setFriendMode:(FriendMode *)friendMode{

    // 1.计算具体内容（
    [self setUpContentFrame:friendMode];
    if (friendMode.comment) {
        // 2.计算评论
        [self setUpCommentFrame:friendMode];
        // 3.计算cell的高度
        self.cellHeight = CGRectGetMaxY(self.commentFrameMode.frame);
    }else{
        // 3.计算cell的高度
        self.cellHeight = CGRectGetMaxY(self.contentFrameMode.frame);
    }
}
-(void)setUpContentFrame:(FriendMode *)mode {
    PYContentFrameMode *frameMode = [[PYContentFrameMode alloc]init];
    frameMode.mode = mode;
    self.contentFrameMode = frameMode;
}
-(void)setUpCommentFrame:(FriendMode *)mode {
    PYCommentFrame *frameMode = [[PYCommentFrame alloc]init];
    frameMode.mode = mode;
    self.commentFrameMode = frameMode;
    //comment 的frame
    CGRect contentFrame  = self.contentFrameMode.frame;
    CGRect commentFrame = self.commentFrameMode.frame;
    commentFrame.origin.x = self.contentFrameMode.nameFrame.origin.x;
    commentFrame.origin.y = CGRectGetMaxY(contentFrame)+ 10;
    self.commentFrameMode.frame = commentFrame;
    
    
}

@end
