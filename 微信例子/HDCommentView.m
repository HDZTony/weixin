//
//  HDCommentView.m
//  微信例子
//
//  Created by 何东洲 on 16/1/14.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDCommentView.h"

@implementation HDCommentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"timeline_retweet_background"];
        //初始化子控件
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        //2.评论
        UILabel *commentLabel = [[UILabel alloc] init];
        commentLabel.font = [UIFont systemFontOfSize:13];
        commentLabel.numberOfLines = 0;
        [self addSubview:commentLabel];
        self.commentLabel = commentLabel;
    }
    return self;
}
-(void)setFrameMode:(PYCommentFrame *)frameMode{
    _frameMode = frameMode;
    
    self.frame = frameMode.frame;
    // 取出微信数据
    FriendMode *dataMode = frameMode.mode;
    // 1.昵称
    self.nameLabel.text = dataMode.name;
    self.nameLabel.frame = frameMode.nameFrame;
    //2.评论
    self.commentLabel.text = dataMode.comment;
    self.commentLabel.frame = frameMode.commentFrame;
}

@end
