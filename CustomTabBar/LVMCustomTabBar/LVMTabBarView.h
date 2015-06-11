//
//  LVMTabBarView.h
//  TestNavigationBar
//
//  Created by WuYikai on 15/5/29.
//  Copyright (c) 2015年 secoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVMTabBarButton.h"
/// 自定义的tabBar的tag值， 父视图为tabBarController.tabBar
static NSInteger const kCustomTabBarTag = 10000;

@interface LVMTabBarView : UIView
@property (nonatomic, strong) NSArray *lvm_tabBarButtons;
@property (nonatomic, assign) NSInteger lvm_selectedIndex;
- (instancetype)initWithFrame:(CGRect)frame tabBarButtons:(NSArray *)tabBarButtons;
@end
