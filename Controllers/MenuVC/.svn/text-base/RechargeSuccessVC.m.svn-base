//
//  RechargeSuccessVC.m
//  AirBk
//
//  Created by Damo on 16/12/30.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "RechargeSuccessVC.h"

@interface RechargeSuccessVC ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLb;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation RechargeSuccessVC

//- (void)setNumber:(NSString *)number {
//    _number = number;
//    _moneyLb.text = number;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    [self setupTitleWithText:@"充值成功"];
    _moneyLb.text = _number;
    [self setupNavigatonLeftItemWithTitle:@"返回首页"];
    [self setupNavigationRightItemWithTitle:@"继续充值"];
    [self.nvLeftBtn addTarget: self action:@selector(nvLeftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.nvRightBtn addTarget: self action:@selector(nvRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_commitBtn setCornerRadiusWithRadius:_commitBtn.height / 2];
}

- (void)nvLeftBtnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)nvRightBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionCommitBtn:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goToScan" object:self];
}


@end
