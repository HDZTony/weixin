//
//  HDFriendPhotosView.m
//  微信例子
//
//  Created by 何东洲 on 16/1/13.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDFriendPhotosView.h"
#import "HDFriendPhoto.h"
@implementation HDFriendPhotosView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 预先创建9个图片控件
        for (int i = 0; i<HDPhotosMaxCount; i++) {
            HDFriendPhoto *photoView = [[HDFriendPhoto alloc] init];
            photoView.tag = i;
            [self addSubview:photoView];
            // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];

        }
    }
    return self;
}

-(void)tapPhoto:(UITapGestureRecognizer *)recognizer{
    NSLog(@"%d",recognizer.view.tag);
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.imageURLs.count;
    int maxCols = HDPhotosMaxCols(count);
    for (int i = 0; i<count; i++) {
        HDFriendPhoto *photoView = self.subviews[i];
        CGFloat width = HDPhotoW;
        CGFloat height = HDPhotoH;
        CGFloat x = (i % maxCols) * (HDPhotoW + HDPhotoMargin);
        CGFloat y = (i / maxCols) * (HDPhotoW + HDPhotoMargin);
        photoView.frame = CGRectMake(x, y, width, height);
    }
}
+ (CGSize)sizeWithPhotosCount:(int)photosCount
{
    int maxCols = HDPhotosMaxCols(photosCount);
    
    // 总列数
    int totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    
    // 总行数
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * HDPhotoW + (totalCols - 1) * 10;
    CGFloat photosH = totalRows * HDPhotoH + (totalRows - 1) * 10;
    
    return CGSizeMake(photosW, photosH);
}
-(void)setImageURLs:(NSArray *)imageURLs{
    _imageURLs = imageURLs;
    for (int i = 0; i<HDPhotosMaxCount; i++) {
        HDFriendPhoto  *photoView = self.subviews[i];
        
        if (i < imageURLs.count) { // 显示图片
            photoView.imageName = imageURLs[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

@end
