//
//  PYCommentFrame.m
//  微信例子
//
//  Created by 何东洲 on 16/1/19.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "PYCommentFrame.h"

@implementation PYCommentFrame
-(void)setMode:(FriendMode *)mode{
    _mode = mode;
    // 1.昵称
    CGFloat nameX = 0;
    CGFloat nameY = 0;
    NSDictionary *nameAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGSize nameSize = [mode.name sizeWithAttributes:nameAttributes];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    //2.评论
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + 5;
    CGFloat textW = [UIScreen mainScreen].bounds.size.width - 100;
    CGSize textMaxSize = CGSizeMake(textW,MAXFLOAT);
    NSDictionary *textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGSize textSize = [mode.comment boundingRectWithSize:textMaxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil].size;
    self.commentFrame = (CGRect){{textX, textY}, textSize};
    //自己的frame
    CGRect frame = self.frame;
     frame.size.width = [UIScreen mainScreen].bounds.size.width - 100;
    frame.size.height = textSize.height + 20;
    self.frame = frame;
    
}
@end
