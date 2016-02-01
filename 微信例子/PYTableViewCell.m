//
//  PYTableViewCell.m
//  微信例子
//
//  Created by 何东洲 on 15/12/21.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import "PYTableViewCell.h"
@interface PYTableViewCell()
@property (nonatomic, weak) HDContentView *content;
@property (nonatomic, weak) HDCommentView *commentView;
@end
@implementation PYTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) { // 初始化子控件
        //朋友圈内容
        HDContentView *contentView = [[HDContentView alloc]init];
        [self.contentView addSubview:contentView];
        self.content = contentView;
        //朋友圈内容评论
        HDCommentView *commentView = [[HDCommentView alloc]init];
        [self.contentView addSubview:commentView];
        self.commentView = commentView;
    }
    return self;
}
-(void)setFrameMode:(PYFrameMode *)frameMode{
    _frameMode = frameMode;
    //原创内容
    self.content.frameMode = frameMode.contentFrameMode;
    //评论内容
    self.commentView.frameMode = frameMode.commentFrameMode;

}



@end
