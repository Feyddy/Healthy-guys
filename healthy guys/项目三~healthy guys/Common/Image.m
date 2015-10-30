//
//  Image.m
//  HomeWork1
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "Image.h"

@implementation Image

+ (UIImage *) watermarkImage:(UIImage *) image text:(NSString *)text {
    
    //建立位图上下文，并把它设置为当前使用的contex
    UIGraphicsBeginImageContext(image.size);
    
    //绘制内容
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    CGRect frame = CGRectMake(0, image.size.height - 80,  image.size.width, 80);
    
    //绘制水印内容
    UIColor *color = [UIColor whiteColor];
    
    UIFont *font = [UIFont systemFontOfSize:29];
    
    //段落样式
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentLeft;
    
    [text drawInRect:frame
      withAttributes:@{
                       NSFontAttributeName : font,
                       NSForegroundColorAttributeName : color,
                       NSParagraphStyleAttributeName : style
                       }];
    
    //获取图片，从当前上下文中获取绘制的图形(获取添加了水印之后的图片)
    UIImage *watermarkImage = UIGraphicsGetImageFromCurrentImageContext();
    
    ////关闭图形上下文，在建立和关闭位图上下文之前添加的显示内容都是加在位图上下文上的。
    UIGraphicsEndImageContext();
    
    return watermarkImage;
}

@end
