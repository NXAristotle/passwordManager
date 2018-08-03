//
//  NXTools.h
//  
//
//  Created by linyibin on 15/3/5.
//  Copyright (c) 2015年 NXAristotle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <CommonCrypto/CommonDigest.h>

//屏幕的宽度
#define screenWidth  [UIScreen mainScreen].bounds.size.width

@interface NXTools : NSObject

/**
 *  用颜色创建图片
 */
+ (UIImage*)createImageWithColor: (UIColor*) color;

@end
