//
//  UnlockingView.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/10/19.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UnlockingViewDelegate <NSObject>

/**
 开锁失败,停止查询开锁状态网路请求的定时器
 */
@optional
-(void)faildLockFinishTimer;

/**
 通知代理,开锁成功
 */
-(void)scanSuccessScanView:(NSString *)deviceId;

@end


@interface UnlockingView : UIView
/**
 创建实例对象的方法
 
 @return 实例对象
 */
+(instancetype)unlockingView;

/**
 代理,需实现UnlockingViewDelegate协议
 */
@property (weak,nonatomic) id <UnlockingViewDelegate>delegate;

/**
 开场动画
 */
-(void)outingBikeAnimate;
-(void)successOpenLock:(NSString *)deviceId;
@end
