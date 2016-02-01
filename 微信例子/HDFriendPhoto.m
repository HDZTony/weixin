//
//  HDFriendPhoto.m
//  微信例子
//
//  Created by 何东洲 on 16/1/13.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDFriendPhoto.h"
@interface HDFriendPhoto()
@property (nonatomic, weak) UIImageView *gifView;
@end
@implementation HDFriendPhoto
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
               // 添加一个gif图标
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        // 这种情况下创建的UIImageView的尺寸跟图片尺寸一样
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}
-(void)setImageName:(NSString *)imageName{
    self.image = [UIImage imageNamed:imageName];

}
- (void)setPhoto:(HDPhoto *)photo
{
    _photo = photo;
    
    // 1.下载图片
    //[self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed: @"timeline_image_placeholder"]];
    self.image = [UIImage imageNamed:photo.thumbnail_pic];
   
    // 2.控制gif图标的显示
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat gifX = self.bounds.size.width - self.gifView.bounds.size.width;
    CGFloat gifY = self.bounds.size.height - self.gifView.bounds.size.height;
    CGRect rect = self.gifView.frame;
    rect.origin = CGPointMake(gifX, gifY);
    self.gifView.frame = rect;
}


@end
