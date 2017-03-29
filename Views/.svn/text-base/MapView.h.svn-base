//
//  MainView.h
//  Mobike
//
//  Created by 郑洪浩 on 16/10/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapView;
@class ScanView,ZHHTrackFinishModel;

@protocol MainViewDelegate <NSObject>

//点击菜单按钮
- (void)clickBarLeftBtn;
- (void)pushAlertVC;
- (void)pushScanVC;
- (void)pushBikingResultVC:(ZHHTrackFinishModel *)model;
- (void)pushDepositVC; //押金充值
- (void)pushRealNameVC;
- (void)mainView:(MapView *)mainView didClickProductIntoBtn:(UIButton *)button;
- (void)pushLoclkFailedVC;
- (void)showHowToLockView;
- (void)showAlertView:(NSString *)text andLabelDetail:(NSString *)detail;

@end

@interface MapView : UIView

@property (weak,nonatomic) id<MainViewDelegate> delegate;

 //创建mapView实例
+ (instancetype)mapView;

//初始化流动的图标
- (void)initRedWaterView;

//扫描成功
- (void)scanSuccesssScanView:(NSString *)deviceId;

//恢复取消预约界面
- (void)recoverCancleOrderViewWithDeviceId:(NSString *)deviceId seconds:(NSNumber *)seconds;

//刷新单车位置
- (void)refreshBikeLocation;

//展示使用提醒
-(void)showHelpHint;

- (IBAction)clickScan2DBbtn:(UIButton *)sender;
@end
;  
