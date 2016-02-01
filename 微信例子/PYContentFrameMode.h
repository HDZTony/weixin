//
//  PYContentFrameMode.h
//  微信例子
//
//  Created by 何东洲 on 16/1/14.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FriendMode.h"
#import "HDFriendPhotosView.h"

@interface PYContentFrameMode : NSObject
/**
 *  朋友数据
 */
@property (nonatomic,strong) FriendMode *mode;
/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;
/** 头像 */
@property (nonatomic, assign) CGRect iconFrame;
/** 时间 */
@property (nonatomic, assign) CGRect timeFrame;
/** 内容图片 */
@property (nonatomic, assign) CGRect photosFrame;
/** 自己的frame */
@property (nonatomic, assign) CGRect frame;
@end
