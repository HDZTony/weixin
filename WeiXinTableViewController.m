//
//  WeiXinTableViewController.m
//  微信例子
//
//  Created by 何东洲 on 15/11/19.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import "WeiXinTableViewController.h"
#import "WXTableViewCell.h"
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]
@interface WeiXinTableViewController ()
//cell的数据
@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) NSMutableArray *falseData;
///** 下拉刷新控件 */
//@property (strong, nonatomic) MJRefreshHeader *header;
///** 上拉刷新控件 */
//@property (strong, nonatomic) MJRefreshFooter *footer;

@end

@implementation WeiXinTableViewController 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[WXTableViewCell class] forCellReuseIdentifier:@"identifer"];
    //集成刷新控件
    [self setUpRefresh];
    
    
    
}
/**
 *  集成刷新控件
 */
-(void)setUpRefresh{
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    //[self.tableView.mj_header beginRefreshing];
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];

}
/**
 *  懒加载
 *
 *  @return <#return value description#>
 */
-(NSMutableArray *)data{
    if (_data==nil) {
        // 1.获得全路径
        NSString *fullPath =  [[NSBundle mainBundle] pathForResource:@"heros3" ofType:@"plist"];
        // 2.更具全路径加载数据
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        // 3.字典转模型
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictArray.count];
        for (NSDictionary *dict in dictArray) {
            WeiChatMode *mode = [WeiChatMode WeiChatWithDict:dict];
            [models addObject:mode];
        }
        // 4.赋值数据
        _data = models;
        
    }
    // 4.返回数据
    return _data;
   
}

/**
 *  根据微信模型数组 转成 微信frame模型数据
 *
 *  @param modeArray 微信模型数组
 *
 *  @return frame模型数据
 */
- (NSArray *)framesModeWithWeiChatMode:(NSArray *)modeArray
{
    NSMutableArray *frames = [NSMutableArray array];
    for (WeiChatMode *mode in modeArray) {
        WXFrameMode *frame = [[WXFrameMode alloc] init];
        // 传递微博模型数据，计算所有子控件的frame
        frame.mode = mode;
        [frames addObject:frame];
    }
    return frames;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
    //return self.falseData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifer";
    //WXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    WXTableViewCell *cell = [[WXTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    
    cell.tag = indexPath.row;
    NSArray *framesArray = [self framesModeWithWeiChatMode:self.data];
    cell.frameMode = framesArray[indexPath.row];

  return cell;
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    // 1.获得全路径
    NSString *fullPath =  [[NSBundle mainBundle] pathForResource:@"heros2" ofType:@"plist"];
    // 2.更具全路径加载数据
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
    // 3.字典转模型
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictArray.count];
    for (NSDictionary *dict in dictArray) {
        WeiChatMode *mode = [WeiChatMode WeiChatWithDict:dict];
        [models addObject:mode];
    }
    // 4.赋值数据
     self.data = [models copy];

    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    NSString *fullPath =  [[NSBundle mainBundle] pathForResource:@"heros4" ofType:@"plist"];
    // 2.更具全路径加载数据
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
    // 3.字典转模型
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictArray.count];
    for (NSDictionary *dict in dictArray) {
        WeiChatMode *mode = [WeiChatMode WeiChatWithDict:dict];
        [models addObject:mode];
        
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:models.count];
    array = models;

    [_data addObjectsFromArray:array];


    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.tableView.mj_footer endRefreshing];
    });
}






@end
