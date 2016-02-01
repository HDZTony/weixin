//
//  PYFrameMode.h
//  微信例子
//
//  Created by 何东洲 on 15/12/18.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendMode.h"
#import <UIKit/UIKit.h>
#import "HDContentView.h"
#import "PYContentFrameMode.h"
#import "PYCommentFrame.h"
@interface PYFrameMode : NSObject
/** 子控件的frame数据 */
@property (nonatomic, strong) PYContentFrameMode *contentFrameMode;
@property (nonatomic, strong) PYCommentFrame *commentFrameMode;
@property (nonatomic, strong) FriendMode *friendMode;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end