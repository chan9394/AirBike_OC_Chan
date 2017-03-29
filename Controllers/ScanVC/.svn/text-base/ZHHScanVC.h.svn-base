//
//  ZHHScanVC.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/10/25.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanView.h"


@protocol ZHHScanVCDelegate <NSObject>

@optional
-(void)scanVCResultStr:(NSString *)resultStr scanView:(ScanView *)scan;
-(void)showAlertView:(NSString *)text andLabelDetail:(NSString *)detail;
-(void)popScanVC;
-(void)successScan:(NSString *)deviceId;
-(void)unlockResult:(NSString *)result;
@end


@interface ZHHScanVC : BaseVC

@property(nonatomic,weak) id<ZHHScanVCDelegate> delegate;
@property (nonatomic, assign)resultHandle result;//扫描结果处理的标志

@end
