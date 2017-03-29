//
//  MainViewController.m
//  Mobike
//
//  Created by 郑洪浩 on 16/10/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//
#import "MainViewController.h"
#import "MapView.h"
#import "MenuVCRootVC.h"
#import "UnlockingView.h"
#import "ZHHBikingResultVCView.h"
#import "ZHHCustomServeVC.h"
#import "ZHHReportDisobeyVC.h"
#import "ZHHScanVC.h"
#import "ZHHSearchTVC.h"
#import "ZHHDepositVC.h"
#import "ZHHScanSuccessView.h"
#import "ZHHRealNameVC.h"
#import "ReminderView.h"
#import "LockFailedCustVC.h"
#import "NoNetworkVC.h"
#import "ZHHPublicTVC.h"
#import "ZHHRechargeWalletVC.h"
#import "MenuLoginTC.h"
#import "ShareView.h"
#import "RegisterSuccess.h"
#import "ZHHTrackFinishModel.h"

@interface MainViewController ()<MainViewDelegate,UnlockingViewDelegate,ZHHScanVCDelegate,UnlockingViewDelegate,ReminderViewDelegate>

@property (nonatomic, weak) MenuVCRootVC            *menuVC;
@property (nonatomic, weak) MapView                 *mainview;
@property(weak,  nonatomic) ScanView                *scanV;
@property (nonatomic, weak) AccountManager          *manager;
@property (nonatomic, weak) NoNetworkVC             *noNetworkVC;
@property (weak, nonatomic) UIImageView             *helpHintPic;       //使用提醒
@property (weak, nonatomic) UIButton                *helpHintSkipBtn;   //跳过使用提醒
@property (weak, nonatomic) UIButton                *helpHintScanBtn;   //使用提醒扫描
@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //获取用户信息
    [self recoverShadow];
    [NetWorks getUserInfoDetailSuccessGet:^(id response) {
        AccountManager *manager = [AccountManager shareAccountManager];
        [manager modelWIthJSON:response];
    } pushRegisterVC:NO];
    
    //判断是否显示操作提醒
    [self judgeHelpHintShow];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //是否需要刷新个人数据的flag,改变账户类的信息设置
    GLOBAL_ISREGFRESH = YES;
    
    MapView *view = [MapView mapView];
    view.delegate = self;
    self.mainview = view;
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    [view initRedWaterView]; 
    [self.view addSubview:view];
    
    //设置导航栏
    [self setNaviBar];
    //判断网络状况
    [self judgeNetwork];
    //充值成功进入扫码
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushScanVC) name:@"goToScan" object:nil];
    //关锁后未计费
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushLoclkFailedVC) name:@"lockFailed" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

//判断是否显示操作提醒
-(void)judgeHelpHintShow{
    BOOL firstUseShowProduct = [[NSUserDefaults standardUserDefaults] boolForKey:@"firstUseShowProduct"];
    if (!firstUseShowProduct) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstUseShowProduct"];
        UIView *contView = [[UIView alloc] initWithFrame:GLOBAL_KEYWINDOW.frame];
        
        UIScrollView *viewScr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, GLOBAL_KEYWINDOW.width, GLOBAL_KEYWINDOW.height)];
        viewScr.contentSize = CGSizeMake(GLOBAL_KEYWINDOW.width * 3, GLOBAL_KEYWINDOW.height);
        viewScr.pagingEnabled = YES;
        viewScr.bouncesZoom = NO;
        viewScr.bounces = NO;
        viewScr.scrollEnabled = NO;
        
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHelpScanBtn:)];
        tapG.numberOfTapsRequired = 1;
        tapG.numberOfTouchesRequired = 1;
        [viewScr addGestureRecognizer:tapG];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        self.helpHintPic = imgView;
        imgView.frame = GLOBAL_KEYWINDOW.frame;
        imgView.userInteractionEnabled = YES;
        UIImage *picImg = [UIImage imageNamed:@"imgs_main_hint"];
        imgView.image = picImg;
        [viewScr addSubview:imgView];
        
        
        UIImageView *imgView2 = [[UIImageView alloc] init];
        self.helpHintPic = imgView2;
        imgView2.frame = CGRectMake(GLOBAL_KEYWINDOW.width, 0, GLOBAL_KEYWINDOW.width, GLOBAL_KEYWINDOW.height);
        imgView2.userInteractionEnabled = YES;
        UIImage *picImg2 = [UIImage imageNamed:@"imgs_login_helpPic"];
        imgView2.image = picImg2;
        [viewScr addSubview:imgView2];
        
        UIImageView *imgView3 = [[UIImageView alloc] init];
        self.helpHintPic = imgView3;
        imgView3.frame = CGRectMake(GLOBAL_KEYWINDOW.width*2, 0, GLOBAL_KEYWINDOW.width, GLOBAL_KEYWINDOW.height);
        imgView3.userInteractionEnabled = YES;
        UIImage *picImg3 = [UIImage imageNamed:@"imgs_main_useHintProduct"];
        imgView3.image = picImg3;
        [viewScr addSubview:imgView3];
