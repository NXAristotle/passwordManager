//
//  NXHomeViewController.m
//  passwordManager
//
//  Created by 林艺彬 on 2018/8/3.
//  Copyright © 2018年 nxaristotle. All rights reserved.
//

#import "NXHomeViewController.h"
#import "NXTestViewController.h"
#import "NXNavigationViewController.h"

@interface NXHomeViewController ()

@end

@implementation NXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 300)];
    testBtn.backgroundColor = [UIColor blueColor];
    [testBtn addTarget:self action:@selector(jumpToNextVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
   
    // Do any additional setup after loading the view.
}

- (void)jumpToNextVC {
    NXTestViewController *testVc = [[NXTestViewController alloc] init];
    testVc.title = @"测试用VC";
    [self.navigationController pushViewController:testVc animated:YES];
}


- (void)viewWillLayoutSubviews {
     self.view.backgroundColor = [UIColor yellowColor];
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
