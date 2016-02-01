//
//  HDCcomposeInputView.m
//  微信例子
//
//  Created by 何东洲 on 16/1/21.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDComposeInputView.h"

@implementation HDComposeInputView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        // 添加所有的子控件
        self.button = [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:HDComposeInputViewButtonTypeCamera];
        self.button = [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:HDComposeInputViewButtonTypePicture];
        self.button = [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:HDComposeInputViewButtonTypeMention];
        self.button = [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:HDComposeInputViewButtonTypeTrend];
        self.button = [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:HDComposeInputViewButtonTypeEmotion];
    }
    return self;
}

/**
 *  添加一个按钮
 *
 *  @param icon     默认图标
 *  @param highIcon 高亮图标
 */
- (UIButton *)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(HDComposeInputViewButtonType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
    return button;
}
/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    
    if ([self.delegate respondsToSelector:@selector(composeTool:didClickedButton:)]) {
        [self.delegate composeTool:self didClickedButton:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = self.subviews.count;
    CGFloat buttonW = self.frame.size.width / count;
    CGFloat buttonH = self.frame.size.height;
    for (int i = 0; i<count; i++) {
        UIButton *button = self.subviews[i];
        CGFloat y = 0;
        CGFloat width = buttonW;
        CGFloat height = buttonH;
        CGFloat x = i * buttonW;
        button.frame = CGRectMake(x, y, width, height);
    }
    
}
-(void)setShowEmotionButton:(BOOL)showEmotionButton{
    _showEmotionButton = showEmotionButton;


    if (showEmotionButton) { // 显示表情按钮
        [self.button setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    } else { // 切换为键盘按钮
        [self.button setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }

}

@end
