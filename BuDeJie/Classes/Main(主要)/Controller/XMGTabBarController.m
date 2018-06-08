//
//  XMGTabBarController.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTabBarController.h"
#import "XMGEssenceViewController.h"
#import "XMGFriendTrendViewController.h"
#import "XMGMeViewController.h"
#import "XMGNewViewController.h"
#import "XMGPublishViewController.h"
#import "UIImage+Image.h"
#import "XMGTabBar.h"
#import "XMGNavigationViewController.h"

@interface XMGTabBarController ()

@end

@implementation XMGTabBarController

// 只会调用一次
+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1 添加子控制器(5个子控制器) -> 自定义控制器 -> 划分项目文件结构
    [self setupAllChildViewController];
    
    XMGTabBar *tabBar = [[XMGTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}

#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController
{
    XMGEssenceViewController *essenceVc = [[XMGEssenceViewController alloc] init];
    [self createTabbarChildController:essenceVc title:@"精华" normalImage:@"tabBar_essence_icon" selImage:@"tabBar_essence_click_icon"];
    
    XMGNewViewController *newVc = [[XMGNewViewController alloc] init];
    [self createTabbarChildController:newVc title:@"新帖" normalImage:@"tabBar_new_icon" selImage:@"tabBar_new_click_icon"];
    
    XMGFriendTrendViewController *ftVc = [[XMGFriendTrendViewController alloc] init];
    [self createTabbarChildController:ftVc title:@"关注" normalImage:@"tabBar_friendTrends_icon" selImage:@"tabBar_friendTrends_click_icon"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([XMGMeViewController class]) bundle:nil];
    XMGMeViewController *meVc = [storyboard instantiateInitialViewController];
    [self createTabbarChildController:meVc title:@"我的" normalImage:@"tabBar_me_icon" selImage:@"tabBar_me_click_icon"];
}

//给tabbarController添加控制器
- (void)createTabbarChildController:(UIViewController *)targetVc title:(NSString *)title normalImage:(NSString *)normalImage selImage:(NSString *)selImage{
    targetVc.tabBarItem.title = title;
    targetVc.tabBarItem.image = [UIImage imageNamed:normalImage];
    targetVc.tabBarItem.selectedImage = [UIImage imageOriginalWithName:selImage];;
    XMGNavigationViewController *nav = [[XMGNavigationViewController alloc] initWithRootViewController:targetVc];
    [self addChildViewController:nav];
}

@end
