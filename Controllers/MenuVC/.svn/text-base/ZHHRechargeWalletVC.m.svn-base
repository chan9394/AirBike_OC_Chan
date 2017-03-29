//
//  ZHHRechargeWalletVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/28.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHRechargeWalletVC.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WebKit/WebKit.h>
#import <WXApiObject.h>
#import <WXApi.h>
#import "ZHHDepositVC.h"
#import "RetunDespoitWebVC.h"
#import "RechargeSuccessVC.h"

typedef NS_ENUM(NSInteger, rmbNumber)
{
    rmbTwo,
    rmbFive,
    rmbTen,
    rmbTwenty,
    rmbFifty,
    rmbHundred
};

@interface ZHHRechargeWalletVC ()<UITextFieldDelegate>

@property (weak,   nonatomic) IBOutlet UIButton       *rmbTwoBtn;
@property (weak,   nonatomic) IBOutlet UIButton       *rmbFiveBtn;
@property (weak,   nonatomic) IBOutlet UIButton       *rmbTenBtn;
@property (weak,   nonatomic) IBOutlet UIButton       *rmbTwentyBtn;
@property (weak,   nonatomic) IBOutlet UIButton       *rmbFiftyBtn;
@property (weak,   nonatomic) IBOutlet UIButton       *rmbHundredBtn;
@property (weak,   nonatomic) IBOutlet UITextField    *rmbTF;
@property (weak,   nonatomic) IBOutlet UIButton       *depositBtn;        //押金付款
@property (weak,   nonatomic) IBOutlet UILabel         *depositLabel;     //押金说明
@property (weak,   nonatomic) IBOutlet UIButton       *commitBtn;        //充值车费
@property (weak,   nonatomic) IBOutlet UIButton       *wexinBtn;
@property (weak,   nonatomic) IBOutlet UIImageView *aliIv;
@property (weak,   nonatomic) IBOutlet UIImageView *weixinIv;
@property (nonatomic,   weak) UIButton                    *selectedRmbBtn;   //选中的金额按钮
@property (nonatomic,   weak) UIButton                    *selectedPayWay;   //选中的支付方式
@property (nonatomic, assign) rmbNumber                 rmb;                     //充值金额


@end

@implementation ZHHRechargeWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedRmbBtn = self.rmbHundredBtn;
    self.selectedPayWay = self.wexinBtn;
    self.rmb = rmbHundred;
    self.wexinBtn.selected = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alipaySuccess) name:@"alipaySuccess" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupTitleWithText:@"钱包充值"];
    [self setupNavigationRightItemWithImage:@[@"imgs_menu_arrow_left"]];
    [self.nvLeftBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    self.rmbTF.delegate = self;
    self.weixinIv.height = GLOBAL_H(40);
    self.aliIv.height = GLOBAL_H(40);
    [self setupUI];
}

- (void)setupUI {
    [UIButton setCornerRadiusWithViews:@[_rmbTwoBtn,_rmbFiveBtn,_rmbTenBtn,_rmbTwentyBtn,_rmbFiftyBtn,_rmbHundredBtn]
                                Radius:GLOBAL_V(20)
                           BorderColor:GLOBAL_ASSISTCOLOR];
    [UIButton setCornerRadiusWithViews:@[_commitBtn] Radius:GLOBAL_V(22)  BorderColor:nil];
    _rmbTF.layer.cornerRadius = GLOBAL_V(22) ;
    [_rmbTF.layer masksToBounds];
    
    if([AccountManager token]) {
        if ([GLOBAL_MANAGER hasDeposit]) {
            self.depositLabel.text = [NSString stringWithFormat:@"押金%.f元", [GLOBAL_MANAGER.balanceModel.deposit floatValue]];
            [self.depositBtn setTitle:@"押金退款" forState:UIControlStateNormal];
        }else{
            self.depositLabel.text = @"押金0元";
            [self.depositBtn setTitle:@"充值押金" forState:UIControlStateNormal];
        }
        
    }
}

#pragma mark - 充值  -
- (IBAction)acitonTwoBtn:(UIButton *)sender {
    [self setSelectRMBWithBtn:sender rmb:rmbTwo];
}

- (IBAction)rmbFive:(UIButton *)sender {
    [self setSelectRMBWithBtn:sender rmb:rmbFive];
}
- (IBAction)rmbTen:(UIButton *)sender {
    [self setSelectRMBWithBtn:sender rmb:rmbTen];
}

- (IBAction)remTwenty:(UIButton *)sender {
    [self setSelectRMBWithBtn:sender rmb:rmbTwenty];
}

- (IBAction)rmbFifty:(UIButton *)sender {
    [self setSelectRMBWithBtn:sender rmb:rmbFifty];
}

- (IBAction)actionHundredBtn:(UIButton *)sender {
    [self setSelectRMBWithBtn:sender rmb:rmbHundred];
}

- (void)setSelectRMBWithBtn:(UIButton *)sender rmb:(rmbNumber)rmb {
    self.rmb = rmb;
    self.selectedRmbBtn = sender;
    [self userSelectedRmbBtn];
}

