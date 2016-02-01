//
//  WeiChat.h
//  WeiChat
//
//  Created by : on 15/9/16.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

@interface WeiChatMode : NSObject
/** 昵称 */
@property (nonatomic,copy) NSString *name;
/** 时间 */
@property (nonatomic,copy) NSString *time;
/** 正文 */
@property (nonatomic,copy) NSString *text;
/**头像*/
@property (nonatomic,copy) NSString *icon;


//- (instancetype) initWithName:(NSString *)name
//                         time:(NSString *)time
//                         text:(NSString *)text
//                    imageName:(NSString *)imageName;
//
//+ (instancetype) weiChatWithName:(NSString *)name
//                         time:(NSString *)time
//                         text:(NSString *)text
//                    imageName:(NSString *)imageName;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)WeiChatWithDict:(NSDictionary *)dict;


@end
