//
//  NXPopAlertViewLabel.m
//  2.6-NXPopAlert
//
//  Created by linyibin on 15/2/6.
//  Copyright (c) 2015年 NXAristotle. All rights reserved.
//

#import "NXPopAlertViewLabel.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kPadding 50  // Label距离屏幕左右的边距

@implementation NXPopAlertViewLabel


+ (void)showshowPopAlertViewWithMessage:(NSString *)message withLabelViewAlpha:(CGFloat)alpha setInsertWidth:(int)insertWidth insertHeiht:(int)insertHeight andFrameCenterYoffset:(CGFloat)offset{
    
    NXPopAlertViewLabel *tempLabel = [[NXPopAlertViewLabel alloc] init];
    
    [tempLabel showPopAlertViewWithMessage:message withLabelViewAlpha:alpha setInsertWidth:insertWidth insertHeiht:insertHeight andFrameCenterYoffset:offset];
}

- (void)showPopAlertViewWithMessage:(NSString *)message withLabelViewAlpha:(CGFloat)alpha setInsertWidth:(int)insertWidth insertHeiht:(int)insertHeight andFrameCenterYoffset:(CGFloat)offset{
    UIWindow *MainWindow = [UIApplication sharedApplication].keyWindow;
    /*
    UIButton *backgroundView = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [mainWindow addSubview:backgroundView];
    
    backgroundView.userInteractionEnabled = NO;
    */
    
    self.text = message;
    self.numberOfLines = 0;
    self.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = [UIColor blackColor];
    self.textColor = [UIColor whiteColor];
    self.alpha = 0;
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    //  设置宽高限制
    CGSize sizesize = CGSizeMake(kScreenWidth - 2 * kPadding, MAXFLOAT);
    //  用文字计算出Size
    CGSize sizeTop = [self stringWithSizeLine:self.text font:self.font size:sizesize];
    //  设置frame
    self.frame = CGRectMake(0, 0, sizeTop.width + insertWidth, sizeTop.height + insertHeight);
    //    self.showLabel = showLabel;
    self.center = CGPointMake(kScreenWidth *0.5, kScreenHeight * offset);
    
    //  动画
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = alpha;
        [MainWindow addSubview:self];
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.3f animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        });
        
        
    }];
}

-(CGSize )stringWithSizeLine:(NSString *)str font:(UIFont *)font size:(CGSize)size
{
    NSMutableDictionary * Att= [NSMutableDictionary dictionary];
    Att[NSFontAttributeName] = font;
    return  [str boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:Att context:nil].size;
}

@end
