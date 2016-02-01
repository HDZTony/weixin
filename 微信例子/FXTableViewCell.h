//
//  FXTableViewCell.h
//  微信例子
//
//  Created by 何东洲 on 16/1/29.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDSettingMode.h"
@class HDSettingMode;
@interface FXTableViewCell : UITableViewCell
/** cell对应的item数据 */
@property (nonatomic, strong)HDSettingMode *item;
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows;


@end
