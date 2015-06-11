//
//  LVMTabBarButton.h
//  TestNavigationBar
//
//  Created by WuYikai on 15/5/29.
//  Copyright (c) 2015年 secoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LVMTabBarButton : UIView
@property (nonatomic, weak) UIImageView *lvm_imageView;
@property (nonatomic, weak) UILabel *lvm_titleLabel;

@property (nonatomic, assign) BOOL lvm_isScaled;
@property (nonatomic, assign, readonly) CGPoint lvm_defaultImageViewCenter;
@property (nonatomic, weak, readonly) UILabel *lvm_orderNumberLabel;
@property (nonatomic, assign) BOOL lvm_showOrderNumber;
- (instancetype)initWithTitle:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;
@end
