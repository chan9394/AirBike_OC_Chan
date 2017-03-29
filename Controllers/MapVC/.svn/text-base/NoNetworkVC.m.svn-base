//
//  NoNetworkVC.m
//  AirBk
//
//  Created by Damo on 16/12/31.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "NoNetworkVC.h"

@interface NoNetworkVC ()
@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;  //刷新按钮
@property (weak, nonatomic) IBOutlet UIImageView *iconIv;   //
@property (weak, nonatomic) IBOutlet UILabel *statusLb;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;        //返回按钮

@end

@implementation NoNetworkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIButton setCornerRadiusWithViews:@[_refreshBtn,_backBtn] Radius:GLOBAL_V(44) / 2];
}

- (IBAction)actionRefreshBtn:(id)sender {
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    if (manager.reachable) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
    if (_iconIv.alpha < 1) {
        return ;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _iconIv.alpha = 0;
        _statusLb.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _iconIv.alpha = 1;
            _statusLb.alpha = 1;
        }];
    }];
    
}

- (IBAction)actionBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

@end
