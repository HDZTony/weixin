//
//  HDEmotionPopView.h
//  微信例子
//
//  Created by 何东洲 on 16/1/26.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDEmotionView.h"
@interface HDEmotionPopView : UIView

@property (weak, nonatomic) IBOutlet HDEmotionView *emotionView;

-(void)showFromEmotionView:(HDEmotionView *)fromEmotionView;
+(instancetype)popView;
@end
