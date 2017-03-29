//
//  ZHHCompleteAddressSucceVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/28.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHCompleteAddressSucceVC.h"
#import "ZHHRechargeWalletVC.h"

@interface ZHHCompleteAddressSucceVC ()

@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;
@property (weak, nonatomic) IBOutlet UIButton *backHomeBtn;

@end

@implementation ZHHCompleteAddressSucceVC

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self setupTitleWithText:@"商品即将发出"];
    _rechargeBtn.layer.cornerRadius = GLOBAL_V(44) / 2;
    _backHomeBtn.layer.cornerRadius = GLOBAL_V(44) / 2;
    [_rechargeBtn.layer masksToBounds];
    [_backHomeBtn.layer masksToBounds];
}

- (IBAction)clickGoRootVC:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)goRechargeWallet:(UIButton *)sender {
    ZHHRechargeWalletVC *vc = [[ZHHRechargeWalletVC alloc] init];
    vc.view.frame = self.view.frame;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
