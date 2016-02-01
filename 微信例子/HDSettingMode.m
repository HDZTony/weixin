//
//  HDSettingMode.m
//  微信例子
//
//  Created by 何东洲 on 15/12/1.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import "HDSettingMode.h"

@implementation HDSettingMode
+(instancetype)initWithTitle:(NSString *)title iconName:(NSString *)iconName{
    HDSettingMode *setting = [[HDSettingMode alloc]init];
    setting.title = title;
    setting.iconName = iconName;
    return setting;
}
@end
