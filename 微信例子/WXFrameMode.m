//
//  WXFrameMode.m
//  微信例子
//
//  Created by 何东洲 on 15/12/6.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import "WXFrameMode.h"


@implementation WXFrameMode
-(void)setMode:(WeiChatMode *)mode{
    _mode = mode;

    // 1.时间
    CGFloat timeY = 10;
     NSDictionary *timeAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGSize timeSize = [mode.time sizeWithAttributes:timeAttributes];
    CGFloat timeX = [UIScreen mainScreen].bounds.size.width - 10 - timeSize.width;
    self.timeFrame = (CGRect){{timeX,timeY}, timeSize};
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    //无效的高度
    CGFloat h = 80;
    self.frame = CGRectMake(x, y, w, h);
    
    

    
}


@end