//        imgs_main_useHintProduct
        float xwidith = GLOBAL_H(143);
        float xheight = xwidith*6/13;
        float xx = (GLOBAL_KEYWINDOW.width - xwidith) * 0.5;
        float xy = GLOBAL_KEYWINDOW.height - xheight - 8;
        UIButton *IkonwButton = [[UIButton alloc] initWithFrame:CGRectMake(xx, xy, xwidith, xheight)];
        UIImage *Ikonwimgage = [UIImage imageNamed:@"imgs_main_useHintIKnow"];
        [IkonwButton setImage:Ikonwimgage forState:UIControlStateNormal];
        [IkonwButton addTarget:self action:@selector(skipHelpHint:) forControlEvents:UIControlEventTouchUpInside];
        [imgView3 addSubview:IkonwButton];
        
        [contView addSubview:viewScr];
        float height = 30;
        float widith = 46;
        float x = GLOBAL_KEYWINDOW.width - widith - 10;
        float y = 25;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, widith, height)];
        [button setTitle:@"跳过" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button addTarget:self action:@selector(skipHelpHint:) forControlEvents:UIControlEventTouchUpInside];
        self.helpHintSkipBtn = button;
        [contView addSubview:button];
        [self.navigationController.view addSubview:contView];

    }
}

-(void)skipHelpHint:(UIButton *)sender{
    if ([sender.superview isKindOfClass:[UIImageView class]]) {
        [sender.superview.superview.superview
         removeFromSuperview];
    }else{
        [sender.superview removeFromSuperview];
    }
    
}

-(void)clickHelpScanBtn:(UITapGestureRecognizer *)sender{
    UIScrollView *scrollView;
    scrollView = (UIScrollView *)((UITapGestureRecognizer *)sender).view;
    
    CGPoint curPoint = scrollView.contentOffset;
    if (curPoint.x<GLOBAL_KEYWINDOW.width*2) {
        [scrollView setContentOffset:CGPointMake(curPoint.x+GLOBAL_KEYWINDOW.width, 0) animated:YES];
    }
    
}


- (void)queryRidingStatus {
    //查询状态:0-默认 1-骑行 2-预约
    [NetWorks statusqueryWithSuccessBlock:^(id response) {
        
        [[AccountManager shareAccountManager].statusModel modelWIthJSON:response[@"result"]];
//        NSLog(@"%@",[[AccountManager shareAccountManager].statusModel propertiesValues]);
        RidingStatusModel *statusModel = [AccountManager shareAccountManager].statusModel;
        if ([statusModel.ridingStatus isEqualToString:@"1"]) {
            [self successScan:statusModel.lockId];
        }
        if ([statusModel.ridingStatus isEqualToString:@"2"]) {
            [self.mainview recoverCancleOrderViewWithDeviceId:statusModel.lockId seconds:statusModel.seconds];
        }
    }];
}


