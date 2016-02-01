//
//  HDContentView.m
//  微信例子
//
//  Created by 何东洲 on 16/1/14.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDContentView.h"

@implementation HDContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化子控件
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2.正文（内容）
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = [UIFont systemFontOfSize:12];
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.customTextLabel = textLabel;
        
        // 3.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        //进行子控件一次性的属性设置
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 4.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        //相册
        HDFriendPhotosView *photosView = [[HDFriendPhotosView alloc]init];
        [self addSubview:photosView];
        self.photosView = photosView;

    }
    return self;

}
-(void)setFrameMode:(PYContentFrameMode *)frameMode{
    _frameMode = frameMode;
    
    self.frame = frameMode.frame;
    // 取出微信数据
    FriendMode *dataMode = frameMode.mode;
    // 1.昵称
    self.nameLabel.text = dataMode.name;
    self.nameLabel.frame = frameMode.nameFrame;
    
    // 2.正文（内容）
    self.customTextLabel.text = dataMode.text;
    self.customTextLabel.frame = frameMode.textFrame;
    
    // 3.时间
    self.timeLabel.text = dataMode.time;
    self.timeLabel.frame = frameMode.timeFrame;
    
    // 4.头像
    self.iconView.image = [UIImage imageNamed:dataMode.icon];
    self.iconView.frame = frameMode.iconFrame;
    //5.相册
    if (dataMode.imagesURL.count) { // 有配图
        self.photosView.frame = frameMode.photosFrame;
        self.photosView.imageURLs = dataMode.imagesURL;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
}


@end
