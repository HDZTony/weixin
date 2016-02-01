//
//  HDComposePhotosView.m
//  微信例子
//
//  Created by 何东洲 on 16/1/22.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDComposePhotosView.h"

@implementation HDComposePhotosView

-(void)addImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
}
-(void)layoutSubviews{
    int count = self.subviews.count;
    // 一行的最大列数
    int maxColsPerRow = 4;
    
    // 每个图片之间的间距
    CGFloat margin = 10;
    // 每个图片的宽高
    CGFloat imageViewW = (self.frame.size.width - (maxColsPerRow + 1) * margin) / maxColsPerRow;
    CGFloat imageViewH = imageViewW;
    
    for (int i = 0; i<count; i++) {
        // 行号
        int row = i / maxColsPerRow;
        // 列号
        int col = i % maxColsPerRow;
        
        UIImageView *imageView = self.subviews[i];
        CGFloat width = imageViewW;
        CGFloat height = imageViewH;
        CGFloat y = row * (imageViewH + margin);
        CGFloat x = col * (imageViewW + margin) + margin;
        imageView.frame = CGRectMake(x, y, width, height);
    }

}
@end
