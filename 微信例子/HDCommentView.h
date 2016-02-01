//
//  HDCommentView.h
//  微信例子
//
//  Created by 何东洲 on 16/1/14.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYCommentFrame.h"
@interface HDCommentView : UIImageView
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *commentLabel;
@property (nonatomic,strong)PYCommentFrame *frameMode;
@end
