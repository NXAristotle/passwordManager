//
//  NXRouter.h
//  NXRouter
//
//  Created by linyibin on 2017/3/28.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const ZKQURLRouterPlist;

@class UIViewController, UINavigationController;

@interface NXRouter : NSObject

+ (instancetype)sharRouter;


/**
 加载 路由表 对应Plist
 
 @param pistName pistName(ZKQURLRouterPlist)
 */
- (void)loadConfigDictFromPlist:(NSString *)pistName;

/**
 拿到当前控制器
 
 @return 当前控制器
 */
- (UIViewController *)currentlyViewController;

/**
 push方法
 
 @param viewController 要跳转的viewController
 @param animated       animated
 */
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated;

/**
 push方法 url跳转
 
 @param urlString   urlString 可以带参数 可以将参数传递到params 也可以混着来
 会自动调用set方法赋值
 @param animated    animated
 */
- (void)pushURLString:(NSString *)urlString
             animated:(BOOL)animated;

- (void)pushURLString:(NSString *)urlString
               params:(nullable NSDictionary *)params
             animated:(BOOL)animated;

- (void)pushRootController:(UINavigationController *)navigationController
                 urlString:(NSString *)urlString
                    params:(nullable NSDictionary *)params
                  animated:(BOOL)animated;

- (void)pushRootController:(UINavigationController *)navigationController
            viewController:(UIViewController *)viewController
                  animated:(BOOL)animated;
/**
 pop方法
 
 @param animated animated
 */
- (void)popViewControllerAnimated:(BOOL)animated;
- (void)popTwiceViewControllerAnimated:(BOOL)animated;
/**
 * 
 * @param times  需要pop的VC的层数
 */
- (void)popViewControllerWithTimes:(NSUInteger)times
                          animated:(BOOL)animated;
- (void)popToRootViewControllerAnimated:(BOOL)animated;

/**
 present方法
 传入controller/url
 如果传入 NavigationClass 会生成一个Navigation
 params 可以直接传入或者带入 url中 或混着来
 */
- (void)presentViewController:(UIViewController *)controller
                     animated:(BOOL)animated
                   completion:(void (^ __nullable)(void))completion;

- (void)presentViewController:(UIViewController *)controller
                     animated: (BOOL)animated
          withNavigationClass:(nullable Class)classType
                   completion:(void (^ __nullable)(void))completion;

- (void)presentURLString:(NSString *)urlString
                animated:(BOOL)animated
              completion:(void (^ __nullable)(void))completion;

- (void)presentURLString:(NSString *)urlString
                  params:(NSDictionary * __nullable)params
                animated:(BOOL)animated
              completion:(void (^ __nullable)(void))completion;

- (void)presentURLString:(NSString *)urlString
                animated:(BOOL)animated
     withNavigationClass:(nullable  Class)classType
              completion:(void (^ __nullable)(void))completion;

- (void)presentURLString:(NSString *)urlString
                  params:(NSDictionary * __nullable)params
                animated:(BOOL)animated
     withNavigationClass:(nullable Class)classType
              completion:(void (^ __nullable)(void))completion;

- (void)presentRootViewController:(UIViewController *)rootController
                  navigationClass:(nullable Class)classType
                   viewController:(UIViewController *)controller
                         animated:(BOOL)animated
                       completion:(void (^ __nullable)(void))completio;

- (void)presentRootViewController:(UIViewController *)rootController
                   viewController:(UIViewController *)controller
                         animated:(BOOL)animated
                       completion:(void (^ __nullable)(void))completion;

- (void)presentRootViewController:(UIViewController *)rootController
                        URLString:(NSString *)urlString
                         animated:(BOOL)animated
                       completion:(void (^ __nullable)(void))completion;

- (void)presentRootViewController:(UIViewController *)rootController
                        URLString:(NSString *)urlString
                           params:(nullable NSDictionary *)params
                         animated:(BOOL)animated
                       completion:(void (^ __nullable)(void))completion;

- (void)presentRootViewController:(UIViewController *)rootController
                        URLString:(NSString *)urlString
                         animated:(BOOL)animated
              withNavigationClass:(nullable Class)classType
                       completion:(void (^ __nullable)(void))completion;

- (void)presentRootViewController:(UIViewController *)rootController
                        URLString:(NSString *)urlString
                           params:(nullable NSDictionary *)params
                         animated:(BOOL)animated
              withNavigationClass:(nullable Class)classType
                       completion:(void (^ __nullable)(void))completion;

/**
 dismiss方法
 补完系统没有的dismiss层数控制
 @param animated   animated
 @param completion completion
 */
- (void)dismissViewControllerAnimated:(BOOL)animated
                           completion: (void (^ __nullable)(void))completion;

- (void)dismissTwiceViewControllerAnimated:(BOOL)animated
                                completion: (void (^ __nullable)(void))completion;

- (void)dismissViewControllerWithTimes:(NSUInteger)times
                              animated:(BOOL)animated
                            completion: (void (^ __nullable)(void))completion;
- (void)dismissToRootViewControllerAnimated:(BOOL)animated
                                 completion: (void (^ __nullable)(void))completion;

NS_ASSUME_NONNULL_END
@end
