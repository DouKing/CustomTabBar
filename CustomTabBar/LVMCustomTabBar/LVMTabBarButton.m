//
//  LVMTabBarButton.m
//  TestNavigationBar
//
//  Created by WuYikai on 15/5/29.
//  Copyright (c) 2015年 secoo. All rights reserved.
//

#import "LVMTabBarButton.h"

static CGFloat const kLVMTabBarButtonOrderNumberLabelWidth = 15;
static CGFloat const kLVMTabBarButtonOrderNumberLabelFontSize = 10;

static CGFloat const kLVMTabBarButtonHeight = 49;
static CGFloat const kLVMTabBarButtonTitleLabelHeight = 14;
static CGFloat const kLVMTabBarButtonImageViewHeight = 23;

@implementation LVMTabBarButton

- (instancetype)initWithTitle:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage {
  if (self = [super initWithFrame:CGRectMake(0, 0, kLVMTabBarButtonHeight, kLVMTabBarButtonHeight)]) {
    self.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc]
                           initWithFrame:CGRectMake(0, kLVMTabBarButtonHeight -
                                                    kLVMTabBarButtonTitleLabelHeight,
                                                    kLVMTabBarButtonHeight,
                                                    kLVMTabBarButtonTitleLabelHeight)];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    self.lvm_titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc]
                              initWithFrame:CGRectMake((kLVMTabBarButtonHeight -
                                                       kLVMTabBarButtonImageViewHeight) / 2,
                                                       (CGRectGetMinY(titleLabel.frame) -
                                                       kLVMTabBarButtonImageViewHeight) / 2,
                                                       kLVMTabBarButtonImageViewHeight,
                                                       kLVMTabBarButtonImageViewHeight)];
    imageView.image = selectedImage;
    self.lvm_imageView = imageView;
    [self addSubview:imageView];
    _lvm_defaultImageViewCenter = imageView.center;
  }
  return self;
}

- (void)setLvm_showOrderNumber:(BOOL)lvm_showOrderNumber {
  _lvm_showOrderNumber = lvm_showOrderNumber;
  if (!lvm_showOrderNumber) {
    [self.lvm_orderNumberLabel removeFromSuperview];
    _lvm_orderNumberLabel = nil;
  } else {
    if (!_lvm_orderNumberLabel) {
      UILabel *orderNumberLabel = [[UILabel alloc] init];
      orderNumberLabel.backgroundColor = [UIColor redColor];
      orderNumberLabel.textColor = [UIColor whiteColor];
      orderNumberLabel.font = [UIFont systemFontOfSize:kLVMTabBarButtonOrderNumberLabelFontSize];
      orderNumberLabel.textAlignment = NSTextAlignmentCenter;
      orderNumberLabel.adjustsFontSizeToFitWidth = YES;
      orderNumberLabel.layer.cornerRadius = kLVMTabBarButtonOrderNumberLabelWidth / 2;
      orderNumberLabel.clipsToBounds = YES;
      orderNumberLabel.alpha = 0;
      _lvm_orderNumberLabel = orderNumberLabel;
      [self.lvm_imageView addSubview:orderNumberLabel];
    }
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGFloat width = CGRectGetWidth(self.bounds);
  
  CGRect frame = self.lvm_titleLabel.frame;
  frame.size.width = width;
  self.lvm_titleLabel.frame = frame;
  
  CGPoint center = self.lvm_imageView.center;
  center.x = width * 0.5;
  self.lvm_imageView.center = center;

  _lvm_defaultImageViewCenter = CGPointMake(width * 0.5, _lvm_defaultImageViewCenter.y);
  _lvm_orderNumberLabel.frame = CGRectMake(CGRectGetWidth(self.lvm_imageView.frame) -
                                           kLVMTabBarButtonOrderNumberLabelWidth * 0.7,
                                           CGRectGetHeight(self.lvm_imageView.frame) -
                                           kLVMTabBarButtonOrderNumberLabelWidth * 0.8,
                                           kLVMTabBarButtonOrderNumberLabelWidth,
                                           kLVMTabBarButtonOrderNumberLabelWidth);
}

@end
