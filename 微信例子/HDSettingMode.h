//
//  HDSettingMode.h
//  微信例子
//
//  Created by 何东洲 on 15/12/1.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDSettingMode : NSObject
//标题
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *iconName;
@property (nonatomic, strong)NSString *detailText;
/** 点击这行cell，需要调转到哪个控制器 */
@property (nonatomic, assign) Class destVcClass;
/** 封装点击这行cell想做的事情 */
// block 只能用 copy
@property (nonatomic, copy) void (^operation)();
/** 右边显示的数字标记 */
@property (nonatomic, copy) NSString *badgeValue;
+(instancetype)initWithTitle:(NSString *)title iconName:(NSString *)iconName;


@end