#pragma mark -  设置导航栏 -
- (void)setNaviBar{
    [self setupNavigationItemWithLeftImages:@[@"imgs_main_menu"] rightimages:@[@"imgs_main_search"]];
    [self.nvLeftBtn addTarget:self action:@selector(clickBarLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.nvRightBtn addTarget:self action:@selector(clickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    [self setupTitleViewWithImage:@"imgs_main_logo2"];
}

#pragma mark - 判断网络  -
- (void)judgeNetwork {
    __weak typeof(self) weakSelf = self;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变时调用
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                GLOBAL_ISREGFRESH = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [weakSelf pushNoNetworkVIewController];
                GLOBAL_ISREGFRESH = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                if (weakSelf.noNetworkVC) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
                if (GLOBAL_ISREGFRESH) {
                    [self.mainview refreshBikeLocation];
                    [NetWorks getUserInfoDetailSuccessGet:^(id response) {
                        AccountManager *manager = [AccountManager shareAccountManager];
                        [manager modelWIthJSON:response];
                    } pushRegisterVC:NO];
                    [self queryRidingStatus];
                }
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
    //    NSLog(@"%ld",(long)manager.networkReachabilityStatus);
    //    if (manager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
    //        [self pushNoNetworkVIewController];
    //    }
}

#pragma mark - 押金充值界面 -
- (void)pushDepositVC{
    static NSString *message = nil;
    
    if (![self.manager hasDeposit]) {
        message = @"押金不足";
    } else if (![self.manager hasBalance]) {
        message = @"余额不足";
    }

    __weak typeof(self)weakSelf = self;
    ReminderView *reminderView = [ReminderView reminderViewWithtitle:message titleColor:GLOBAL_ASSISTCOLOR detail:nil imageName:@"imgs_main_money" leftBtnTitle:@"前往充值" leftBtnColor:[UIColor darkGrayColor]  leftBlock:^{
        if (![weakSelf.manager hasDeposit]) {
            [weakSelf pushDespoitViewController];
        } else if (![self.manager hasBalance]) {
            [weakSelf pushRechargeWalletViewController];
        }
    } rightBtnTitle:@"取消" rightBtnColor:GLOBAL_CONTENTCOLOR rightBlock:nil];
    [[UIApplication sharedApplication].keyWindow addSubview:reminderView];
}

#pragma mark - 产品说明  -
- (void)mainView:(MapView *)mainView didClickProductIntoBtn:(UIButton *)button {
    [self pushProducIntoWebViewController];
}

#pragma mark - 扫描成功  -
- (void)successScan:(NSString *)deviceId{
    [self.mainview scanSuccesssScanView:deviceId];
}

- (void)showHowToLockView{
    [self showAlertView:@"如何关锁" andLabelDetail:@"手动关锁完成还车,结束计费\n(计费受网络影响,稍等即可)"];
}

- (void)showAlertView:(NSString *)text andLabelDetail:(NSString *)detail{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0,0 , [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height);
    effectView.alpha = 0.4;
    [[UIApplication sharedApplication].keyWindow addSubview:effectView];
    
    ZHHScanSuccessView *view = [ZHHScanSuccessView scanSuccessViewPushedLabel:text andLabelDetail:detail];
    view.effectView = effectView;
    view.frame = self.view.frame;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

#pragma mark - 客服  -
-(void)pushAlertVC{
    UIAlertController *alertViewVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"使用说明" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WKWebViewController *vc = [[WKWebViewController alloc] init];
        vc.nvTitle = @"使用说明";
        vc.type =  WKWebVCTypePlayIntro;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [alertViewVC addAction:action3];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"违规举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ZHHReportDisobeyVC *vc = [[ZHHReportDisobeyVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [alertViewVC addAction:action];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"用户指南" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ZHHPublicTVC *tvc = [[ZHHPublicTVC alloc] init];
        tvc.type = PublicTypeGuide;
        [self.navigationController pushViewController:tvc animated:YES];
    }];
    [alertViewVC addAction:action1];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertViewVC addAction:action2];
    
    [self presentViewController:alertViewVC animated:YES completion:nil];
}

#pragma mark - 控制器跳转  -
//产品使用说明
- (void)pushProducIntoWebViewController {
    WKWebViewController *webvc = [WKWebViewController webVCWithTitlt:GLOBAL_STR(@"产品说明") type: WKWebVCTypeProductIntro];
    [self.navigationController pushViewController:webvc animated:YES];
}


//关锁后未计费
-(void)pushLoclkFailedVC{
    LockFailedCustVC *vc = [[LockFailedCustVC alloc] init];
    vc.view.frame = self.view.frame;
    [self.navigationController pushViewController:vc animated:YES];
}

//无网络页面
- (void)pushNoNetworkVIewController {
    NoNetworkVC *vc = [[NoNetworkVC alloc] init];
    self.noNetworkVC = vc;
    [self.navigationController pushViewController:vc animated:YES];
}

// 进入押金充值界面
- (void)pushDespoitViewController {
    ZHHDepositVC *vc = [[ZHHDepositVC alloc] init];
    vc.view.frame = self.view.frame;
    [self.navigationController pushViewController:vc animated:YES];
}

//车费充值
- (void)pushRechargeWalletViewController {
    ZHHRechargeWalletVC *vc = [[ZHHRechargeWalletVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//搜索
- (void)clickSearchBtn{
    ZHHSearchTVC *tvc = [[ZHHSearchTVC alloc] init];
    tvc.view.frame = self.view.frame;
    [self.navigationController pushViewController:tvc animated:YES];
}

//实名
-(void)pushRealNameVC{
    ZHHRealNameVC *vc = [[ZHHRealNameVC alloc] init];
    vc.view.frame = self.view.frame;
    [self.navigationController pushViewController:vc animated:YES];
}

//个人中心
- (void)clickBarLeftBtn{
    if ([AccountManager token]) {
        MenuVCRootVC *rootVC = [[MenuVCRootVC alloc] initWithStyle:UITableViewStyleGrouped];
        rootVC.view.frame = self.view.frame;
        [self.navigationController pushViewController:rootVC animated:YES];
    } else {
        MenuLoginTC *TC = [[MenuLoginTC alloc] init];
        [self.navigationController pushViewController:TC animated:YES];
    }
}

// 扫码
-(void)pushScanVC{
    [self.navigationController popToRootViewControllerAnimated:NO];
    ZHHScanVC *scanVc = [[ZHHScanVC alloc] init];
    scanVc.result = unlockBike;
    scanVc.view.frame = self.view.frame;
    scanVc.delegate = self;
    [self.navigationController pushViewController:scanVc animated:YES];
}

//骑行结束
- (void)pushBikingResultVC:(ZHHTrackFinishModel *) model {
    if ([APPManager shareAppManager].isTest) {
        [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:model.cycling_id];
    }
    WKWebViewController *vc= [[WKWebViewController alloc] initWithTitle:@"" type:WKWebVCTypeMoveEnd cycleID:model.cycling_id];
    vc.nvRightTitle = @"分享";
    vc.nvRightBtn.hidden = YES;
    __weak typeof(vc) weakvc = vc;
    
    vc.rightBlock = ^(){
        [weakvc addEffectView];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (AccountManager *)manager {
    return [AccountManager shareAccountManager];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
