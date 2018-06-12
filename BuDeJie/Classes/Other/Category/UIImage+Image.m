//
//  UIImage+Image.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (UIImage *)imageOriginalWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

//UI层业务
//基础
//网络
//底层
//不常用到的库， 例音频视频、动画、图表等
//html，css，h5
//前端框架，ReactNative,Vue,Angular

@end
