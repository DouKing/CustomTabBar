//
//  LVMTabBarView.m
//  TestNavigationBar
//
//  Created by WuYikai on 15/5/29.
//  Copyright (c) 2015年 secoo. All rights reserved.
//

#import "LVMTabBarView.h"
#import <pop/POP.h>

static inline NSString * LVMTabBarViewAnimationKeyFrom(NSInteger index) {
  return [NSString stringWithFormat:@"animation.scale.%ld", (long)index];
}

@implementation LVMTabBarView
- (instancetype)initWithFrame:(CGRect)frame {
  self = [self initWithFrame:frame tabBarButtons:nil];
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame tabBarButtons:(NSArray *)tabBarButtons {
  frame.size.height = 49;
  self = [super initWithFrame:frame];
  if (self) {
    self.userInteractionEnabled = NO;
    self.lvm_tabBarButtons = tabBarButtons;
    _lvm_selectedIndex = -1;
  }
  return self;
}

- (void)setLvm_tabBarButtons:(NSArray *)lvm_tabBarButtons {
  if (lvm_tabBarButtons != _lvm_tabBarButtons) {
    _lvm_tabBarButtons = lvm_tabBarButtons;
    [self _lvm_removeSubViews];
    CGSize size = [self _lvm_buttonWidthWithButtonNumber:_lvm_tabBarButtons.count];
    for (NSInteger index = 0; index < _lvm_tabBarButtons.count; ++index) {
      LVMTabBarButton *btn = _lvm_tabBarButtons[index];
      btn.tag = index;
      CGRect frame = CGRectMake(index * size.width, 0, size.width, size.height);
      btn.frame = frame;
      [self addSubview:btn];
    }
  }
}

- (void)setLvm_selectedIndex:(NSInteger)lvm_selectedIndex {
  if (_lvm_selectedIndex == lvm_selectedIndex) {
    return;
  }
  LVMTabBarButton *preBtn = (LVMTabBarButton *)[self viewWithTag:_lvm_selectedIndex];
  LVMTabBarButton *selectedBtn = (LVMTabBarButton *)[self viewWithTag:lvm_selectedIndex];
  _lvm_selectedIndex = lvm_selectedIndex;
  
  [self _lvm_selectTabBarButton:selectedBtn];
  [self _lvm_cancelSelectedTabBarButton:preBtn];
}

#pragma mark - Pravite Methods
- (void)_lvm_removeSubViews {
  for (UIView *subView in self.subviews) {
    [subView removeFromSuperview];
  }
}

- (CGSize)_lvm_buttonWidthWithButtonNumber:(NSInteger)num {
  CGFloat height = CGRectGetHeight(self.bounds);
  CGFloat width = CGRectGetWidth(self.bounds) / num;
  return CGSizeMake(width, height);
}

- (void)_lvm_selectTabBarButton:(LVMTabBarButton *)btn {
  btn.lvm_isScaled = YES;
  __weak typeof(self) weakSelf = self;
  CGPoint center = btn.lvm_imageView.center;
  center.y = 0.5 * CGRectGetHeight(btn.bounds);
  [UIView animateWithDuration:0.3f animations:^{
    btn.lvm_imageView.center = center;
    btn.lvm_titleLabel.alpha = 0;
  } completion:^(BOOL finished) {
    __strong typeof(weakSelf) strongSelf = weakSelf;
    [strongSelf _lvm_tabBarButton:btn scale:CGPointMake(1.4, 1.4) completion:YES];
  }];
}

- (void)_lvm_cancelSelectedTabBarButton:(LVMTabBarButton *)btn {
  btn.lvm_isScaled = NO;
  [self _lvm_tabBarButton:btn scale:CGPointMake(1, 1) completion:YES];
  [UIView animateWithDuration:0.3 animations:^{
    btn.lvm_imageView.center = btn.lvm_defaultImageViewCenter;
    btn.lvm_titleLabel.alpha = 1;
  }];
}

- (POPAnimation *)_lvm_tabBarButton:(LVMTabBarButton *)tabBarButton scale:(CGPoint)scale completion:(BOOL)completion {
  BOOL isScale = (scale.x == 1) ? NO : YES;
  
  POPSpringAnimation *scaleAnimation = [tabBarButton pop_animationForKey:LVMTabBarViewAnimationKeyFrom(tabBarButton.tag)];
  if (!scaleAnimation) {
    scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
  }
  
  scaleAnimation.toValue = [NSValue valueWithCGPoint:scale];
  //设置弹性 振幅 范围 0~20
  scaleAnimation.springBounciness = (isScale) ? 10 : 0;
  //设置振动速度
  scaleAnimation.springSpeed = 1;
  
  if (completion) {
    __weak typeof(self) weakSelf = self;
    [scaleAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
      __strong typeof(weakSelf) strongSelf = weakSelf;
      if (tabBarButton.lvm_isScaled) {
        [strongSelf _lvm_tabBarButton:tabBarButton scale:CGPointMake(1.4, 1.4) completion:NO];
      } else {
        [strongSelf _lvm_tabBarButton:tabBarButton scale:CGPointMake(1, 1) completion:NO];
      }
    }];
  }
  
  [tabBarButton pop_addAnimation:scaleAnimation
                          forKey:LVMTabBarViewAnimationKeyFrom(tabBarButton.tag)];
  return scaleAnimation;
}
@end
