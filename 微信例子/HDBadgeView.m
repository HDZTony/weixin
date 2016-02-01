//
//  HDBadgeView.m
//  微信例子
//
//  Created by 何东洲 on 16/1/30.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDBadgeView.h"

@implementation HDBadgeView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        // 按钮的高度就是背景图片的高度
        CGRect frame = self.frame;
        frame.size.height = self.currentBackgroundImage.size.height;
        self.frame = frame;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    // 设置文字
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    // 根据文字计算自己的尺寸
    NSDictionary *attribute = @{NSFontAttributeName:self.titleLabel.font};
    CGRect frame = self.frame;
    frame.size = [badgeValue sizeWithAttributes:attribute];
    self.frame = frame;
    CGFloat bgW = self.currentBackgroundImage.size.width;
    if (self.titleLabel.frame.size.width < bgW) {
        frame.size.width = bgW;
    } else {
        frame.size.width = self.titleLabel.frame.size.width + 10;
    }
    self.frame = frame;
}



@end
