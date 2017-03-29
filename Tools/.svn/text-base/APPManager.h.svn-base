//
//  APPManager.h
//  AirBk
//
//  Created by Damo on 2017/1/20.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseResp;

@interface APPManager : NSObject

@property (nonatomic, assign) BOOL isTest;


+ (instancetype)shareAppManager;

//友盟
+ (void)setShareSDK;

//注册高德,微信,bugly,JSPatch
+ (void)registerSDKs;

//微信支付回调
+ (void)weixinPayWithResp:(BaseResp *)resp;

//支付宝支付9.0之后
+ (void)alipayAfter9WithopenURL:(NSURL *)url;

//支付宝支付9.0之前
+ (void)alipayBefore9WithopenURL:(NSURL *)url;

@end
