//
//  BaseVC.m
//  air_bike
//
//  Created by Damo on 16/12/8.
//  Copyright © 2016年 Damo. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItemWithLeftImages:@[@"imgs_menu_arrow_left"] rightimages:nil];
    [self.nvLeftBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
- (void)clickBackBtn {
    UIView *subView = [GLOBAL_KEYWINDOW viewWithTag:100];
    if (subView) {
        [subView removeFromSuperview];
    }
    
    if (self.clickNavLeftBtnHandle) {
        self.clickNavLeftBtnHandle();
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.translucent = NO;
}
#pragma mark - 设置状态栏  -
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - 切圆角  -
- (void)clipCornerRadiusWith:(NSArray <UIView *>*)array {
    [array enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.cornerRadius =obj.height / 2;
        [obj.layer masksToBounds];
    }];
}
@end
