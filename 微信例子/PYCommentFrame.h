//
//  PYCommentFrame.h
//  微信例子
//
//  Created by 何东洲 on 16/1/19.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendMode.h"
#import <UIKit/UIKit.h>
@interface PYCommentFrame : NSObject
@property (nonatomic, strong)FriendMode *mode;
/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
//评论
@property (nonatomic, assign)CGRect commentFrame;
/** 自己的frame */
@property (nonatomic, assign) CGRect frame;
@end
