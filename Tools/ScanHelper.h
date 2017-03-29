//
//  ScanHelper.h
//  Map
//
//  Created by 郑洪浩 on 16/10/11.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
typedef void(^ScanSuccessBlock)(NSString *scanResult);

@interface ScanHelper : NSObject

/**
 扫描二维码工具
 @return 单例模式
 */

/**
 扫描区域的VIew
 */
@property (nonatomic, strong) UIView *scanView;

/**
 扫描成功时执行的块
 */
@property (nonatomic,copy)ScanSuccessBlock scanBlock;

/**
 返回按钮
 */
@property (nonatomic,weak)UIButton *quitBtn;

/**
 类方法

 @return 实例对象
 */
+(instancetype)manager;

/**
 开始扫描
 */
-(void)startRunning;

/**
 停止扫描
 */
-(void)stopRunning;

/**
 设置父视图

 @param superView 父视图
 */
-(void)showLayer:(UIView *)superView;

/**
 设置扫描区域范围和展示扫描的view

 @param scanRect 扫描范围的尺寸
 @param scanView 扫描的视图
 */
-(void)setScaningRect:(CGRect)scanRect scanView:(UIView *)scanView;

-(void)startAnimateScanNetImageView;

@end
