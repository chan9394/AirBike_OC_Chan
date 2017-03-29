//
//  ScanView.h
//  Mobike
//
//  Created by 郑洪浩 on 16/10/18.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>

//根据此参数判断扫描成功之后的操作
typedef enum _resultHandle {
    unlockBike,
    getBikeId
    
}resultHandle ;

@class ScanView;

@protocol ScanViewDelegate <NSObject>

/**
 扫描出的字符串传给代理

 @param result 扫描得到的信息
 */
-(void)unlockResult:(NSString *)result;

/**
 通知代理展示手动输入单车id的vc
 */
-(void)pushInputNumVC;

/**
 将scanView对象和扫描的信息传给代理

 @param scanResult 扫描结果
 @param scan 扫描视图对视
 */
-(void)scanResult:(NSString *)scanResult scanView:(ScanView *)scan;

/**
 点击返回按钮
 */
-(void)clickBackBtn;

- (void)clickBackWithNoAnimaiton;
/**
 扫描成功
 */
-(void)successScan:(NSString *)deviceId;

/**
 开锁成功,停止查询开锁状态网络请求的定时器
 */
-(void)fininshTimer;

/**
 展示弹框提醒

 @param text 弹框的标题
 @param detail 弹框的信息
 */
-(void)showAlertView:(NSString *)text andLabelDetail:(NSString *)detail;

//导航栏返回按钮不可点击
-(void)naviLeftBtnCantClick;

- (void)naviLeftBtnCanClick;
@end

@interface ScanView : UIView

@property(nonatomic,weak)id <ScanViewDelegate> delegate;


/**
 再次扫描
 */
-(void)scanAgain;

/**
 扫描成功,展示动画
 */
-(void)outBikeView:(NSString *)deviceId;

/*
 扫描结果处理的标志
 */
@property (nonatomic, assign)resultHandle result;

-(void)initScan;
/**
 扫描成功,展现开锁中的视图或者将扫描到的信息传给代理

 @param resultStr 扫描的信息
 @param scan 扫描的视图
 */

-(void)scanVCResultStr:(NSString *)resultStr scanView:(ScanView *)scan;
-(void)startAnimateScanNetImageView;
+ (instancetype)scanViewWithFrame:(CGRect)frame;

@end
