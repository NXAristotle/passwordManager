//
//  NXPersonalCenterViewController.m
//  passwordManager
//
//  Created by 林艺彬 on 2018/8/3.
//  Copyright © 2018年 nxaristotle. All rights reserved.
//

#import "NXPersonalCenterViewController.h"

@interface NXPersonalCenterViewController ()

@end

@implementation NXPersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];

    UIView *testview = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 300)];
    testview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:testview];
//    self.navigationController.title = @"个人中心";
//     self.title = @"个人中心";
    // Do any additional setup after loading the view.
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
