//
//  HDEmotionContent.m
//  微信例子
//
//  Created by 何东洲 on 16/1/23.
//  Copyright © 2016年 何东洲. All rights reserved.
//
#define HDRecentFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recent_emotions.data"]
#import "HDEmotionContent.h"
#import "HDEmotion.h"
#import "MJExtension.h"
@implementation HDEmotionContent
/** 默认表情 */
static NSArray *_defaultEmotions;
/** emoji表情 */
static NSArray *_emojiEmotions;
/** 浪小花表情 */
static NSArray *_lxhEmotions;
/**  */
static NSMutableArray *_recentEmotions;
+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"de" ofType:@"plist"];
        _defaultEmotions = [HDEmotion mj_objectArrayWithFile:plist];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
    
}

+ (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"em.plist" ofType:nil];
        _emojiEmotions = [HDEmotion mj_objectArrayWithFile:plist];
        [_emojiEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/emoji"];
    }
    
    return _emojiEmotions;
}

+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"lx.plist" ofType:nil];
        _lxhEmotions = [HDEmotion mj_objectArrayWithFile:plist];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}
+(NSArray *)recentEmotions{
    if (!_recentEmotions){
        // 去沙盒中加载最近使用的表情数据
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:HDRecentFilepath];
        if (!_recentEmotions) {
            _recentEmotions =  [NSMutableArray array];
        }
    }
    return _recentEmotions;
}
+(void)addRecentEmotion:(HDEmotion *)emotion{
    // 加载最近的表情数据
    [self recentEmotions];
    // 删除之前的表情
    [_recentEmotions removeObject:emotion];
    // 添加最新的表情
    [_recentEmotions insertObject:emotion atIndex:0];
    // 存储到沙盒中
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:HDRecentFilepath];
}
@end
