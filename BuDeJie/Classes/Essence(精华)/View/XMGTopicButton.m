//
//  XMGTopicButton.m
//  BuDeJie
//
//  Created by xlp on 2018/6/11.
//  Copyright © 2018年 小码哥. All rights reserved.
//

#import "XMGTopicButton.h"

@implementation XMGTopicButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

//重新setHighlighted方法， 去掉按钮的选中样式
- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
