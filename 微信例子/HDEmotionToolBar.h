//
//  HDEmotionToolBar.h
//  微信例子
//
//  Created by 何东洲 on 16/1/22.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDEmotionToolBar;
typedef enum {
    HDEmotionTypeRecent, // 最近
    HDEmotionTypeDefault, // 默认
    HDEmotionTypeEmoji, // Emoji
    HDEmotionTypeLxh // 浪小花
} HDEmotionType;
@protocol HDEmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(HDEmotionToolBar *)toolbar didSelectedButton:(HDEmotionType)emotionType;
@end

@interface HDEmotionToolBar : UIView
@property (nonatomic, weak)UIButton *selectedButton;
@property (nonatomic, weak)UIButton *defaultButton;
@property (nonatomic, weak) id<HDEmotionToolbarDelegate> delegate;
@end
