//
//  BaseTC.m
//  air_bike
//
//  Created by Damo on 16/12/11.
//  Copyright © 2016年 Damo. All rights reserved.
//

#import "BaseTC.h"

@interface BaseTC ()

@end

@implementation BaseTC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItemWithLeftImages:@[@"imgs_menu_arrow_left"] rightimages:nil];
    [self.nvLeftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.backgroundColor = [UIColor colorWithRed:235.0 / 255 green:235.0 / 255 blue:235.0 / 255 alpha:1];
}

- (void)back {
    UIView *subView = [GLOBAL_KEYWINDOW viewWithTag:100];
    if (subView) {
        [subView removeFromSuperview];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置状态栏  -
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
