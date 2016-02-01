//
//  FXTableViewCell.m
//  微信例子
//
//  Created by 何东洲 on 16/1/29.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "FXTableViewCell.h"
#import "HDSettingArrowMode.h"
#import "HDSettingLabelMode.h"
#import "HDSettingSwitchMode.h"
#import "HDBadgeView.h"
@interface FXTableViewCell()
/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *rightArrow;
/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *rightSwitch;
/**
 *  标签
 */
@property (strong, nonatomic) UILabel *rightLabel;
/**
 *  提醒数字
 */
@property (strong, nonatomic) HDBadgeView *bageView;
@end
@implementation FXTableViewCell
#pragma mark - 懒加载右边的view
- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch
{
    if (_rightSwitch == nil) {
        self.rightSwitch = [[UISwitch alloc] init];
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.textColor = [UIColor lightGrayColor];
        self.rightLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLabel;
}

- (HDBadgeView *)bageView
{
    if (_bageView == nil) {
        self.bageView = [[HDBadgeView alloc] init];
    }
    return _bageView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:reuseIdentifier];
    if (self) { // 初始化子控件
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        // 去除cell的默认背景色
        //self.backgroundColor = [UIColor clearColor];
        
        // 设置背景view
        //self.backgroundView = [[UIImageView alloc] init];
        //self.selectedBackgroundView = [[UIImageView alloc] init];
    }
    return self;

}
-(void)setItem:(HDSettingMode *)item{
    _item = item;
    
    // 1.设置基本数据
    self.imageView.image = [UIImage imageNamed:item.iconName];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.detailText;
    // 2.设置右边的内容
    if (item.badgeValue) { // 紧急情况：右边有提醒数字
        self.bageView.badgeValue = item.badgeValue;
        self.accessoryView = self.bageView;
    } else if ([item isKindOfClass:[HDSettingArrowMode class]]) {
        self.accessoryView = self.rightArrow;
    } else if ([item isKindOfClass:[HDSettingSwitchMode class]]) {
        self.accessoryView = self.rightSwitch;
    } else if ([item isKindOfClass:[HDSettingLabelMode class]]) {
        HDSettingLabelMode *labelItem = (HDSettingLabelMode *)item;
        // 设置文字
        self.rightLabel.text = labelItem.text;
        // 根据文字计算尺寸
        NSDictionary *attribute = @{NSFontAttributeName:self.rightLabel.font};
        CGRect frame = self.rightLabel.frame;
        frame.size = [labelItem.text sizeWithAttributes:attribute];
        self.rightLabel.frame = frame;
        self.accessoryView = self.rightLabel;
    } else { // 取消右边的内容
        self.accessoryView = nil;
    }

    
}
/**
 *  设置背景图片
 *
 *  @param indexPath <#indexPath description#>
 *  @param rows      <#rows description#>
 */
-(void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows{
//    // 1.取出背景view
//    UIImageView *bgView = (UIImageView *)self.backgroundView;
//    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
//    
//    // 2.设置背景图片
//    if (rows == 1) {
//        bgView.image = [UIImage imageNamed:@"common_card_background"];
//        selectedBgView.image = [UIImage imageNamed:@"common_card_background_highlighted"];
//    } else if (indexPath.row == 0) { // 首行
//        bgView.image = [UIImage imageNamed:@"common_card_top_background"];
//        selectedBgView.image = [UIImage imageNamed:@"common_card_top_background_highlighted"];
//    } else if (indexPath.row == rows - 1) { // 末行
//        bgView.image = [UIImage imageNamed:@"common_card_bottom_background"];
//        selectedBgView.image = [UIImage imageNamed:@"common_card_bottom_background_highlighted"];
//    } else { // 中间
//        bgView.image = [UIImage imageNamed:@"common_card_middle_background"];
//        selectedBgView.image = [UIImage imageNamed:@"common_card_middle_background_highlighted"];
//    }

}
#pragma mark - 调整子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整子标题的x
    CGFloat x = CGRectGetMaxX(self.textLabel.frame) + 5;
    CGRect frame = self.textLabel.frame;
    frame.origin.x = x;
    self.textLabel.frame = frame;
}

@end
