//
//  HDEmotionKeyboard.m
//  微信例子
//
//  Created by 何东洲 on 16/1/22.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDEmotionKeyboard.h"
#import "HDEmotionListView.h"
#import "HDEmotionToolBar.h"
#import "HDEmotionContent.h"

@interface HDEmotionKeyboard()<HDEmotionToolbarDelegate>
@property (nonatomic, weak) HDEmotionListView *listView;
@property (nonatomic, weak) HDEmotionToolBar *toolBar;
@end
@implementation HDEmotionKeyboard


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
        //初始化😊列表
        HDEmotionListView *listView = [[HDEmotionListView alloc]init];
        self.listView = listView;
        [self addSubview:listView];
        
        //初始化滚动视图
        HDEmotionToolBar *toolBar = [[HDEmotionToolBar alloc]init];
        self.toolBar = toolBar ;
        toolBar.delegate = self;
        [self addSubview:toolBar];
    }
    return self;
}
-(void)layoutSubviews{
    CGFloat toolBarX = 0;
    CGFloat toolBarHeight = 35;
    CGFloat toolBarY = self.frame.size.height - toolBarHeight ;
    CGFloat toolBarWidth = ScreenWidth;
    self.toolBar.frame = CGRectMake(toolBarX, toolBarY, toolBarWidth, toolBarHeight);
    CGFloat listViewX = 0;
    CGFloat listViewY = 0;
    CGFloat listViewWidth = ScreenWidth;
    CGFloat listViewHeight = toolBarY - listViewY;
    self.listView.frame = CGRectMake(listViewX, listViewY, listViewWidth, listViewHeight);
}
#pragma 代理方法
-(void)emotionToolbar:(HDEmotionToolBar *)toolbar didSelectedButton:(HDEmotionType)emotionType{
    switch (emotionType) {
        case HDEmotionTypeDefault:// 默认
            self.listView.emotions = [HDEmotionContent defaultEmotions];
          
            break;
            
        case HDEmotionTypeEmoji: // Emoji
            self.listView.emotions = [HDEmotionContent emojiEmotions];
           
            break;
            
        case HDEmotionTypeLxh: // 浪小花
            self.listView.emotions = [HDEmotionContent lxhEmotions];
                    break;
            
        case HDEmotionTypeRecent: // 最近
            self.listView.emotions = [HDEmotionContent recentEmotions];

            break;
    }

}

@end
