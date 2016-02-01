//
//  FXTableViewController.m
//  微信例子
//
//  Created by 何东洲 on 15/11/30.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import "FXTableViewController.h"
#import "HDSettingMode.h"
#import "HDSettingSwitchMode.h"
#import "HDSettingArrowMode.h"
#import "HDSettingLabelMode.h"
#import "HDGroupMode.h"
#import "FriendTableViewController.h"
#import "FXTableViewCell.h"
@interface FXTableViewController ()
@property (strong, nonatomic) NSMutableArray *groups;/**< 组数组 描述TableView有多少组 */

@end
/** groups 数据懒加载*/
@implementation FXTableViewController
-(NSMutableArray *)groups{
    if (_groups==nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}
-(instancetype)init{
    // 设置tableView的分组样式为Group样式
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionFooterHeight = 50;
    self.tableView.sectionHeaderHeight = 0;
    //增加四组数据
    [self addGroup1];
    [self addGroup2];
    [self addGroup3];
    [self addGroup4];
    [self setupFooter];
    //[self.tableView registerClass:[FXTableViewCell class] forCellReuseIdentifier:@"setting"];
 
   
}
-(void)addGroup1{
    HDGroupMode *groupMode = [[HDGroupMode alloc]init];
    HDSettingSwitchMode *settingMode = [HDSettingSwitchMode initWithTitle:@"朋友圈" iconName:@"173890255948"];
    settingMode.badgeValue = @"12";
    settingMode.destVcClass = [FriendTableViewController class];
    groupMode.items = @[settingMode];
    [self.groups addObject:groupMode];
}
-(void)addGroup2{
    HDGroupMode *groupMode2 = [[HDGroupMode alloc]init];
    groupMode2.headerTitle = @"toubu";
    groupMode2.footerTitle = @"weibu";
    HDSettingSwitchMode *settingMode2 = [HDSettingSwitchMode initWithTitle:@"扫一扫" iconName:@"173890255948"];
    settingMode2.badgeValue =@"5";
    settingMode2.detailText = @"陌生人";
    settingMode2.operation = ^{
        NSLog(@"扫一扫");
    };
    HDSettingLabelMode *settingMode3 = [HDSettingLabelMode initWithTitle:@"摇一摇" iconName:@"173890255948"];
    //settingMode3.text = @"ceshi";
    settingMode3.detailText = @"陌生人";
    settingMode3.badgeValue =@"5";
    groupMode2.items = @[settingMode2,settingMode3];
    [self.groups addObject:groupMode2];
}
-(void)addGroup3{
    HDGroupMode *groupMode3 = [[HDGroupMode alloc]init];
    HDSettingMode *settingMode4 = [HDSettingMode initWithTitle:@"附近的人" iconName:@"173890255948"];
    HDSettingMode *settingMode5 = [HDSettingMode initWithTitle:@"漂流瓶" iconName:@"173890255948"];
    groupMode3.items = @[settingMode4,settingMode5];
    [self.groups addObject:groupMode3];
}
-(void)addGroup4{
    HDGroupMode *groupMode4 = [[HDGroupMode alloc]init];
    HDSettingMode *settingMode6 = [HDSettingMode initWithTitle:@"购物" iconName:@"173890255948"];
    HDSettingArrowMode *settingMode7 = [HDSettingArrowMode initWithTitle:@"游戏" iconName:@"173890255948"];
    groupMode4.items = @[settingMode6,settingMode7];
    [self.groups addObject:groupMode4];
}
- (void)setupFooter
{
    // 1.创建按钮
    UIButton *logout = [[UIButton alloc] init];
    
    // 2.设置属性
    logout.titleLabel.font = [UIFont systemFontOfSize:14];
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setTitleColor:HDColor(255, 10, 10) forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage imageNamed:@"common_card_background"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage imageNamed:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置尺寸(tableFooterView和tableHeaderView的宽度跟tableView的宽度一样)
    CGRect frame = self.tableView.tableFooterView.frame;
    frame.size.height = 35;
    self.tableView.tableFooterView.frame = frame;
    
    self.tableView.tableFooterView = logout;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    HDGroupMode *group = self.groups[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifer = @"setting";
    FXTableViewCell *cell = [[FXTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
   // FXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    HDGroupMode *groupMode = self.groups[indexPath.section];
    HDSettingMode *settingMode = groupMode.items[indexPath.row];
    cell.item = settingMode;
    // 设置cell所处的行号 和 所处组的总行数
    //[cell setIndexPath:indexPath rowsInSection:groupMode.items.count];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        FriendTableViewController *friendViewController = [[FriendTableViewController alloc]initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:friendViewController animated:YES];
    }
    // 1.取出这行对应的item模型
    HDGroupMode *group = self.groups[indexPath.section];
    HDSettingMode *item = group.items[indexPath.row];
    
    // 2.判断有无需要跳转的控制器
    if (item.destVcClass) {
        UIViewController *destVc = [[item.destVcClass alloc] init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    // 3.判断有无想执行的操作
    if (item.operation) {
        item.operation();
    }

}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
     HDGroupMode *group = self.groups[section];
     return group.footerTitle;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    HDGroupMode *group = self.groups[section];
    return group.headerTitle;
}
@end
