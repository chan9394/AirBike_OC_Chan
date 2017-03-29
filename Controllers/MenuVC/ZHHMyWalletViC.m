//
//  ZHHMyWalletViC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/3.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHMyWalletViC.h"
#import "ZHHMyWalletDetailTVC.h"
#import "ZHHDepositVC.h"
#import "ZHHRechargeWalletVC.h"
#import "ZHHDepositVC.h"
#import "RetunDespoitWebVC.h"

@interface ZHHMyWalletViC ()<ReminderViewDelegate>

@property (weak,   nonatomic) IBOutlet UILabel   *remainingbalanceLa;  //余额
@property (weak,   nonatomic) IBOutlet UILabel   *depositLabel;            //押金显示
@property (weak,   nonatomic) IBOutlet UIButton *depositBtn;               //充值或退款
@property (weak,   nonatomic) IBOutlet UILabel   *balanceIntoLb;          //车费余额的说明
@property (weak,   nonatomic) IBOutlet UIButton *rechargeBtn;             //充值按钮
@property (weak,   nonatomic) IBOutlet UILabel   *failedLb;                   //失败的提示
@property (nonatomic,   weak) AccountManager  *manager;                  //个人信息

@end

@implementation ZHHMyWalletViC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[_remainingbalanceLa,_depositBtn,_depositLabel,_balanceIntoLb,];
    [self changeViews:array Hidden:YES];
    _manager = [AccountManager shareAccountManager];
    
}

- (void)changeViews:(NSArray <UIView *>*)viewArr Hidden:(BOOL)isHidden {
    [viewArr enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = isHidden;
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self recoverShadow];
    _remainingbalanceLa.textColor = GLOBAL_ASSISTCOLOR;
    [_rechargeBtn setBackgroundColor:GLOBAL_ASSISTCOLOR];
    _balanceIntoLb.textColor = GLOBAL_CONTENTCOLOR;
    _depositLabel.textColor = GLOBAL_CONTENTCOLOR;
    _rechargeBtn.layer.cornerRadius = GLOBAL_V(44) / 2;
    [_rechargeBtn.layer masksToBounds];
    
    [self setupTitleWithText:@"我的钱包"];
    [self setupNavigationRightItemWithTitle:@"明细"];
     [self.nvRightBtn addTarget:self action:@selector(clickRBtn) forControlEvents:UIControlEventTouchUpInside];
    [self getWallerList];
}

- (void)getWallerList {
    //获取我的钱包详情
    [NetWorks getMyWalletListSuccessed:^(id response) {
        [_manager.balanceModel modelWIthJSON:response[@"result"]];
        [self setSubViews];
    } andFailed:^{
        _failedLb.text = @"网络加载失败";
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.tag ==10) {
                obj.hidden = YES;
            } else {
                obj.hidden = NO;
            }
        }];
    }];
}

#pragma mark - 余额查询结
- (void)setSubViews {
    if([AccountManager token]) {
        self.remainingbalanceLa.text = _manager.balanceModel.balance;
        
        if ([_manager hasDeposit]) {
            self.depositLabel.text = [NSString stringWithFormat:@"押金%.f元", [_manager.balanceModel.deposit floatValue]];
            [self.depositBtn setTitle:@"押金退款" forState:UIControlStateNormal];
        } else {
            self.depositLabel.text = @"押金0元";
            [self.depositBtn setTitle:@"充值押金" forState:UIControlStateNormal];
        }
    }
}

#pragma mark - 押金退款 or 充值押金  -
- (IBAction)clickDepositBtn:(UIButton *)sender {
    if ([_manager hasDeposit]) {
        WKWebViewController *vc = [WKWebViewController webVCWithTitlt:@"押金说明" type:WKWebVCTypeDespoitNext];
        [self.navigationController pushViewController:vc animated:YES];
        [vc removeShadow];
    } else {
        ZHHDepositVC *vc = [[ZHHDepositVC alloc] init];
        vc.view.frame = self.view.frame;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 明细  -
-(void)clickRBtn{
    ZHHMyWalletDetailTVC *vc =[[ZHHMyWalletDetailTVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 充值  -
- (IBAction)rechargeBtn:(UIButton *)sender {
    
    if ([_manager hasDeposit]) {
        ZHHRechargeWalletVC *vc = [[ZHHRechargeWalletVC alloc] init];
        vc.view.frame = self.view.frame;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        ReminderView *view = [ ReminderView reminderViewWithMessage:@"押金不足请先充值押金" leftBtnTitle:@"充值押金" rightBtnTitle:@"取消"];
        view.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }
}

#pragma mark -弹框的代理  -
- (void)reminderViewDidClickLeftBtn {
    [self clickDepositBtn:nil];
}


#pragma mark - 退押金代理方法  -
-(void)returnDeposit{
    WKWebViewController *webvc = [[WKWebViewController alloc] init];
    webvc.title = @"退押金";
    webvc.type = WKWebVCTypeRefundIntro;
    [self.navigationController pushViewController:webvc animated:YES];
}

#pragma mark - 控制器跳转  -


@end
