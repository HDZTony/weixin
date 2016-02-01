//
//  HDEmotionPopView.m
//  微信例子
//
//  Created by 何东洲 on 16/1/26.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDEmotionPopView.h"

@implementation HDEmotionPopView
+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HDEmotionPopView" owner:nil options:nil] lastObject];
}
/**
 *  当一个控件显示之前会调用一次（如果控件在显示之前没有尺寸，不会调用这个方法）
 *
 *  @param rect 控件的bounds
 */
- (void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"emoticon_keyboard_magnifier"]drawInRect:rect];
}
-(void)showFromEmotionView:(HDEmotionView *)fromEmotionView{
    if (fromEmotionView == nil) return;
    // 1.显示表情
    self.emotionView.emotion = fromEmotionView.emotion;
    
    // 2.添加到窗口上
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 3.设置位置
    CGFloat centerX = fromEmotionView.center.x;
    CGFloat centerY = fromEmotionView.center.y - self.frame.size.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    self.center = [window convertPoint:center fromView:fromEmotionView.superview];

}

@end
