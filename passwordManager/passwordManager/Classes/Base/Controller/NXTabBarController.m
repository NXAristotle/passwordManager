//
//  NXTabBarController.m
//  疾病助手
//
//  Created by linyibin on 14/12/18.
//  Copyright (c) 2014年 NXAristotle. All rights reserved.
//

#import "NXTabBarController.h"
#import "NXPersonalCenterViewController.h"
#import "NXHomeViewController.h"
#import "NXTabBar.h"


@interface NXTabBarController ()<NXTabBarDelegate>


@property (nonatomic, strong)NXHomeViewController *home;

@property (nonatomic, strong)NXPersonalCenterViewController *personal;
@end

@implementation NXTabBarController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //  1. 主页
        NXHomeViewController *home = [[NXHomeViewController alloc] init];
        home.view.backgroundColor = [UIColor whiteColor];
        [self addOneChildController:home title:@"首页" norImage:@"tabbar_home" selectedImage:@"tabbar_homeHL"];
        self.home = home;
        

        //  4. 个人中心
        NXPersonalCenterViewController *personal = [[NXPersonalCenterViewController alloc] init];
        self.personal = personal;
        [self addOneChildController:personal title: @"个人中心" norImage:@"tabbar_personal" selectedImage:@"tabbar_personalHL"];

        
    }
    return self;
}

/**
 *  初始化子控制器
 *
 *  @param childVc       需要初始化的子控制器
 *  @param title         控制器的标题
 *  @param norImage      控制器的默认状态的图片
 *  @param selectedImage 控制器的选中状态的图片
 */
- (void)addOneChildController:(UIViewController *)childVc title:(NSString *)title norImage:(NSString *)norImage selectedImage:(NSString *)selectedImage
{
    
//    childVc.view.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    childVc.tabBarItem.title = title;
    
    childVc.tabBarItem.image = [UIImage imageNamed:norImage];
    UIImage *selImage = [UIImage imageNamed:selectedImage];
    
    //  告诉系统不要按照tintColor渲染图片
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 
    childVc.tabBarItem.selectedImage = selImage;
    //  包装一个导航条
    NXNavigationViewController  *nav = [[NXNavigationViewController alloc] initWithRootViewController:childVc];

    
    [self addChildViewController:nav];
    
    //  添加一个自定义选项卡按钮
    [self.customTabBar addTabBarButton:childVc.tabBarItem];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    

    //  1. 创建自定义tabBar
    NXTabBar *customTabBar = [[NXTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    
    //  设置代理
    self.customTabBar.delegate = self;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 遍历tabbar中所有的子控件, 删除不需要的控件
    // UITabBarButton 这个类是私有API
//
//    long s = self.tabBar.subviews.count;
//
//    NXLog(@"-----%ld",s);
//    for (UIView *subView in self.tabBar.subviews) {
//
//               if ([subView isKindOfClass:[UIControl class]]) {
//            [subView removeFromSuperview];
//                   NXLog(@"执行了————————————————————-");
//        }
//    }
//
   
}

// 当最低支持版本为iOS 8时，在这个位置删除才不会出现重叠的问题（因为动态添加的原因）
-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    // 遍历tabbar中所有的子控件, 删除不需要的控件
    // UITabBarButton 这个类是私有API
    
    for (UIView *child in self.tabBar.subviews) {

        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {

            [child removeFromSuperview];
        }
    }
    
}

- (void)selectIndex:(NSInteger)index {
    [self.customTabBar selectIndex:index];
}

#pragma mark - NXTabBarDelegate
- (void)tabBar:(NXTabBar *)tabBar from:(NSInteger)from to:(NSInteger)to
{
    //  切换子控制器
    self.selectedIndex = to;
    
}

-(void)tabBarClickNXTabbarButtonNew{
    [self.customTabBar btnOnClickNew];
}

/*
 
 //  判断是否登录逻辑
- (BOOL)tabBar:(NXTabBar *)tabBar shouldChangeFrom:(NSInteger)from To:(NSInteger)to {
    
    if (to == self.viewControllers.count - 1) {
        BOOL isLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:kUserLoginFlagKey] boolValue];
        if (!isLogin) {
        
            __weak typeof(self) weakSelf = self;
            LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
            login.handler = ^{
                [weakSelf selectIndex:weakSelf.viewControllers.count - 1];
            };
            NXNavigationViewController *navi = [[NXNavigationViewController alloc] initWithRootViewController:login];
            [self.viewControllers.firstObject presentViewController:navi animated:YES completion:NULL];
            
            return NO;
        }
        
    }
    return YES;
}
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
