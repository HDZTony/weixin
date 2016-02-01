//
//  HDEmotion.h
//  微信例子
//
//  Created by 何东洲 on 16/1/23.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的文png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的编码 */
@property (nonatomic, copy) NSString *code;


/** 表情的存放文件夹\目录 */
@property (nonatomic, copy) NSString *directory;
/** emoji表情的字符 */
@property (nonatomic, copy) NSString *emoji;
@end
