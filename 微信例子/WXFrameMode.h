//
//  WXFrameMode.h
//  微信例子
//
//  Created by 何东洲 on 15/12/6.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WeiChatMode.h"
@class WeiChatMode;
@interface WXFrameMode : NSObject
/**
 *  微信数据
 */
@property (nonatomic,strong) WeiChatMode *mode;

@property (nonatomic, assign) CGRect timeFrame;
/** 自己的frame */
@property (nonatomic, assign) CGRect frame;



@end
