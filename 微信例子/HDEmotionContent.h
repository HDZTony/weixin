//
//  HDEmotionContent.h
//  微信例子
//
//  Created by 何东洲 on 16/1/23.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDEmotion.h"
@interface HDEmotionContent : NSObject
/**
 *  默认表情
 */
+ (NSArray *)defaultEmotions;
/**
 *  emoji表情
 */
+ (NSArray *)emojiEmotions;
/**
 *  浪小花表情
 */
+ (NSArray *)lxhEmotions;
///**
// *  最近表情
// */
+ (NSArray *)recentEmotions;
+ (void)addRecentEmotion:(HDEmotion *)emotion;
@end
