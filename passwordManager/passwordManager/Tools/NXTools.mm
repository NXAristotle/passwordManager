//
//  NXTools.m
//  
//
//  Created by linyibin on 15/3/5.
//  Copyright (c) 2015年 NXAristotle. All rights reserved.
//

#import "NXTools.h"


@implementation NXTools

/**
 *颜色值转换成图片
 */
+ (UIImage*)createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


@end
