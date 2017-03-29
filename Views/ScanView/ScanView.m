//
//  ScanView.m
//  Mobike
//
//  Created by 郑洪浩 on 16/10/18.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ScanView.h"
#import "ScanHelper.h"
#import "UnlockingView.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanView ()<UnlockingViewDelegate>

@property (nonatomic, strong) AVCaptureDevice     *device;
@property(weak,    nonatomic) NSTimer                 *timer;
@property (weak,   nonatomic) IBOutlet UIButton    *lightBtn;
@property(weak,    nonatomic) UnlockingView        *unlockingView;
@property (weak,   nonatomic) IBOutlet UILabel      *tipLable;

@end

@implementation ScanView

- (AVCaptureDevice *)device {
    if (_device==nil) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

+ (instancetype)scanViewWithFrame:(CGRect)frame{
    ScanView *view = [[NSBundle mainBundle] loadNibNamed:@"ScanView" owner:nil options:nil].firstObject;
    view.frame = frame;
    [view initScan];
    return view;
}

- (void)setResult:(resultHandle)result {
    _result = result;
    if (self.result == getBikeId) {
        self.tipLable.text = @"对准车上二维码\n扫码失败时请用输入编号方式";
    }else{
        self.tipLable.text = @"对准车上二维码\n扫码失败时请用输入编号方式开锁";
    }
}

#pragma mark -   - 重新扫描
- (void)scanAgain {
    [[ScanHelper manager] startRunning];
}


- (void)initScan {
    CGSize scanSize = CGSizeMake(self.width*3/5, self.width*3/5);
    CGRect scanRect = CGRectMake((self.width - scanSize.width)/2, (self.height-scanSize.height) / 2 - 64, scanSize.width, scanSize.height);
    UIView *scanRectView = [UIView new];
    [[ScanHelper manager] showLayer:self];
    [[ScanHelper manager] setScaningRect:scanRect scanView:scanRectView];
    [[ScanHelper manager] setScanBlock:^(NSString *scanResult){
    //扫描成功,将数据传出,退出scanView
        [self scanVCResultStr:scanResult scanView:self];
    }];
    [[ScanHelper manager] startRunning];
}

- (void)scanVCResultStr:(NSString *)resultStr scanView:(ScanView *)scan {
    if (self.result==unlockBike) {
        [NetWorks unlockBikeWithDeviceId:resultStr failed:^{
            [self scanAgain];
            return ;
        } andSuccess:^(id response) {
            [GLOBAL_MANAGER modelWIthJSON:response];
            if ([self.delegate respondsToSelector:@selector(naviLeftBtnCantClick)]) {
                [self.delegate naviLeftBtnCantClick];
            }
            //            展现解锁视图
            UnlockingView *unlockingView = [UnlockingView unlockingView];
            unlockingView.backgroundColor = [UIColor darkGrayColor];
            unlockingView.delegate =self;
            self.unlockingView = unlockingView;
            CGFloat x = 0;
            CGFloat y = 0;
            CGFloat width = self.width;
            CGFloat height = self.height ;
            unlockingView.frame = CGRectMake(x, y, width, height);
            [self addSubview:unlockingView];
            [self sendUrlRequest:resultStr];
        }];
    } else {
        [self.delegate clickBackWithNoAnimaiton];
        if ([self.delegate respondsToSelector:@selector(unlockResult:)]) {
            [self.delegate unlockResult:resultStr];
        }
    }
}

- (void)popscanVc{
    if ([self.delegate respondsToSelector:@selector(clickBackBtn)]) {
        [self.delegate clickBackBtn];
    }
}

//发送确认开锁请求
- (void)sendUrlRequest:(NSString *)res {
    if ([self.delegate respondsToSelector:@selector(scanResult:scanView:)]) {
        [self.delegate scanResult:res scanView:self];
    }
}

- (void)removeFromSuperview {
    if (self.lightBtn.selected) {
        [self.device lockForConfiguration:nil];
        [_device setTorchMode:AVCaptureTorchModeOff];
        [_device unlockForConfiguration];
        [super removeFromSuperview];
    }
    
    if (self.timer) {
        [self.timer invalidate];
    }
    [super removeFromSuperview];
}

//开锁成功
- (void)scanSuccessScanView:(NSString *)deviceId {
    if ([self.delegate respondsToSelector:@selector(successScan:)]) {
        [self.delegate successScan:deviceId];
        if ([self.delegate respondsToSelector:@selector(showAlertView:andLabelDetail:)]) {
            [self.delegate showAlertView:@"解锁成功" andLabelDetail:@"请将AirPower移动电源插入尾箱插槽,可开启电力驱动"];
        }
    }
    
    if([self.delegate respondsToSelector:@selector(clickBackBtn)]){
        [self.delegate clickBackBtn];
    }
}

//进入手动开锁控制器
- (IBAction)pushtoInputNumVC:(UIButton *)sender {
    if ( [self.delegate respondsToSelector:@selector(pushInputNumVC)]) {
        [self.delegate pushInputNumVC];
    }
}

//打开手电
- (IBAction)clickFlashBtn:(UIButton *)sender {
    if (![self.device hasTorch]) {
        NSLog(@"手电筒坏了");
        return;
    }
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.device lockForConfiguration:nil];
        [_device setTorchMode:AVCaptureTorchModeOn];
        [_device unlockForConfiguration];
    } else {
        //关闭手电筒
        [self.device lockForConfiguration:nil];
        [_device setTorchMode:AVCaptureTorchModeOff];
        [_device unlockForConfiguration];
    }
}

- (void)outBikeView:(NSString *)deviceId {
    [self.unlockingView successOpenLock:deviceId];
}

- (void)faildLockFinishTimer {
    [HHProgressHUD showHUDInView:self animated:YES withText:@"开锁失败,请重新扫描"];
    [self.delegate fininshTimer];
    [self.delegate naviLeftBtnCanClick];
    [self scanAgain];
}

- (void)startAnimateScanNetImageView {
    [[ScanHelper manager] startAnimateScanNetImageView];
}


@end
