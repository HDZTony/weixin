//
//  HDEmotionGridView.m
//  微信例子
//
//  Created by 何东洲 on 16/1/23.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDEmotionGridView.h"
#import "HDEmotionView.h"
#import "HDEmotionPopView.h"
#import "HDEmotionContent.h"
@interface HDEmotionGridView()
@property (nonatomic, strong) NSMutableArray *emotionViews;
@property (nonatomic, weak)UIButton *deleteButton;
@property (nonatomic, weak)HDEmotionPopView *popView;
@end
@implementation HDEmotionGridView
-(HDEmotionPopView *)popView{
    if (!_popView) {
        HDEmotionPopView *popView = [HDEmotionPopView popView];
        self.popView = popView;
    }
    return _popView;
}
- (NSMutableArray *)emotionViews
{
    if (!_emotionViews) {
        self.emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        // 给自己添加一个长按手势识别器
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] init];
        [recognizer addTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:recognizer];
        
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 添加新的表情
    int count = emotions.count;
    int currentEmotionViewCount = self.emotionViews.count;
    for (int i = 0; i<count; i++) {
        HDEmotionView *emotionView = nil;
        
        if (i >= currentEmotionViewCount) { // emotionView不够用
            emotionView = [[HDEmotionView alloc] init];
            //emotionView.backgroundColor = HDRandomColor;
            [emotionView addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:emotionView];
            [self.emotionViews addObject:emotionView];
        } else { // emotionView够用
            emotionView = self.emotionViews[i];
        }
        // 传递模型数据
        emotionView.emotion = emotions[i];
        emotionView.hidden = NO;
    }
    
    // 隐藏多余的emotionView
    for (int i = count; i<currentEmotionViewCount; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.hidden = YES;
    }
}
-(void)emotionClick:(HDEmotionView *)emotionView{
    [self.popView showFromEmotionView:emotionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    // 选中表情
    [self selectedEmotion:emotionView.emotion];
    
}
-(void)deleteClick:(UIButton *)deleteButton{
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:HDEmotionDidDeletedNotification object:nil userInfo:nil];
}
- (void)longPress:(UILongPressGestureRecognizer *)recognizer{
    // 1.捕获触摸点
    CGPoint point = [recognizer locationInView:recognizer.view];
    __block HDEmotionView * selecetedEmotionView = nil;
    // 2.检测触摸点落在哪个表情上
    [self.emotionViews enumerateObjectsUsingBlock:^(HDEmotionView *emotionView,NSUInteger idx,BOOL *stop){
        if (CGRectContainsPoint(emotionView.frame, point)) {
            selecetedEmotionView = emotionView;
            // 停止遍历
            *stop = YES;
        }
    
    }];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) { // 手松开了
        // 移除表情弹出控件
        [self.popView removeFromSuperview];
        NSLog(@"手松开了-%@",selecetedEmotionView.emotion.chs);
        // 选中表情
        [self selectedEmotion:selecetedEmotionView.emotion];
    } else { // 手没有松开
        // 显示表情弹出控件
        NSLog(@"-手没有松开-%@",selecetedEmotionView.emotion.chs);
        [self.popView showFromEmotionView:selecetedEmotionView];
    }
   

}
/**
 *  选中表情
 */
- (void)selectedEmotion:(HDEmotion *)emotion
{
    if (emotion == nil) return;
#warning 注意：先添加使用的表情，再发通知
    // 保存使用记录
    [HDEmotionContent addRecentEmotion:emotion];
    
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:HDEmotionDidSelectedNotification object:nil userInfo:@{HDSelectedEmotion : emotion}];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    
    // 1.排列所有的表情
    int count = self.emotionViews.count;
    CGFloat emotionViewW = (self.frame.size.width - 2 * leftInset) / HDEmotionMaxCols;
    CGFloat emotionViewH = (self.frame.size.height - topInset) / HDEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *emotionView = self.emotionViews[i];
        CGFloat x = leftInset + (i % HDEmotionMaxCols) * emotionViewW;
        CGFloat y = topInset + (i / HDEmotionMaxCols) * emotionViewH;
        CGFloat width = emotionViewW;
        CGFloat height = emotionViewH;
        emotionView.frame = CGRectMake(x, y, width, height);
    }
    
    // 2.删除按钮
    CGFloat width = emotionViewW;
    CGFloat height = emotionViewH;
    CGFloat x = self.frame.size.width - leftInset - width;
    CGFloat y = self.frame.size.height - height;
    self.deleteButton.frame = CGRectMake(x, y, width, height);
}

@end
