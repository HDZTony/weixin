//
//  HDTextView.m
//  微信例子
//
//  Created by 何东洲 on 16/1/20.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDTextView.h"
@interface HDTextView()<UITextViewDelegate>
@property (nonatomic, weak) UILabel *placehoderLabel;
@end
@implementation HDTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加一个显示提醒文字的label（显示占位文字的label）
        UILabel *placehoderLabel = [[UILabel alloc] init];
        placehoderLabel.numberOfLines = 0;
        placehoderLabel.textColor = [UIColor lightGrayColor];

        [self addSubview:placehoderLabel];
        self.placehoderLabel = placehoderLabel;
        
        // 设置默认的占位文字颜色
        self.placehoderColor = [UIColor lightGrayColor];
        
        // 设置默认的字体
        self.font = [UIFont systemFontOfSize:14];
        // 监听内部文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
#pragma 监听内部文字改变
-(void)textDidChange{
    // text属性：只包括普通的文本字符串
    // attributedText：包括了显示在textView里面的所有内容（表情、text）
    self.placehoderLabel.hidden = self.hasText;
}
-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self textDidChange];
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placehoderLabel.font = font;
    [self setNeedsLayout];
}
- (void)setPlacehoder:(NSString *)placehoder
{
#warning 如果是copy策略，setter最好这么写
        _placehoder = [placehoder copy];
        
        // 设置文字
        self.placehoderLabel.text = placehoder;
        
        // 重新计算子控件的fame
        [self setNeedsLayout];
    
}
-(void)layoutSubviews{
    CGFloat placehoderX = 5;
    CGFloat placehoderY = 8;
    CGFloat placehoderWidth = self.bounds.size.width;
    CGSize placehoderMaxSize = CGSizeMake(placehoderWidth,MAXFLOAT);
    NSDictionary *textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGSize textSize = [self.placehoder boundingRectWithSize:placehoderMaxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil].size;
    CGFloat placehoderHeight = textSize.height;
    self.placehoderLabel.frame = CGRectMake(placehoderX, placehoderY, placehoderWidth, placehoderHeight);

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
