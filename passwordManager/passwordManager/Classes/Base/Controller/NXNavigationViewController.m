//
//  NXNavigationViewController.m
//  
//
//  Created by linyibin on 14/12/18.
//  Copyright (c) 2014年 NXAristotle. All rights reserved.
//

#import "NXNavigationViewController.h"
#import "UIColor+HexColor.h"
#import "UIBarButtonItem+NX.h"




@interface NXNavigationViewController ()

@end

@implementation NXNavigationViewController

+ (void)initialize
{
    //  设置导航条的主题
    [self setupNavTheme];
    
    //  设置导航条按钮的主题
    [self setupItemTheme];
}

/**
 *  设置导航条按钮的主题
 */
+ (void)setupItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //  设置文字颜色
    //  设置默认状态的文字颜色
    NSMutableDictionary *norMd = [NSMutableDictionary dictionary];
    norMd[NSForegroundColorAttributeName] = [UIColor colorFromHexRGB:@"ffffff"];
    
    //  去除阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    norMd[NSShadowAttributeName] = shadow;
    norMd[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:norMd forState:UIControlStateNormal];
    
    //  设置高亮状态的文字颜色
    NSMutableDictionary *higMd = [NSMutableDictionary dictionaryWithDictionary:norMd];
    higMd[NSForegroundColorAttributeName] = [UIColor redColor];
    [item setTitleTextAttributes:higMd forState:UIControlStateHighlighted];

    NSMutableDictionary *enableMd = [NSMutableDictionary dictionaryWithDictionary:higMd];
    enableMd[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:enableMd forState:UIControlStateDisabled];
    //  设置返回按钮图片
    [item setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //  设置按钮（全局）的渲染颜色
    item.tintColor = [UIColor colorFromHexRGB:@"999999"];
}

/**
 *  设置导航条的主题
 */
+ (void)setupNavTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //  设置文字样式
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    //  设置导航栏的背景颜色
    [navBar setBackgroundImage:[NXTools createImageWithColor:[UIColor colorFromHexRGB:@"3AA9E4"]] forBarMetrics:UIBarMetricsDefault];
    
    //  设置title字体颜色
    md[NSForegroundColorAttributeName] = [UIColor colorFromHexRGB:@"ffffff"];
    
    [navBar setTitleTextAttributes:md];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //  清空手势代理
//    self.interactivePopGestureRecognizer.delegate = nil;
//    self.interactivePopGestureRecognizer.enabled = NO;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{    
    // 设置目标控制器隐藏选项卡
    if (self.childViewControllers.count > 0) {
        //  不是栈底控制器, 也就是子控制器
        viewController.hidesBottomBarWhenPushed = YES;
        
        //  设置左上角的按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImage:@"back" higImage:@"back" targe:self action:@selector(back)];
    }
    
    for (UIViewController *vc in self.viewControllers) {
        [vc.view endEditing:YES];
    }
    [super pushViewController:viewController animated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
