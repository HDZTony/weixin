//
//  WeiChat.m
//  WeiChat
//
//  Created by jinke on 15/9/16.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "WeiChatMode.h"
#import <UIKit/UIKit.h>
@implementation WeiChatMode 

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)WeiChatWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


@end
