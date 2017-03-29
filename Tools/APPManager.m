//
//  APPManager.m
//  AirBk
//
//  Created by Damo on 2017/1/20.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "APPManager.h"
//分享
#import <UMSocialCore/UMSocialCore.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import <WXApi.h>
//新浪微博SDK头文件
#import <WeiboSDK.h>
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

//人人SDK头文件
#import <AlipaySDK/AlipaySDK.h>
#import "BaseNC.h"
#import <Bugly/Bugly.h>
#import <SAMKeychain.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation APPManager

+ (instancetype)shareAppManager {
    static APPManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [APPManager new];
    });
    return manager;
}

+ (void)setShareSDK {
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMAPPKEY];
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WEIXINAPPKEY appSecret:UM_WEIXINSECRET redirectURL:@"http://mobile.umeng.com/social"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:UM_QQAPPKEY  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    //新浪
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:UM_SINAAPPKEY appSecret:UM_SINASECRET redirectURL:@"http://mobile.umeng.com/social"];
    
}

+ (void)registerSDKs {
    //高德 IDFA 2、4,证书中设置了推送功能
    [AMapServices sharedServices].apiKey  = AMAPAPPKEY;
    //微信
    [WXApi registerApp:WEIXINAPPKEY];
    //腾讯bugly
    [Bugly startWithAppId:BUGLYAPPID];
}


+ (void)weixinPayWithResp:(BaseResp *)resp {
    //把返回的类型转换成与发送时相对于的返回类型,这里为SendMessageToWXResp
    SendMessageToWXResp *sendResp = (SendMessageToWXResp *)resp;
    
    //使用UIAlertView 显示回调信息
    NSString *str = [NSString stringWithFormat:@"%d",sendResp.errCode];
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"回调信息" message:str delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alertview show];
    
    //微信支付
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！,retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
    }
    NSLog(@"%@",payResoult);
}

+ (void)alipayAfter9WithopenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSString  *code = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
            if([code isEqual:@"9000"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"alipaySuccess" object:nil];
            }
        }];
        
        // 2.0授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSLog(@"memo = %@",resultDic[@"memo"]);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        
        //授权1.0
        if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
        }
    }
}

+ (void)alipayBefore9WithopenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSString  *code = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
            if([code isEqual:@"9000"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"alipaySuccess" object:nil];
            }
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
}
@end
