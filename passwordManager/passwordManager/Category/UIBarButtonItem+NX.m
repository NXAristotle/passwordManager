//
//  UIBarButtonItem+NX.m
//  
//
//  Created by linyibin on 14/12/18.
//  Copyright (c) 2014年 NXAristotle. All rights reserved.
//

#import "UIBarButtonItem+NX.h"


static int const width = 80;
static int const height = 40;

@implementation UIBarButtonItem (NX)



+ (instancetype)itemWithNorImage:(NSString *)norImageName higImage:(NSString *)higImageName targe:(id)targe action:(SEL)action
{
   
    UIButton *btn = [[UIButton alloc] init];
    //  设置默认状态图片
    [btn setBackgroundImage:[UIImage imageNamed:norImageName] forState:UIControlStateNormal];
    
    //  设置高亮状态图片
    [btn setBackgroundImage:[UIImage imageNamed:higImageName] forState:UIControlStateHighlighted];
    
    //  设置frame
    btn.size = btn.currentBackgroundImage.size;
//    CGSize btnSize = CGSizeMake(screenWidth * 0.2, 44);
//    btn.size = btnSize;
    
    
    //  添加监听事件
    [btn addTarget:targe action:action forControlEvents:UIControlEventTouchUpInside];
    
    //  返回item
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

+ (instancetype)itemWithTitle:(NSString *)title targe:(id)targe action:(SEL)action{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    //  设置frame
    btn.size = CGSizeMake(width, height);
    //  添加监听事件
    [btn addTarget:targe action:action forControlEvents:UIControlEventTouchUpInside];
    
    //  返回item
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