-(void)userSelectedRmbBtn{
    [self.rmbTF resignFirstResponder];
    self.rmbTF.textColor = [UIColor grayColor];
}



#pragma mark - 改变金额btn状态  -
- (void)setSelectedRmbBtn:(UIButton *)selectedRmbBtn {
    _selectedRmbBtn.selected = NO;
    [_selectedRmbBtn setBackgroundColor:[UIColor whiteColor]];
    _selectedRmbBtn = selectedRmbBtn;
    _selectedRmbBtn.backgroundColor = GLOBAL_ASSISTCOLOR;
    _selectedRmbBtn.selected = YES;
    
}

#pragma mark - textFiled Delegate  -
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    textField.textColor = [UIColor blackColor];
    self.selectedRmbBtn.selected = NO;
    self.selectedRmbBtn = nil;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField  {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 付款方式  -
- (IBAction)clickWexinPay:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    self.selectedPayWay.selected = NO;
    sender.selected = !sender.selected;
    self.selectedPayWay = sender;
}

- (IBAction)clickAliPay:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    self.selectedPayWay.selected = NO;
    sender .selected = !sender.selected;
    self.selectedPayWay = sender;
    
}

#pragma mark - 充值协议  -
- (IBAction)actionRechargeProtocolBtn:(id)sender {
    WKWebViewController *vc= [WKWebViewController webVCWithTitlt:@"充值协议" type:WKWebVCTypeRechargeProtocol];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 押金付款  -
- (IBAction)actionDepositBtn:(id)sender {
    if ([GLOBAL_MANAGER hasDeposit]) {
        RetunDespoitWebVC *vc= [[RetunDespoitWebVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        ZHHDepositVC *vc = [[ZHHDepositVC alloc] init];
        vc.view.frame = self.view.frame;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 充值车费  -
- (IBAction)clickCommitBtn:(UIButton *)sender {
    
    NSString *payWay = @"微信";
    //    NSString *payNum = @"100";
    if (self.selectedPayWay != self.wexinBtn) {
        payWay = @"支付宝";
    }
    if (self.selectedRmbBtn) {
        [self setPayWay:payWay];
    } else {
        if (self.rmbTF.text== nil) {
            [HHProgressHUD showHUDInView:self.view animated:YES withText:@"充值金额不能为空"];
        }else if (self.rmbTF.text.floatValue < 1){
            [HHProgressHUD showHUDInView:self.view animated:YES withText:@"充值金额不能低于1元"];
        }else{
            //            payNum = self.rmbTF.text;
            [self setPayWay:payWay];
        }
    }
    
    
}

- (void)setPayWay:(NSString *)payWay {
    if ([payWay isEqualToString:@"支付宝"]) {
        [self doAlipayPay];
    } else {
        //                if (![WXApi isWXAppInstalled]) {
        //                    [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"没有安装微信"];
        //                    return ;
        //                } else if (![WXApi isWXAppSupportApi]) {
        //                    [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"不支持微信支付"];
        //                    return;
        //                }
        //                [self doWeixinPay];
        
        [self chargeForUser:[self getRechargeNumber]];
    }
}


#pragma mark - 支付宝支付成功回调方法  -

- (void)alipaySuccess {
    [self chargeForUser:[self getRechargeNumber]];
}
#pragma mark - 充值  -

- (void)doAlipayPay
{
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

- (NSString *)generateTradeNO {
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++) {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


#pragma mark - 微信支付  -
- (void)doWeixinPay {
    NSString *res = [self jumpToBizPay];
    if( ![@"" isEqual:res] ){
        
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }
}

- (NSString *)jumpToBizPay {
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = @"1435701702";
    req.prepayId            = @"";
    req.nonceStr            =@"EStCEnC8lVvIBV10";
    
    req.timeStamp           = [[NSDate date] timeIntervalSince1970];
    req.package             = @"Sign=WXPay";
    req.sign                = @"";
    
    [WXApi sendReq:req];
    //日志输出
    NSLog(@"\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    return @"";
}

#pragma mark -   - 充值 网络请求
- (void)chargeForUser:(NSString *)amount{
    [NetWorks chargeForUser:amount andPayWay:@"weixin" andIsDeposit:@"0" andSuccessed:^(id response) {
        RechargeSuccessVC *vc = [[RechargeSuccessVC alloc] init];
        vc.number = [self getRechargeNumber];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

- (NSString *)getRechargeNumber {
    NSString *number = @"100";
    if (self.selectedRmbBtn) {
        switch (self.rmb) {
            case rmbTwo:
                number = @"2";
                break;
            case rmbFive:
                number = @"5";
                break;
            case rmbTen:
                number = @"10";
                break;
            case rmbTwenty:
                number = @"20";
                break;
            case rmbFifty:
                number = @"50";
                break;
            case rmbHundred:
                number = @"100";
            default:
                break;
        }
    } else {
        number = self.rmbTF.text;
    }
    return number;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
