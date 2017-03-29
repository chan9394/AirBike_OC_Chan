//
//  WKWebViewController.m
//  AirBk
//
//  Created by Damo on 16/12/27.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "MainViewController.h"
#import "BaseNC.h"
#import "ZHHCompleteAddressVC.h"
#import "ZHHBikeModel.h"
#import "ZHHTrackFinishModel.h"
#import "ShareView.h"
#define basicUrl @"http://airbike.wrteach.com/h5/html/"

@interface WKWebViewController () <WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic,   weak) WKWebView         *webView;
@property (nonatomic, assign) BOOL                   isLoading;      //是否是首页
@property (nonatomic, strong) UIBarButtonItem    *backItem;     //返回按钮
@property (nonatomic, strong) UIBarButtonItem    *closeItem;     //关闭按钮
@property (nonatomic, strong) NSString               *cycleId;
@property (nonatomic,   weak) ShareView            *shareView;

@end

@implementation WKWebViewController {
    NSString *_urlStr;
    CALayer *_progressLayer;
    NSURL   *_url; //记录当前页面的URL
    UIImageView *_effectView;
}

- (instancetype)initWithTitlt:(NSString *)title type:(WKWebVCType)type {
    if (self = [super init]) {
        _type = type;
        _nvTitle = title;
        self.type = type;
    }
    return self;
}

- (instancetype)initWithTitlt:(NSString *)title type:(WKWebVCType)type nvBarHidden:(BOOL)ishidden {
    if (self = [super init]) {
        if (type) {
            self.type = type;
        }
        if (title) {
            _nvTitle = title;
        }
        if (ishidden) {
            _nvBarHidden = ishidden;
        }
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title type:(WKWebVCType)type cycleID:(NSString *)cycleId {
    if (self = [super init]) {
        self.nvTitle = title;
        self.cycleId = cycleId;
        self.type = type;
    }
    return self;
}

+ (instancetype)webVCWithtype:(WKWebVCType)type {
    return [[WKWebViewController alloc] initWithTitlt:nil type:type];
}

+ (instancetype)webVCWithTitlt:(NSString *)title type:(WKWebVCType)type {
    return [[WKWebViewController alloc] initWithTitlt:title type:type];
}

+ (instancetype)webVCWithTitlt:(NSString *)title type:(WKWebVCType)type nvBarHidden:(BOOL)isHidden {
    return [[WKWebViewController alloc] initWithTitlt:title type:type nvBarHidden:isHidden];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.nvBarHidden) {
        self.navigationController.navigationBar.hidden = YES;
    }
    
    if (self.nvRightTitle) {
        [self setupNavigationRightItemWithTitle:_nvRightTitle];
    }
    
    if (self.nvLeftTitle) {
        [self setupNavigatonLeftItemWithTitle:_nvLeftTitle];
    }
    
    if (self.leftBlock) {
        [self.nvLeftBtn addTarget:self action:@selector(nvLeftBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.rightBlock) {
        [self.nvRightBtn addTarget:self action:@selector(nvRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (_type == WKWebVCTypeMoveEnd) {
        [self removeShadow];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.nvBarHidden) {
        self.navigationController.navigationBar.hidden = NO;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self AddWebview];
    _webView.navigationDelegate = self;
    self.navigationItem.leftBarButtonItem = self.backItem;
    //进度条
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self setupTitleWithText:_nvTitle ? _nvTitle : @""];
    if (_urlStr) {
        NSURL *url = [NSURL URLWithString:_urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }
    
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = GLOBAL_ASSISTCOLOR.CGColor;
    [progress.layer addSublayer:layer];
    _progressLayer = layer;
    //分享成功回调
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareSuccess) name:@"shareSuccess" object:nil];
}

- (void)AddWebview {
    if (self.webView) {
        [self.webView removeFromSuperview];
    }
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKUserContentController* userContent = [[WKUserContentController alloc] init];
    [userContent addScriptMessageHandler:self name:@"Appmodel"];
    config.userContentController = userContent;
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preferences;
    WKWebView *webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    _webView = webview;
    if (_nvBarHidden) {
        webview.frame = self.view.bounds;
    } else {
        webview.height = self.view.height - 64;
    }
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:webview];
}


#pragma mark - 根据HTMLString加载网页  -
- (void)loadHTMLString:(NSString *)htmlString {
    if (!htmlString) {
        return;
    }
    _urlStr = htmlString;
}

#pragma mark - 进度条  -
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        _progressLayer.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        _progressLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _progressLayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _progressLayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - 左右按钮点击  -
- (void)nvRightBtnClick {
    if (_rightBlock) {
        _rightBlock();
    }
}

- (void)nvLeftBtnBtnClick {
    if (_leftBlock) {
        _leftBlock();
    }
}


#pragma mark - 监听H5  -
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSString *code = message.body[@"content"];
    if (!code) {
        return;
    }
    NSString *encodeStr = [[NSString stringWithFormat:@"%@%@",code,AirBike_Salt] encodeMd5];
    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"getchecksum('%@')",encodeStr] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
        NSLog(@"%@",response);
    }];
    
}

