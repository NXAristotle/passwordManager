//
//  UIBarButtonItem+NX.h
//  
//
//  Created by linyibin on 14/12/18.
//  Copyright (c) 2014年 NXAristotle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NX)

/**
 *  创建自定义item
 *
 *  @param norImageName 默认状态图片
 *  @param higImageName 高亮状态图片
 *  @param action       点击事件
 *
 *  @return item
 */
+ (instancetype)itemWithNorImage:(NSString *)norImageName higImage:(NSString *)higImageName targe:(id)targe action:(SEL)action;
/**
 *  自定义navItem
 *
 *  @param title  按钮文字
 *  @param action 点击事件
 *
 *  @return item
 */
+ (instancetype)itemWithTitle:(NSString *)title targe:(id)targe action:(SEL)action;
@end
