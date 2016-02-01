//
//  HDCcomposeInputView.h
//  微信例子
//
//  Created by 何东洲 on 16/1/21.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    HDComposeInputViewButtonTypeCamera, // 照相机
    HDComposeInputViewButtonTypePicture, // 相册
    HDComposeInputViewButtonTypeMention, // 提到@
    HDComposeInputViewButtonTypeTrend, // 话题
    HDComposeInputViewButtonTypeEmotion // 表情
} HDComposeInputViewButtonType;

@class HDComposeInputView;
@protocol HDComposeInputViewDelegate <NSObject>

@optional
- (void)composeTool:(HDComposeInputView *)toolbar didClickedButton:(HDComposeInputViewButtonType)buttonType;

@end
@interface HDComposeInputView : UIView
@property (nonatomic, weak) id<HDComposeInputViewDelegate> delegate;
/**
 *  是否要显示表情按钮
 */
@property (nonatomic, assign, getter = isShowEmotionButton) BOOL showEmotionButton;
@property (nonatomic, weak) UIButton *button;
@end
