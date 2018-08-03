//
//  NXRouter.m
//  NXRouter
//
//  Created by linyibin on 2017/3/28.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXRouter.h"
#import <UIKit/UIKit.h>


NSString *const ZKQURLRouterPlist = @"NXRouter.plist";

@interface NXRouter ()

@property (nonatomic, strong) NSDictionary *configDict;

@end

static NXRouter *_router;

@implementation NXRouter

+(instancetype)sharRouter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _router = [[self alloc] init];
    });
    return _router;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _router = [super allocWithZone:zone];
    });
    return _router;
}

- (id)copyWithZone:(NSZone *)zone {
    return _router;
}


- (void)loadConfigDictFromPlist:(NSString *)pistName {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:pistName ofType:nil];
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (configDict) {
        self.configDict = configDict;
    }else {
        NSAssert(0, @"can't find the plist file");
    }
}


- (UIViewController *)currentlyViewController {
    
    //通过递归拿到当前控制器
    UIViewController *activityViewController;
    activityViewController = [self recursionControllerFrom:[UIApplication sharedApplication].delegate.window.rootViewController];
    return activityViewController;
    
}

- (UIViewController *)recursionControllerFrom:(UIViewController *)controller {
    
    if ([controller isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)controller;
        return [self recursionControllerFrom:navigationController.viewControllers.lastObject];
    } else if ([controller isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarController = (UITabBarController *)controller;
        return [self recursionControllerFrom:tabbarController.selectedViewController];
    } else if (controller.presentedViewController != nil) {
        return [self recursionControllerFrom:(UIViewController *)controller.presentedViewController];
    } else {
        return controller;
    }
}

- (NSMutableDictionary *)paramsWithUrl:(NSURL *)url {
    
    NSString *query = url.query;
    
    NSArray *querys = [query componentsSeparatedByString:@"&"];
    
    return [self analysisWithKeyValue:querys];
}

- (nonnull NSMutableDictionary *)analysisWithKeyValue:(NSArray <NSString *> *)array {
    
    NSMutableDictionary *returnDic = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < array.count; i++) {
        NSString *keyValue = array[i];
        
        NSArray *subArry = [keyValue componentsSeparatedByString:@"="];
        
        if (subArry.count >= 1) {
            
            // 把utf-8过的字符串 转换回nsstring
            if ([[subArry lastObject] isKindOfClass:[NSString class]]) {
                [returnDic setObject:[[subArry lastObject] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:[subArry firstObject]];
            } else {
                [returnDic setObject:[subArry lastObject] forKey:[subArry firstObject]];
            }
            
            
        }
    }
    
    return returnDic;
}

-(NSString *)URLDecodedString:(NSString *)encodedString
{
    NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
    //                                                                                                                     (__bridge CFStringRef)encodedString,
    //                                                                                                                     CFSTR(""),
    //                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

- (UIViewController *)viewControllerWithUrl:(NSString *)urlString {
    
    //转成utf-8 可以带中文参数
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    if (!url.host || !url.scheme) {
        NSAssert(0, @"Wrong URL");
        return nil;
    }
    
    NSString *classString;
    if ([self.configDict.allKeys containsObject:url.scheme]) {
        
        id schemeConfig = [self.configDict objectForKey:url.scheme];
        
        
        if ([schemeConfig isKindOfClass:[NSString class]]) {
            classString = schemeConfig;
        } else if ([schemeConfig isKindOfClass:[NSDictionary class]]) {
            
            id hostConfig = [schemeConfig objectForKey:url.host];
            
            if ([hostConfig isKindOfClass:[NSString class]]) {
                classString = hostConfig;
            } else if ([hostConfig isKindOfClass:[NSDictionary class]]) {
                //url.path /one/two 所以需要去掉/
                id pathConfig = [hostConfig objectForKey:[url.path substringFromIndex:1]];
                
                if ([pathConfig isKindOfClass:[NSString class]]) {
                    classString = pathConfig;
                } else {
                    NSAssert(0, @"Please check plist map");
                    return nil;
                }
            } else {
                NSAssert(0, @"Please check plist map");
                return nil;
            }
        } else {
            NSAssert(0, @"Please check plist map");
            return nil;
        }
    }
    Class class = NSClassFromString(classString);
    if (!class) {//适配swift
        NSString *spaceName = [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"];
        class =  NSClassFromString([NSString stringWithFormat:@"%@.%@", spaceName, classString]);
    }
    
    UIViewController *controller = [[class alloc] init];
    
    if ([url.scheme hasPrefix:@"http"]) {
        NSDictionary *params = @{@"webUrl": urlString};
        [self setValuesForKeysController:controller Dictionary:params];
    } else if (url.query.length) {
        NSDictionary *params = [self paramsWithUrl:url];
        [self setValuesForKeysController:controller Dictionary:params];
    }
    
    return controller;
}

- (void)setValuesForKeysController:(UIViewController *)controller
                        Dictionary:(NSDictionary *)params {
        //  给VC的property赋值
        [controller mj_setKeyValues:params];
    
   }

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated {
    [[self currentlyViewController].navigationController pushViewController:viewController animated:animated];
}

- (void)pushRootController:(UINavigationController *)navigationController
            viewController:(UIViewController *)viewController
                  animated:(BOOL)animated {
    [navigationController pushViewController:viewController animated:animated];
}

- (void)pushURLString:(NSString *)urlString
             animated:(BOOL)animated {
    [self pushURLString:urlString params:nil animated:animated];
}



- (void)pushURLString:(NSString *)urlString
               params:(NSDictionary *)params
             animated:(BOOL)animated {
    
    UIViewController *controller = [self viewControllerWithUrl:urlString];
    
    if (controller) {
        [self setValuesForKeysController:controller Dictionary:params];
    } else {
        NSLog(@"no controller, please check plist or url");
    }
    if ([[self currentlyViewController] isKindOfClass:[UINavigationController class]]) {
        UINavigationController *naviga = (UINavigationController *)[self currentlyViewController];
        [naviga pushViewController:controller animated:animated];
    } else if ([[self currentlyViewController]isKindOfClass:[UIViewController class]]) {
        [[self currentlyViewController].navigationController pushViewController:controller animated:animated];
    } else {
        NSLog(@"Maybe you need a navigationController");
    }
    
}

- (void)pushRootController:(UINavigationController *)navigationController
                 urlString:(NSString *)urlString
                    params:(NSDictionary *)params
                  animated:(BOOL)animated {
    
    UIViewController *controller = [self viewControllerWithUrl:urlString];
    
    if (controller) {
        [self setValuesForKeysController:controller Dictionary:params];
    } else {
        NSLog(@"no controller, please check plist or url");
        return;
    }
    
    [navigationController pushViewController:controller animated:animated];
    
}

- (void)popViewControllerAnimated:(BOOL)animated {
    [[self currentlyViewController].navigationController popViewControllerAnimated:animated];
}

- (void)popTwiceViewControllerAnimated:(BOOL)animated {
    [self popViewControllerWithTimes:2 animated:animated];
}

- (void)popToViewControllerClass:(Class)viewControllerClass
                        animated:(BOOL)animated {
    
    if ([viewControllerClass isSubclassOfClass:[UIViewController class]]) {
        
        NSLog(@"Please confirm the controller type");
        
        return;
    }
    
    NSArray *array = [self currentlyViewController].navigationController.viewControllers;
    NSInteger times = array.count;
    
    for (int i = 0; i < times; i++) {
        UIViewController *viewCon = array[i];
        if ([viewCon isKindOfClass:viewControllerClass]) {
            
            if (i != times - 1) {
                [[self currentlyViewController].navigationController popToViewController:viewCon animated:animated];
            } else {
                NSLog(@"Please confirm the controller type");
            }
            
            break;
        }
        
    }
    
    
    
}

- (void)popViewControllerWithTimes:(NSUInteger)times
                          animated:(BOOL)animated {
    
    UIViewController *currentViewController = [self currentlyViewController];
    NSUInteger count = currentViewController.navigationController.viewControllers.count;
    if(currentViewController){
        if(currentViewController.navigationController) {
            if (count > times){
                [currentViewController.navigationController popToViewController:[currentViewController.navigationController.viewControllers objectAtIndex:count-1-times] animated:animated];
            }else { // 如果times大于控制器的数量
                NSAssert(0, @"chotrollers coount is %zd, less or equal than %zd", count, times);
            }
        }
    }
}

- (void)popToRootViewControllerAnimated:(BOOL)animated {
    [[self currentlyViewController].navigationController popToRootViewControllerAnimated:animated];
}

- (void)presentViewController:(UIViewController *)controller
                     animated:(BOOL)animated
                   completion:(void (^ __nullable)(void))completion {
    [self presentViewController:controller animated:animated withNavigationClass:nil completion:completion];
}

- (void)presentRootViewController:(UIViewController *)rootController
                  navigationClass:(Class)classType
                   viewController:(UIViewController *)controller
                         animated:(BOOL)animated
                       completion:(void (^ __nullable)(void))completion {
    
    if ([classType isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[classType alloc]initWithRootViewController:controller];
        [rootController presentViewController:nav animated:animated completion:completion];
    } else {
        [rootController presentViewController:controller animated:animated completion:completion];
    }
    
}

- (void)presentRootViewController:(UIViewController *)rootController
                   viewController:(UIViewController *)controller
                         animated:(BOOL)animated
                       completion:(void (^ __nullable)(void))completion {
    [self presentRootViewController:rootController navigationClass:nil viewController:controller animated:animated completion:completion];
}

- (void)presentViewController:(UIViewController *)controller
                     animated:(BOOL)animated
          withNavigationClass:(Class)class
                   completion:(void (^ __nullable)(void))completion {
    
    if ([class isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[class alloc]initWithRootViewController:controller];
        [[self currentlyViewController] presentViewController:nav animated:animated completion:completion];
    } else {
        [[self currentlyViewController] presentViewController:controller animated:animated completion:completion];
    }
}

- (void)presentURLString:(NSString *)urlString
                animated:(BOOL)animated
              completion:(void (^ __nullable)(void))completion {
    [self presentURLString:urlString params:nil animated:animated completion:completion];
}

- (void)presentURLString:(NSString *)urlString
                  params:(nullable NSDictionary *)params
                animated:(BOOL)animated
              completion:(void (^ __nullable)(void))completion {
    [self presentURLString:urlString params:params animated:animated withNavigationClass:nil completion:completion];
}

- (void)presentURLString:(NSString *)urlString
                animated:(BOOL)animated
     withNavigationClass:(nullable Class)class
              completion:(void (^ __nullable)(void))completion {
    
    [self presentURLString:urlString params:nil animated:animated withNavigationClass:class completion:completion];
}

- (void)presentURLString:(NSString *)urlString
                  params:(nullable NSDictionary *)params
                animated:(BOOL)animated
     withNavigationClass:(nullable Class)class
              completion:(void (^ __nullable)(void))completion {
    UIViewController *controller = [self viewControllerWithUrl:urlString];
    
    if (!controller) {
        NSLog(@"no controller, please check plist or url");
        return;
    }
    
    [self setValuesForKeysController:controller Dictionary:params];
    
    if (class && [class isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[class alloc] initWithRootViewController:controller];
        [[self currentlyViewController] presentViewController:nav animated:animated completion:completion];
    } else if(class) {
        NSAssert(0, @"The class is't a UINavigationController");
    } else {
        [[self currentlyViewController] presentViewController:controller animated:animated completion:completion];
    }
}

- (void)presentRootViewController:(UIViewController *)rootController
                        URLString:(NSString *)urlString
                         animated:(BOOL)animated
                       completion:(void (^ __nullable)(void))completion {
    [self presentRootViewController:rootController URLString:urlString params:nil animated:animated completion:completion];
}

- (void)presentRootViewController:(UIViewController *)rootController
                        URLString:(NSString *)urlString
                           params:(nullable NSDictionary *)params
                         animated:(BOOL)animated
                       completion:(void (^ __nullable)(void))completion {
    [self presentRootViewController:rootController URLString:urlString params:params animated:animated withNavigationClass:nil completion:completion];
}

- (void)presentRootViewController:(UIViewController *)rootController
                        URLString:(NSString *)urlString
                         animated:(BOOL)animated
              withNavigationClass:(nullable Class)classType
                       completion:(void (^ __nullable)(void))completion {
    [self presentRootViewController:rootController URLString:urlString params:nil animated:animated withNavigationClass:classType completion:completion];
}

- (void)presentRootViewController:(UIViewController *)rootController
                        URLString:(NSString *)urlString
                           params:(nullable NSDictionary *)params
                         animated:(BOOL)animated
              withNavigationClass:(nullable Class)classType
                       completion:(void (^ __nullable)(void))completion {
    UIViewController *controller = [self viewControllerWithUrl:urlString];
    
    if (!controller) {
        NSLog(@"no controller, please check plist or url");
        return;
    }
    
    [self setValuesForKeysController:controller Dictionary:params];
    
    if (classType && [classType isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[classType alloc] initWithRootViewController:controller];
        [rootController presentViewController:nav animated:animated completion:completion];
    } else if (classType) {
        NSAssert(0, @"The class is't a UINavigationController");
    } else {
        [rootController presentViewController:controller animated:animated completion:completion];
    }
}

- (void)dismissViewControllerAnimated:(BOOL)animated
                           completion: (void (^ __nullable)(void))completion {
    [[self currentlyViewController] dismissViewControllerAnimated:animated completion:completion];
}

- (void)dismissTwiceViewControllerAnimated:(BOOL)animated
                                completion: (void (^ __nullable)(void))completion {
    [self dismissViewControllerWithTimes:2 animated:animated completion:completion];
}

- (void)dismissViewControllerWithTimes:(NSUInteger)times
                              animated:(BOOL)animated
                            completion: (void (^ __nullable)(void))completion {
    UIViewController *rootVC = [self currentlyViewController];
    
    if (rootVC) {
        while (times > 0) {
            rootVC = rootVC.presentingViewController;
            times -= 1;
        }
        if (!rootVC) {
            NSLog(@"your times bigger than present controller count");
            return;
        }
        [rootVC dismissViewControllerAnimated:animated completion:completion];
    }
    
}

- (void)dismissToRootViewControllerAnimated:(BOOL)animated
                                 completion: (void (^ __nullable)(void))completion {
    UIViewController *rootVC = [self currentlyViewController];
    while (rootVC.presentingViewController) {
        rootVC = rootVC.presentingViewController;
    }
    [rootVC dismissViewControllerAnimated:animated completion:completion];
    
}



@end