#pragma mark - 发送请求之前决定是否跳转  -
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"%@",navigationAction.request.URL);
    _url = navigationAction.request.URL;
    [self setupMoveEndUIWithUrl:navigationAction.request.URL];
    if ([navigationAction.request.URL.scheme isEqualToString:@"bridge"]) {
        if ([navigationAction.request.URL.host isEqualToString:@"airbike"]) {
            NSLog(@"%@",navigationAction.request.URL.query);
            NSArray *dataArray = [navigationAction.request.URL.query componentsSeparatedByString:@"="];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:dataArray[1] forKey:dataArray[0]];
            if ([dict[@"number"] isEqualToString:@"1"]) {   //返回上一级界面
                [self.navigationController popViewControllerAnimated:YES];
            }
            if ([dict[@"number"] isEqualToString:@"2"]) {   //回首页
                MainViewController *vc= [[MainViewController alloc] init];
                BaseNC *root = [[BaseNC alloc] initWithRootViewController:vc];
                [UIApplication sharedApplication].keyWindow.rootViewController = root;
            }
            if ([dict[@"number"] isEqualToString:@"3"]) {  //填写地址
                ZHHCompleteAddressVC *vc=  [[ZHHCompleteAddressVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([dict valueForKey:@"token"]) {
                NSString *code = dict[@"token"];
                NSString *encodeStr = [[NSString stringWithFormat:@"%@%@",code,AirBike_Salt] encodeMd5];
                [self.webView evaluateJavaScript:[NSString stringWithFormat:@"getchecksum('%@')",encodeStr] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                    if (error) {
                        NSLog(@"%@",error);
                    }
                    NSLog(@"%@",response);
                }];
            }
        }
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark -   - 加载网页失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    if ([[UIApplication sharedApplication].keyWindow.rootViewController isMemberOfClass:[WKWebViewController class]]) {
        MainViewController *vc= [[MainViewController alloc] init];
        BaseNC *root = [[BaseNC alloc] initWithRootViewController:vc];
        [UIApplication sharedApplication].keyWindow.rootViewController = root;
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -   - 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    if(self.type != WKWebVCTypePlayIntro) {
        [self setupTitleWithText:webView.title];
    }
}

#pragma mark - 骑行结束页  -
- (void)setupMoveEndUIWithUrl:(NSURL *)url {
    NSString *urlStr = [url absoluteString];
    if ([urlStr containsString:@"riding_trip_detail.html"]) {
        self.nvRightBtn.hidden = NO;
        //        _webView.height = self.view.height;
        //        _webView.y = ;
    }
    if ([urlStr containsString:@"riding_trip_end.html"]) {
        self.nvRightBtn.hidden = YES;
        
    }
}

#pragma mark - 重写type的setter方法  -
- (void)setType:(WKWebVCType)type {
    _type = type;
    //    NSMutableString *mStr = [NSMutableString stringWithString:@"http://1.liwww.applinzi.com/myapp/html/"];
    NSMutableString *mStr = [NSMutableString stringWithString:basicUrl];
    switch (type) {
        case WKWebVCTypeProductIntro:                           //产品介绍
            [mStr appendString:@"product_intro.html"];
            break;
        case WKWebVCTypeRefundIntro:                                     //退款选择
            [mStr appendString:@"refund_option.html"];
            break;
        case WKWebVCTypeMoveDetail:                                   //骑行详情
            //            [mStr appendString:@"movedetial.html"];
            [mStr appendFormat:@"riding_trip_detail.html?token=%@&id=%@",GLOBAL_TOKEN,_cycleId];
            break;
        case WKWebVCTypeNegaticeCredit:                       //负面记录
            [mStr appendString:@"negative_record.html"];
            break;
        case WKWebVCTypeMoveEnd:                                 //骑行结束
            //            [mStr appendString:@"moveend.html"];
            [mStr appendString:[NSString stringWithFormat:@"riding_trip_end.html?token=%@&id=%@",GLOBAL_TOKEN,_cycleId]];
            break;
        case WKWebVCTypeMoveShare:                             //骑行分享
            [mStr appendString:@"share_riding_trip_detail.html"];
            break;
        case WKWebVCTypePhoneNumber:                    //手机号更换
            [mStr appendString:@"phoneNumber.html"];
            break;
        case WKWebVCTypeChangeNumSuccess:          //手机号更换成功
            [mStr appendString:@"successnumber.html"];
            break;
        case WKWebVCTypeAbountAirBike:                  //关于airbike
            [mStr appendString:@"about_airbike_intro.html"];
            break;
        case WKWebVCTypeAbountCredit:                   //信用积分原则
            [mStr appendString:@"credit_score_rule.html"];
            break;
        case WKWebVCTypeAddCredit:                      //信用分记录表
            [mStr appendString:@"credit_score_list.html"];
            break;
        case WKWebVCTypeMyCredit:                      //我的信用
            //            [mStr appendString:@"my_credit.html"];
            [mStr appendString:[NSString stringWithFormat:@"my_credit_intro.html?token=%@",GLOBAL_TOKEN]];
            break;
        case WKWebVCTypeConnect:                             //联系我们
            [mStr appendString:@"contact_us_method.html"];
            break;
        case WKWebVCTypeDespoit:                                 //押金说明
            [mStr appendString:@"despoit_intro.html"];
            break;
        case WKWebVCTypeDespoitNext:                             //押金说明(下一步)
            //            NSString *token = [ZHHUserInfo sharedUserInfo].token;
            //            [mStr appendString:@"despoit_next.html"];
            [mStr appendString:[NSString stringWithFormat:@"despoit_intro_refund_select.html?token=%@",GLOBAL_TOKEN]];
            break;
        case WKWebVCTypeDespoitOverTime:                    //押金说明(超7个工作日)
            //            [mStr appendString:@"despoit_money.html"];
            [mStr appendString:[NSString stringWithFormat:@"despoit_intro_order_query.html?token=%@",GLOBAL_TOKEN]];
            break;
        case  WKWebVCTypeReturnDespoitProtocol:           //押金退还条款
            [mStr appendString:@"despoit_refund_rule.html"];
            break;
        case  WKWebVCTypeSenReturnIntroSuccess:           //退款说明提交成功
            [mStr appendString:@"refund_success.html"];
            break;
        case WKWebVCTypeLoading:                                //首页轮播
            [mStr appendString:@"landing_page.html"];
            break;
        case WKWebVCTypeNoCar:                                     //找不到车
            [mStr appendString:@"find_car_method.html"];
            break;
        case WKWebVCTypeQuestion:                              //问题反馈
            [mStr appendString:@"question.html"];
            break;
        case WKWebVCTypeRechargeIntro:                       //充值说明
            [mStr appendString:@"recharge_intro.html"];
            break;
        case WKWebVCTypeRechargeSuccess:                //充值成功
            [mStr appendString:@"recharge_success.html"];
            break;
        case WKWebVCTypeRechargeProtocol:                   //充值协议
            [mStr appendString:@"charge_agreement.html"];
            break;
        case WKWebVCTypeSendSource:                               //发送移动电源
            [mStr appendString:@"sendsource.html"];
            break;
        case  WKWebVCTypeChangeSource:                  //更换移动电源填写
            [mStr appendString:@"oldruler.html"];
            break;
        case WKWebVCTypeUserProtocol:                              //用户协议
            [mStr appendString:@"user_agreement.html"];
            break;
        case WKWebVCTypeAccountDetail:                          //账户明细
            //            [mStr appendString:@"whatmoney.html"];
            [mStr appendString:[NSString stringWithFormat:@"account_detail.html?token=%@",GLOBAL_TOKEN]];
//            mStr = [NSMutableString stringWithFormat:@"http://1.liwww.applinzi.com/myapp/html/whatmoney.html?token=%@",GLOBAL_TOKEN];
            break;
        case WKWebVCTypeQueryOrdernumber:           //订单号查询
            [mStr appendString:@"order_query.html"];
            break;
        case WKWebVCTypePlayIntro:                          //使用说明
            [mStr appendString:@"product_use_intro.html"];
            break;
        default:
            break;
    }
    _urlStr = mStr.copy;
}

+ (NSString *)InviteFriendUrl {
    NSMutableString *mStr = [NSMutableString stringWithString:@"http://airbike.wrteach.com/h5/html/invite_friend_method.html"];
    if ([AccountManager shareAccountManager].userModel.invitCode.length > 0) {
        [mStr appendFormat:@"?invitcode=%@",GLOBAL_MANAGER.userModel.invitCode];
    }
    return mStr.copy; //邀请好友
}

//点击返回的方法
- (void)backNative {
    //判断是否有上一层H5页面
    if ([self.webView canGoBack]) {
        //如果有则返回
        [self.webView goBack];
        //同时设置返回按钮和关闭按钮为导航栏左边的按钮
        self.navigationItem.leftBarButtonItems = @[self.backItem, self.closeItem];
    } else {
        [self closeNative];
    }
}

#pragma mark - init
- (UIBarButtonItem *)backItem {
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] init];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"imgs_menu_arrow_left"];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backNative) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //字体的多少为btn的大小
        [btn sizeToFit];
        //左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.frame = CGRectMake(0, 0, 45, 40);
        _backItem.customView = btn;
        [self setupNavigatonLeftItemWithTitle:@"返回"];
    }
    return _backItem;
}

