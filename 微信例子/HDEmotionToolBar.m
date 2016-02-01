//
//  HDEmotionToolBar.m
//  微信例子
//
//  Created by 何东洲 on 16/1/22.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDEmotionToolBar.h"

@implementation HDEmotionToolBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加4个按钮
        [self setupButton:@"最近" tag:HDEmotionTypeRecent];
        self.defaultButton = [self setupButton:@"默认" tag:HDEmotionTypeDefault];
        [self setupButton:@"Emoji" tag:HDEmotionTypeEmoji];
        [self setupButton:@"浪小花" tag:HDEmotionTypeLxh];
        [self buttonClick:self.defaultButton];
        // 2.监听表情选中的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:HDEmotionDidSelectedNotification object:nil];
    }
    return self;
}

/**
 *  添加按钮
 *
 *  @param title 按钮文字
 */
- (UIButton *)setupButton:(NSString *)title tag:(HDEmotionType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    
    // 文字
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 添加按钮
    [self addSubview:button];
    
    // 设置背景图片
    int count = self.subviews.count;
    if (count == 1) { // 第一个按钮
        [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    } else if (count == self.subviews.count) { // 最后一个按钮
        [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    } else { // 中间按钮
        [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    
    return button;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 设置工具条按钮的frame
    CGFloat buttonW = self.frame.size.width / HDEmotionToolbarButtonMaxCount;
    CGFloat buttonH = self.frame.size.height;
    for (int i = 0; i<HDEmotionToolbarButtonMaxCount; i++) {
        UIButton *button = self.subviews[i];
        CGFloat width = buttonW;
        CGFloat height = buttonH;
        CGFloat x = i * buttonW;
        button.frame = CGRectMake(x, 0, width, height);
        
    }
}
/**
 *  表情选中
 */
- (void)emotionDidSelected:(NSNotification *)note
{
    if (self.selectedButton.tag == HDEmotionTypeRecent) {
        [self buttonClick:self.selectedButton];
    }
}

-(UIImage *)stretchableImage:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height * 0.5];
}
-(void)buttonClick:(UIButton *)button{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    // 2.通知代理
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]) {
        [self.delegate emotionToolbar:self didSelectedButton:button.tag];
    }
}
- (void)setDelegate:(id<HDEmotionToolbarDelegate>)delegate
{
    _delegate = delegate;
    
    // 获得“默认”按钮
    UIButton *defaultButton = (UIButton *)[self viewWithTag:HDEmotionTypeDefault];
    // 默认选中“默认”按钮
    [self buttonClick:defaultButton];
}
@end
