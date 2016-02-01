//
//  WXTableViewCell.h
//  微信例子
//
//  Created by 何东洲 on 15/11/20.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXFrameMode.h"


@interface WXTableViewCell : UITableViewCell
@property(strong, nonatomic) WXFrameMode *frameMode;
///** 昵称 */
//@property (nonatomic, weak) UILabel *nameLabel;
///** 正文 */
//@property (nonatomic, weak) UILabel *text;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
///** 头像 */
//@property (nonatomic, weak) UIImageView *iconView;

@end