- (UIBarButtonItem *)closeItem {
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] init];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"关闭" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 40, 40);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(closeNative) forControlEvents:UIControlEventTouchUpInside];
        _closeItem.customView = btn;
        //        _closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeNative)];
    }
    return _closeItem;
}

//关闭H5页面，直接回到原生页面
- (void)closeNative {
    [self.navigationController popViewControllerAnimated:YES];
}

//添加分享模糊蒙版效果
- (void)addEffectView {
    //    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    //    effectView.frame = CGRectMake(0,0 , [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height);
    //    effectView.alpha = 0.7;
    UIImageView *effectView = [[UIImageView alloc] initWithImage:[UIImage getBlurImge]];
    _effectView = effectView;
    effectView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    effectView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(effectViewTapRecHandle:)];
    tapRec.numberOfTouchesRequired = 1;
    tapRec.numberOfTapsRequired = 1;
    [effectView addGestureRecognizer:tapRec];
    
    ShareView *shareView = self.shareView;
    shareView.width = self.view.width;
    shareView.y = self.view.height ;
    [effectView addSubview:shareView];
    [UIView animateWithDuration:0.2 animations:^{
        shareView.y = self.navigationController.view.height - shareView.height;
    }];
    
    typeof(WKWebViewController *)weakSelf = self;
    self.tapRecHandel = ^(UITapGestureRecognizer *tapRec){
        [UIView animateWithDuration:0.2 animations:^{
            shareView.y = weakSelf.navigationController.view.height;
        } completion:^(BOOL finished) {
            [shareView removeFromSuperview];
            [tapRec.view removeFromSuperview];
        }];
    };
    [GLOBAL_KEYWINDOW addSubview:effectView];
    //    [self.navigationController.view addSubview:effectView];
}

- (void)shareSuccess {
    [self removeEffectView];
}

- (void)removeEffectView {
    [_effectView removeFromSuperview];
}

- (ShareView *)shareView {
    if (!_shareView) {
        _shareView  = [ShareView shareView];
    }
    return _shareView;
}

//- (void)setFinishModel:(ZHHTrackFinishModel *)finishModel {
//    _finishModel  =finishModel;
//    _urlStr = [NSString stringWithFormat:@"%@moveend.html?token=%@&id=%@",basicUrl,GLOBAL_TOKEN,finishModel.cycling_id];
//}

-(void)effectViewTapRecHandle:(UITapGestureRecognizer *)tapRec{
    if (self.tapRecHandel) {
        self.tapRecHandel(tapRec);
    }
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"airbike"];
}
@end
