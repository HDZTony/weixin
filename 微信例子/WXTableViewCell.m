//
//  WXTableViewCell.m
//  微信例子
//
//  Created by 何东洲 on 15/11/20.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import "WXTableViewCell.h"

@implementation WXTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) { // 初始化子控件

        
        // 3.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        //进行子控件一次性的属性设置
        timeLabel.textColor = [UIColor orangeColor];
        timeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;

    }
    return self;
}


-(void)setFrameMode:(WXFrameMode *)frameMode{
    _frameMode = frameMode;
    self.frame = frameMode.frame;
    // 取出微信数据
    WeiChatMode *dataMode = frameMode.mode;

    self.textLabel.text = dataMode.name;

    self.detailTextLabel.text = dataMode.text;
    // 3.时间
    self.timeLabel.text = dataMode.time;
    self.timeLabel.frame = frameMode.timeFrame;
    // 4.头像
    self.imageView.image = [UIImage imageNamed:dataMode.icon];
    
    
    

    
}





@end
