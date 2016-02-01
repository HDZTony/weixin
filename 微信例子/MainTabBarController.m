//
//  MainTabBarController.m
//  微信例子
//
//  Created by 何东洲 on 15/11/23.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import "MainTabBarController.h"
#import "WeiXinTableViewController.h"
#import "TXTableViewController.h"
#import "FXTableViewController.h"
#import "HDComposeViewController.h"
#import "TXPickerViewController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//  添加子控制器
    [self addAllChildViewController];
   
    
    
}
/**
 *  添加一个控制器作为TabBar控制器的子控制器
 *
 *  @param viewController <#viewController description#>
 *  @param title          <#title description#>
 *  @param imageName      <#imageName description#>
 */
-(void)addOneChildViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)imageName {
    UINavigationController *oneNav = [[UINavigationController alloc]initWithRootViewController:viewController];
    oneNav.title = title;
    oneNav.tabBarItem.image = [UIImage imageNamed:imageName];
    oneNav.tabBarItem.title = title;
    viewController.navigationItem.title = title;
    
    [self addChildViewController:oneNav];
}
/**
 *  添加TabBar控制器的所有子控制器
 */
-(void)addAllChildViewController{
    WeiXinTableViewController *wxTabViewController = [[WeiXinTableViewController alloc]init];
    [self addOneChildViewController:wxTabViewController title:@"微信" image:@"pluginboard_icon_favor"];
    TXTableViewController *txTabViewController = [[TXTableViewController alloc]init];
    [self addOneChildViewController:txTabViewController title:@"通讯录" image:@"pluginboard_icon_favor"];
    FXTableViewController *fxTabViewController = [[FXTableViewController alloc]init];
    [self addOneChildViewController:fxTabViewController title:@"发现" image:@"pluginboard_icon_favor"];
    HDComposeViewController *composeViewController = [[HDComposeViewController alloc]init];
    [self addOneChildViewController:composeViewController title:@"我" image:@"pluginboard_icon_favor"];
}


@end
