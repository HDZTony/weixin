//
//  PYContentFrameMode.m
//  微信例子
//
//  Created by 何东洲 on 16/1/14.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "PYContentFrameMode.h"

@implementation PYContentFrameMode
-(void)setMode:(FriendMode *)mode{
    _mode = mode;
    // 1.头像
    CGFloat iconX = 10;
    CGFloat iconY = 10;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    // 2.昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + 10;
    CGFloat nameY = iconY;
    NSDictionary *nameAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGSize nameSize = [mode.name sizeWithAttributes:nameAttributes];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    // 3.正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + 10;
    CGFloat textW = [UIScreen mainScreen].bounds.size.width - textX - 20;
    CGSize textMaxSize = CGSizeMake(textW,MAXFLOAT);
    NSDictionary *textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGSize textSize = [mode.text boundingRectWithSize:textMaxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil].size;
    
    self.textFrame = (CGRect){{textX, textY}, textSize};
  
    /**4. 内容图片 */
    if (mode.imagesURL.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + 5;
        int maxCols = HDPhotosMaxCols(mode.imagesURL.count);        
        // 总列数
        int totalCols = mode.imagesURL.count >= maxCols ?  maxCols : mode.imagesURL.count;
        // 总行数
        int totalRows = (mode.imagesURL.count + maxCols - 1) / maxCols;
        // 计算尺寸
        CGFloat photosW = totalCols * HDPhotoW + (totalCols - 1) * 10;
        CGFloat photosH = totalRows * HDPhotoH + (totalRows - 1) * 10;
        CGSize photosSize = CGSizeMake(photosW, photosH);
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
    }
    //5.时间
    CGFloat timeY = 0;
    if (mode.imagesURL.count) {
        timeY = CGRectGetMaxY(self.photosFrame) + 10;
        
    }else{
        timeY = CGRectGetMaxY(self.textFrame) + 10;
    }
    NSDictionary *timeAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGSize timeSize = [mode.time sizeWithAttributes:timeAttributes];
    CGFloat timeX = nameX;
    self.timeFrame = (CGRect){{timeX,timeY}, timeSize};
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = CGRectGetMaxY(self.timeFrame) + 10;
    self.frame = CGRectMake(x, y, w, h);
    
}

@end
