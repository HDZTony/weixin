//
//  HDEmotionListView.m
//  微信例子
//
//  Created by 何东洲 on 16/1/22.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDEmotionListView.h"
@interface HDEmotionListView() <UIScrollViewDelegate>
/** 显示所有表情的UIScrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 显示页码的UIPageControl */
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation HDEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.显示所有表情的UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor purpleColor];
        // 滚动条是UIScrollView的子控件
        // 隐藏滚动条，可以屏蔽多余的子控件
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.显示页码的UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.backgroundColor = [UIColor yellowColor];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;

    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.UIPageControl的frame
    
    CGFloat width = self.frame.size.width;
    CGFloat height = 35;
    CGFloat y = self.frame.size.height - self.pageControl.frame.size.height;
    self.pageControl.frame = CGRectMake(0, y, width, height);
    
    // 2.UIScrollView的frame
    CGFloat scrollViewWidth = self.frame.size.width;
    CGFloat scrollViewHeight = self.pageControl.frame.origin.y;
    self.scrollView.frame = CGRectMake(0, 0, scrollViewWidth, scrollViewHeight);
    // 3.设置UIScrollView内部控件的尺寸
    int count = self.pageControl.numberOfPages;
    CGFloat gridW = self.scrollView.frame.size.width;
    CGFloat gridH = self.scrollView.frame.size.height;
    self.scrollView.contentSize = CGSizeMake(count * gridW, 0);
    for (int i = 0; i<count; i++) {
        HDEmotionGridView *gridView = self.scrollView.subviews[i];
        CGFloat width = gridW;
        CGFloat height = gridH;
        CGFloat x = i * gridW;
        gridView.frame = CGRectMake(x, 0, width, height);
    }

    
    }
-(void)setEmotions:(NSArray *)emotions{
    // 设置总页数
    int totalPages = (emotions.count + HDEmotionMaxCountPerPage - 1) / HDEmotionMaxCountPerPage;
    int currentGridViewCount = self.scrollView.subviews.count;
    self.pageControl.numberOfPages = totalPages;
    self.pageControl.currentPage = 0;
    self.pageControl.hidden = totalPages <= 1;
    // 决定scrollView显示多少页表情
    for (int i = 0; i<totalPages; i++) {
        // 获得i位置对应的HMEmotionGridView
        HDEmotionGridView *gridView = nil;
        if (i >= currentGridViewCount) { // 说明HMEmotionGridView的个数不够
            gridView = [[HDEmotionGridView alloc] init];
            //gridView.backgroundColor = HMRandomColor;
            [self.scrollView addSubview:gridView];
        } else { // 说明HMEmotionGridView的个数足够，从self.scrollView.subviews中取出HMEmotionGridView
            gridView = self.scrollView.subviews[i];
        }
        
        // 给HMEmotionGridView设置表情数据
        int loc = i * HDEmotionMaxCountPerPage;
        int len = HDEmotionMaxCountPerPage;
        if (loc + len > emotions.count) { // 对越界进行判断处理
            len = emotions.count - loc;
        }
        NSRange gridViewEmotionsRange = NSMakeRange(loc, len);
        NSArray *gridViewEmotions = [emotions subarrayWithRange:gridViewEmotionsRange];
        gridView.emotions = gridViewEmotions;
        gridView.hidden = NO;
    }
    
    // 隐藏后面的不需要用到的gridView
    for (int i = totalPages; i<currentGridViewCount; i++) {
        HDEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.hidden = YES;
    }
    
    // 重新布局子控件
    [self setNeedsLayout];
    
    // 表情滚动到最前面
    self.scrollView.contentOffset = CGPointZero;
    
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
}
@end
