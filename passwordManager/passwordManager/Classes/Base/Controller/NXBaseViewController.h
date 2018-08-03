//
//  NXBaseViewController.h
//  WKDoctor
//
//  Created by xywy on 15/6/10.
//  Copyright (c) 2015年 NXAristotle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXBaseViewController : UIViewController

@property (retain, nonatomic) UIImageView       *loading;
@property (retain, nonatomic) MBProgressHUD     *upLoading;    //上传加载框
@property (assign, nonatomic) NSInteger         requestCount;  //请求次数
//@property (retain, nonatomic) NXUnifyInteractionView *unifyView;


// 返回按钮触发
-(void)back;


// 下载加载框
-(void)startLoading;
-(void)stopLoading;
// 上传加载框
-(void)startUpLoading;
-(void)stopUpLoading;


// 弹框显示提示消息
-(void)showMessage:(NSString *)message;

//支付结构返回值调用
//-(void)alipayWithCode:(NSString *)code result:(NSString *)result;


-(void)setTestBtn;


@end
