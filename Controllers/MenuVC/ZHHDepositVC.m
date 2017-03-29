//
//  ZHHDepositVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHDepositVC.h"
#import "ZHHPortablePowerSourceVC.h"
#import "Order.h"
#import "DataSigner.h"
#import  <AlipaySDK/AlipaySDK.h>

@interface ZHHDepositVC ()
@property (weak, nonatomic) IBOutlet UIButton       *weBtn;
@property (weak, nonatomic) IBOutlet UIButton       *aliBtn;
@property (nonatomic, copy) NSString                *payWay;        //支付方式
@property (weak, nonatomic) IBOutlet UILabel        *moneyLb;       //299
@property (weak, nonatomic) IBOutlet UILabel        *moneyIntroLb;  //299下的文字说明
@property (weak, nonatomic) IBOutlet UIButton       *commitBtn;
@property (weak, nonatomic) IBOutlet UILabel        *rechargeIntroLb; //点击充值
@property (weak, nonatomic) IBOutlet UILabel        *currenMoneyLb;   //当前押金
@property (weak, nonatomic) IBOutlet UIImageView    *weixinIv;
@property (weak, nonatomic) IBOutlet UIImageView    *alipayIv;

@end

@implementation ZHHDepositVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alipaySuccess) name:@"alipaySuccess" object:nil];
}

-  (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self setupTitleWithText:@"押金充值"];
    [self weiBtn:self.weBtn];
    _payWay = @"weixin";
    
    _moneyLb.textColor = GLOBAL_ASSISTCOLOR;
    [_commitBtn setBackgroundColor:GLOBAL_ASSISTCOLOR];
    _commitBtn.layer.cornerRadius = GLOBAL_V(22);
    [_commitBtn.layer masksToBounds];
    _moneyIntroLb.textColor = GLOBAL_CONTENTCOLOR;
    _rechargeIntroLb.textColor = GLOBAL_CONTENTCOLOR;
    _currenMoneyLb.textColor = GLOBAL_CONTENTCOLOR;
    _weixinIv.height = GLOBAL_H(40);
    _alipayIv.height = GLOBAL_H(40);
}

- (IBAction)weiBtn:(UIButton *)sender {
    self.payWay = @"weixin";
    sender.selected = !sender.selected;
    if (self.aliBtn.selected) {
        self.aliBtn.selected = NO;
    }
    
}
- (IBAction)aliBtn:(UIButton *)sender {
    self.payWay = @"ali";
    sender.selected = !sender.selected;
    
    if (self.weBtn.selected) {
        self.weBtn.selected = NO;
    }
}

#pragma mark - 押金充值  -
- (IBAction)commitBtn:(UIButton *)sender {
    
    if (self.weBtn.selected || self.aliBtn.selected) {
        //充值押金 网络请求
        if ([_payWay isEqualToString:@"ali"]) {
            [self doAlipayPay];
        } else {
            [NetWorks chargeForUser:@"299" andPayWay:@"weixin" andIsDeposit:@"1" andSuccessed:^(id response) {
                [self pushPortablePowerSourceController];
            }];
        }
    } else {
        [HHProgressHUD showHUDInView:self.view animated:YES withText:@"请勾选一种支付方式"];
    }
}

- (void)alipaySuccess {
    [NetWorks chargeForUser:@"299" andPayWay:@"ali" andIsDeposit:@"1" andSuccessed:^(id response) {
        [self pushPortablePowerSourceController];
    }];
}

#pragma mark - 押金条款  -
- (IBAction)actionDepositIProtocolBtn:(id)sender {
    WKWebViewController *vc = [WKWebViewController webVCWithTitlt:@"押金条款" type:WKWebVCTypeDespoit];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 支付宝支付  -
- (void)doAlipayPay {
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088521232462214";
    NSString *seller = @"2088521232462214";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMpPm47MVwy+d5E+DufFMEmXpEnVeglvfm5piVyiYiAST6aQ+x58RjJcHZSZHdobriRTCW8ZVHKw87HHI99ruXhEBO8kqQ9LDWf/H3sxCcVxICK59y+DLZncUyhuJwOMEGFd6iCszETCg8aeGdw09K6yNkEdyhSpC9pyH75NVwwvAgMBAAECgYEApc0kQZ154fne5+uiL5RNhKKAg/oub7kuNrLLXl2+aWZYXLwI8e0LYo5Xt8bczjlNOHvNCX4K1YvrzFDWN26DqnUv33IaOkqqDz6+dd1K5upBj/coAItLuseg9oBQK2d0Ou7V/r27PbxvkV2NJ9bvnEhR6XlUnZrLra3CuPnpmNECQQDuzXMa8g5/DTOxZWzT/fsqhuQd6UP6MpQYLAwWUQgakqLdB8vJfPw1egg1/Y9XJv2mzOJdC1TsvFIwwtvznZSdAkEA2OFmxUp2UivpfMMtDOHTiThfWdS+l4Q+uh24bNBoLMC4CQQM+YfLrxeTnmMaMybzIovmAZEfAgk8bPG+MKU8OwJABL6EKObiLtf+TOns7ZFAKiof4hA+T3wtwQUvAEp/1LdREP8Up14aTJ2uCBSPgnW92FB9tseA2msrXtigMgjRaQJAKixql6LLL19qn+A0OnUPdXeI0ycTiNMmf3qYClDccRdoshgfjcZiTUIAaqRKy/ee//DEYTmfFf5FycmYek0nUQJBAJdKQ0FsIH3CShj4tFItg1r3Wm/JWAkizf6oJbm2BpupW8lHOtqOlRBo9ZZKxBZSKjBUqCOil1Yy5tcyg2ZiYbw=";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.subject = @"1"; //商品标题
    order.body = @"测试"; //商品描述
    order.totalFee = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
    order.notifyURL =  @"https://www.baidu.com"; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"aliairbike";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
    
}

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

- (void)pushPortablePowerSourceController {
    WKWebViewController *vc = [WKWebViewController webVCWithTitlt:@"充值成功" type:WKWebVCTypeRechargeSuccess];
    vc.nvLeftTitle = @"回到首页";
    typeof (WKWebViewController * )weakVC = vc;
    vc.leftBlock = ^ {
        [weakVC.navigationController popToRootViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

@end
