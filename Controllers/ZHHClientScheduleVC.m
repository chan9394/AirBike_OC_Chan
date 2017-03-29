//
//  ZHHClientScheduleVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/1.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHClientScheduleVC.h"

@interface ZHHClientScheduleVC ()

@end

@implementation ZHHClientScheduleVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupTitleWithText:@"客户服务进度查询"];
    [self setupNavigationRightItemWithImage:@[@"imgs_menu_arrow_left"]];
    [self.nvLeftBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickBackBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
