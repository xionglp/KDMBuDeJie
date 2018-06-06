//
//  UIImage+Antialias.m
//  BuDeJie
//
//  Created by yz on 15/10/31.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "UIImage+Antialias.h"

@implementation UIImage (Antialias)
// 在周边加一个边框为1的透明像素
- (UIImage *)imageAntialias
{
    CGFloat border = 1.0f;
    CGRect rect = CGRectMake(border, border, self.size.width-2*border, self.size.height-2*border);
    
    UIImage *img = nil;
    
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width,rect.size.height));
    [self drawInRect:CGRectMake(-1, -1, self.size.width, self.size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.size);
    [img drawInRect:rect];
    UIImage* antiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return antiImage;
}

//生成圆角图片
+ (UIImage *)graphicsCornerImages:(UIImage*)targetImage
{
    // 1.开启图形上下文
    // 比例因素:当前点与像素比例
    UIGraphicsBeginImageContextWithOptions(targetImage.size, NO, 0);
    // 2.描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, targetImage.size.width, targetImage.size.height)];
    // 3.设置裁剪区域;
    [path addClip];
    // 4.画图片
    [targetImage drawAtPoint:CGPointZero];
    // 5.取出图片
    targetImage = UIGraphicsGetImageFromCurrentImageContext();
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return targetImage;
}

@end
