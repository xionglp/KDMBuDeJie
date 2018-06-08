//
//  XMGTabBar.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//  在系统的tabbar中插入一个按钮， 调整tabbar内部按钮的位置
//  先遍历UItabbar中的子控件（UItabbarbutton这是一个私有的类）在index=2上插入

#import "XMGTabBar.h"
#import "UIView+Frame.h"
@interface XMGTabBar ()

@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation XMGTabBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 调整TabBarButton位置
    NSInteger count = self.items.count;
    CGFloat btnW = self.xmg_width / (count + 1);
    CGFloat btnH = self.xmg_height;
    CGFloat x = 0;
    int i = 0;
    // 私有类:打印出来有个类,但是敲出来没有,说明这个类是系统私有类
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i += 1;
            }
            x = i * btnW;
            tabBarButton.frame = CGRectMake(x, 0, btnW, btnH);
            i++;
        }
    }
    // 调整发布按钮位置
    self.plusButton.center = CGPointMake(self.xmg_width * 0.5, self.xmg_height * 0.5);
    
}
#pragma mark - Getter方法
- (UIButton *)plusButton
{
    if (_plusButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [self addSubview:btn];
        _plusButton = btn;
    }
    return _plusButton;
}

@end
