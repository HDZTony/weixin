//
//  HDGroupMode.h
//  微信例子
//
//  Created by 何东洲 on 15/12/1.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDGroupMode : NSObject
/** 头部标题 */
@property(strong,nonatomic) NSString *headerTitle;
/** 尾部标题 */
@property(strong,nonatomic) NSString *footerTitle;
/** 组中的行数组 */
@property(strong,nonatomic) NSArray *items;

@end
