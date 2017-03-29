//
//  BaseNC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/26.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "BaseNC.h"
#import "APPManager.h"

@interface BaseNC ()

@end

@implementation BaseNC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = GLOBAL_THEMECOLOR;
    self.navigationBar.translucent = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 3;
    [self.navigationBar addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    BOOL test = [APPManager shareAppManager].isTest;
    NSString *string = nil;
    [APPManager shareAppManager].isTest = ! test;
    if (!(test == YES)) {
        string = @"测试模式开启";
    } else {
        string = @"普通模式开启";
    }
    [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:string];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

@end
