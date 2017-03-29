//
//  ZHHMyWalletDetailTVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHMyWalletDetailTVC.h"
#import "ZHHwlaaetDetailCell.h"
#import "ZHHRechargeModel.h"
static NSString *reusdId = @"ZHHwlaaetDetailCell";

@interface ZHHMyWalletDetailTVC ()

@property (nonatomic, strong)NSArray *rechargeListAry;
@end

@implementation ZHHMyWalletDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    UINib *nib = [UINib nibWithNibName:@"ZHHwlaaetDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reusdId];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self setupTitleWithText:@"账目明细"];
    [self setupNavigationRightItemWithTitle:@"退款说明"];
    [self.nvRightBtn addTarget:self action:@selector(nvRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
//获取充值列表
    [NetWorks getMyChargeListSuccessed:^(id response) {
        if( [APPManager shareAppManager].isTest) {
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"获取充值列表成功"];
        }
        [GLOBAL_MANAGER.rechargeModel modelWithJSON:response[@"result"]];
        self.rechargeListAry = GLOBAL_MANAGER.rechargeModel.rechageDetailArr;
        [self.tableView reloadData];
    }];
}

- (void)getChargeListResult:(NSDictionary *)response {
    NSInteger status = [response[@"status"] integerValue];
    switch (status) {
        case -99:
            [HHProgressHUD showHUDInView:self.view animated:YES withText:@"认证失败"];
            break;
            
        case 0:
            [HHProgressHUD showHUDInView:self.view animated:YES withText:@"参数不合法"];
            break;
        case -2:
            [HHProgressHUD showHUDInView:self.view animated:YES withText:@"登录过期"];
            break;
        case -1:
            [HHProgressHUD showHUDInView:self.view animated:YES withText:@"用户不存在,注册后登录"];
            break;
        case 1:
        {
        }
    }
}


- (void)nvRightBtnClick {
    WKWebViewController *vc = [WKWebViewController webVCWithTitlt:@"押金说明" type:WKWebVCTypeDespoit];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rechargeListAry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHHwlaaetDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reusdId forIndexPath:indexPath];
    cell.detailModel = self.rechargeListAry[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 67;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

- (NSArray *)rechargeListAry {
    if (_rechargeListAry == nil) {
        _rechargeListAry = [NSArray array];
    }
    return  _rechargeListAry;
}

@end
