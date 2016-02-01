//
//  FriendMode.h
//  微信例子
//
//  Created by 何东洲 on 15/12/18.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateTools.h"
@interface FriendMode : NSObject
/** 昵称 */
@property (nonatomic,copy) NSString *name;
/** 时间 */
@property (nonatomic,copy) NSString *time;
/** 正文 */
@property (nonatomic,copy) NSString *text;
/**头像*/
@property (nonatomic,copy) NSString *icon;
//内容图
@property (nonatomic,copy) NSArray *imagesURL;
//评论
@property (nonatomic,copy) NSString *comment;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)FriendWithDict:(NSDictionary *)dict;

@end
