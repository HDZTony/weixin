//
//  HDEmotionView.m
//  微信例子
//
//  Created by 何东洲 on 16/1/24.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDEmotionView.h"

@implementation HDEmotionView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
- (void)setEmotion:(HDEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.code) { // emoji表情
        // 取消动画效果
        [UIView setAnimationsEnabled:NO];
        // 设置emoji表情
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        // 再次开启动画
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView setAnimationsEnabled:YES];
        });
    } else { // 图片表情
        NSString *icon = [NSString stringWithFormat:@"%@", emotion.png];
        UIImage *image = [UIImage imageNamed:icon];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self setImage:image forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

@end
