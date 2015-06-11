//
//  AppDelegate.m
//  CustomTabBar
//
//  Created by WuYikai on 15/6/11.
//  Copyright (c) 2015年 secoo. All rights reserved.
//

#import "AppDelegate.h"
#import "LVMTabBarView.h"

@interface AppDelegate ()<UITabBarControllerDelegate>
@property (nonatomic, weak) UITabBarController *tabBarController;
@property (nonatomic, weak) LVMTabBarView *customTabBar;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
  tabBarController.delegate = self;
  self.tabBarController = tabBarController;
  [self _setupCustomTabBar];
  self.customTabBar.lvm_selectedIndex = 0;
  return YES;
}

- (void)_setupCustomTabBar {
  LVMTabBarButton *btn1 = [[LVMTabBarButton alloc] initWithTitle:@"首页"
                                                     normalImage:[UIImage imageNamed:@"index2"]
                                                   selectedImage:[UIImage imageNamed:@"index1"]];
  LVMTabBarButton *btn2 = [[LVMTabBarButton alloc] initWithTitle:@"品牌"
                                                     normalImage:[UIImage imageNamed:@"brand2"]
                                                   selectedImage:[UIImage imageNamed:@"brand1"]];
  LVMTabBarButton *btn3 = [[LVMTabBarButton alloc] initWithTitle:@"分类"
                                                     normalImage:[UIImage imageNamed:@"list2"]
                                                   selectedImage:[UIImage imageNamed:@"list1"]];
  LVMTabBarButton *btn4 = [[LVMTabBarButton alloc] initWithTitle:@"购物袋"
                                                     normalImage:[UIImage imageNamed:@"shop2"]
                                                   selectedImage:[UIImage imageNamed:@"shop1"]];
  LVMTabBarButton *btn5 = [[LVMTabBarButton alloc] initWithTitle:@"我的寺库"
                                                     normalImage:[UIImage imageNamed:@"user2"]
                                                   selectedImage:[UIImage imageNamed:@"user1"]];
  
  LVMTabBarView *tabBarView = [[LVMTabBarView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.window.bounds), CGRectGetHeight(self.tabBarController.tabBar.bounds))];
  tabBarView.backgroundColor = [UIColor blackColor];
  tabBarView.tag = kCustomTabBarTag;
  tabBarView.lvm_tabBarButtons = @[btn1, btn2, btn3, btn4, btn5];
  self.customTabBar = tabBarView;
  [self.tabBarController.tabBar addSubview:tabBarView];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
  NSArray *viewControllers = tabBarController.viewControllers;
  for (NSInteger i = 0; i < viewControllers.count; ++i) {
    UIViewController *vc = viewControllers[i];
    if (vc == viewController) {
      [self.customTabBar setLvm_selectedIndex:i];
      break;
    }
  }
  return YES;
}

@end
