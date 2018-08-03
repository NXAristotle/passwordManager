//
//  NXBaseViewController.m
//  WKDoctor
//
//  Created by xywy on 15/6/10.
//  Copyright (c) 2015年 NXAristotle. All rights reserved.
//

#import "NXBaseViewController.h"
#import "UIBarButtonItem+NX.h"

@interface NXBaseViewController ()

@end

@implementation NXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    self.requestCount = 0;
    
    // 设置返回按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImage:@"back" higImage:@"back" targe:self action:@selector(back)];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


// 下载加载框
//-(void)startLoading
//{
//    [MBProgressHUD showLoading];
//}
//-(void)stopLoading
//{
//    [MBProgressHUD hideHUD];
//}
-(void)startLoading
{
    if (!_loading)
    {
        _loading = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _loading.userInteractionEnabled = NO;
        _loading.backgroundColor = [UIColor clearColor];
        
        CGPoint point = self.view.center;
        point.y -= 64;
        _loading.center = point;
        [self.view addSubview:_loading];
        [self.view bringSubviewToFront:_loading];
        
        
        UIActivityIndicatorView *ActView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        ActView.frame = CGRectMake(0, 0, 70, 70);
        ActView.color = [UIColor colorFromHexRGB:@"1272e2"];
        //ActView.hidesWhenStopped = YES;
        [ActView startAnimating];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_loading animated:YES];
        hud.color = [UIColor clearColor];
        hud.backgroundColor = [UIColor colorWithWhite:111 alpha:0.7];
        hud.customView = ActView;
        hud.mode = MBProgressHUDModeCustomView;
        hud.removeFromSuperViewOnHide = YES;
        hud.userInteractionEnabled = NO;
    }
    _loading.hidden = NO;
    [self.view bringSubviewToFront:_loading];
}
-(void)stopLoading
{
    _loading.hidden = YES;
    if (_loading && _loading.superview) {
        [_loading removeFromSuperview];
        self.loading = nil;
    }
}

// 上传加载框
- (void)startUpLoading
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    if (_upLoading){
        if (_upLoading.superview){
            [_upLoading removeFromSuperview];
        }
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [HUD show:YES];
    [HUD setYOffset:- 30];
    HUD.labelText = @"正在提交";
    self.upLoading = HUD;
}
- (void)stopUpLoading
{
    _upLoading.hidden=YES;
    [_upLoading hide:YES];
    self.navigationItem.rightBarButtonItem.enabled = YES;
}


// 弹框显示提示消息
-(void)showMessage:(NSString *)message;
{
    [NXPopAlertViewLabel showshowPopAlertViewWithMessage:message withLabelViewAlpha:0.7 setInsertWidth:15 insertHeiht:15 andFrameCenterYoffset:0.5];
}



//-(void)alipayWithCode:(NSString *)code result:(NSString *)result {
//    //  处理支付回调
//}



-(void)setTestBtn
{
    // 设置返回按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImage:@"back" higImage:@"back" targe:self action:@selector(testAction)];
}

- (void)testAction {
    
}


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
