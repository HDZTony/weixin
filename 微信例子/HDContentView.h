//
//  HDContentView.h
//  微信例子
//
//  Created by 何东洲 on 16/1/14.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYContentFrameMode.h"
#import "HDFriendPhotosView.h"
@interface HDContentView : UIView
@property (nonatomic,strong) PYContentFrameMode *frameMode;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *customTextLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 配图相册**/
@property (nonatomic, weak) HDFriendPhotosView *photosView;
@end
