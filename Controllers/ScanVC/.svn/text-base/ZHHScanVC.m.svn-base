//
//  ZHHScanVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/10/25.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHInputBikeNumUnlockVC.h"
#import "ZHHScanVC.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ZHHHelpView.h"
#import "MainViewController.h"

@interface ZHHScanVC ()<ScanViewDelegate,ZHHInputBikeNumUnlockVCDelegate>

@property (nonatomic,weak) ScanView *scanView;//扫描的视图
@property (nonatomic,weak) NSTimer  *timer;
@end

@implementation ZHHScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
    [self setNaviItem];
    [self.nvLeftBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scanAgain) name:@"scanAgain" object:nil];
}

- (void)scanAgain {
    if ([APPManager shareAppManager].isTest) {
        [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"进入前台"];
    }
    [self.scanView startAnimateScanNetImageView];
}

- (void)clickBackBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickBackWithNoAnimaiton {
    UIViewController *vc = (UIViewController *)self.delegate;
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.scanView startAnimateScanNetImageView];
}

- (void)setSubView {
    ScanView *view = [ScanView scanViewWithFrame:self.view.bounds];
    view.frame = self.view.bounds;
    self.scanView = view;
    view.frame = self.view.frame;
    view.height = self.view.height-64;
    view.delegate = self;
    [self.view addSubview:view];
}

- (void)setResult:(resultHandle)result {
    _result = result;
    self.scanView.result = result;
    if (result == getBikeId) {
        [self setupTitleWithText:@"扫描获取编码"];
    }
}

- (void)scanResult:(NSString *)res scanView:(ScanView *)scan {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerGo:) userInfo:res repeats:YES];
    
}

- (void)timerGo:(NSTimer *)timer {
    NSString *res = timer.userInfo;
    [NetWorks checkUnlockStateRequestWithDeviecId:res andSuccess:^(id response) {
        [self.timer invalidate];
        self.timer = nil;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkCycleStateTimerGo:) userInfo:res repeats:YES];
    }];
}
     
- (void)checkCycleStateTimerGo:(NSTimer *)timer {
    NSString *res = timer.userInfo;
    [NetWorks finishTrackHttpRequestWithDeviecId:res and:^(id response){
        //骑行中
        if([APPManager shareAppManager].isTest) {
            [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"正在骑行,跳至骑行界面"];
        }
        
        [self.scanView performSelectorOnMainThread:@selector(outBikeView:) withObject:res waitUntilDone:NO];
        [self.timer invalidate];
        self.timer = nil;
        
    } and:nil andHasLogOut:nil];
}
     
- (void)fininshTimer {
    if (self.timer) {
        [self.timer invalidate];
    }
}

- (void)setNaviItem {
    [self setupNavigationRightItemWithImage:@[@"imgs_menu_arrow_left"]];
    [self setupNavigationRightItemWithTitle:@"使用帮助"];
    [self.nvRightBtn addTarget:self action:@selector(clickHelpBtn) forControlEvents:UIControlEventTouchUpInside];
    [self setupTitleWithText:@"扫描开锁"];
    
}

- (void)clickHelpBtn {
    ZHHHelpView *HelpV = [ZHHHelpView helpView];
    HelpV.frame = self.navigationController.view.frame;
    HelpV.transform = CGAffineTransformMakeTranslation(0, -HelpV.height);
    [self.navigationController.view addSubview:HelpV];
    [UIView animateWithDuration:0.3 animations:^{
        HelpV.transform = CGAffineTransformIdentity;
    }];
}

- (void)pushInputNumVC {
    ZHHInputBikeNumUnlockVC *vc = [ZHHInputBikeNumUnlockVC inputBikeNumUnlockVC];
    vc.view.frame = self.view.frame;
    vc.delegate =self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)successScan:(NSString *)deviceId {
    if ([self.delegate respondsToSelector:@selector(successScan:)]) {
        [self.delegate successScan:deviceId];
    }
}

#pragma mark - 手动输入回调  -
- (void)sendInPutBikeId:(NSString *)bkId {
    [self.scanView scanVCResultStr:bkId scanView:self.scanView];
}

- (void)showAlertView:(NSString *)text andLabelDetail:(NSString *)detail {
    if ([self.delegate respondsToSelector:@selector(showAlertView:andLabelDetail:)]) {
        [self.delegate showAlertView:text andLabelDetail:detail];
    }
}

- (void)unlockResult:(NSString *)result {
    if ([self.delegate respondsToSelector:@selector(unlockResult:)]) {
        [self.delegate unlockResult:result];
    }
}

- (void)naviLeftBtnCantClick {
    self.nvLeftBtn.enabled = NO;
}
- (void)naviLeftBtnCanClick {
    self.nvLeftBtn.enabled = YES;
}
- (void)dealloc {
    
}
@end
