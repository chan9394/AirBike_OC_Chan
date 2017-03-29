//
//  AppDelegate.m
//  Mobike
//
//  Created by 郑洪浩 on 16/10/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

//woshihbnbhsdobfosbdfob

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MenuVCRootVC.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
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
#import "APPManager.h"

@interface AppDelegate ()<UINavigationControllerDelegate,WXApiDelegate,CLLocationManagerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //设置导航控制器根控制器
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, GLOBAL_SCREENW, GLOBAL_SCREENH)];
    [self setRootViewController];
    [self setUUID];
    [self.window makeKeyAndVisible];
    [APPManager setShareSDK];
    [APPManager registerSDKs];
    return YES;
}

- (void)setRootViewController {
//    [SAMKeychain deletePasswordForService:@"airbike" account:@"version"];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    // 获取App的版本号
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSString *lastVersion = [SAMKeychain passwordForService:@"airbike" account:@"version"];
    //当前为最新版本
    if ([currentVersion isEqualToString:lastVersion]) {
        MainViewController *vc = [[MainViewController alloc] init];
        BaseNC *nc = [[BaseNC alloc] initWithRootViewController:vc];
        self.window.backgroundColor = [UIColor whiteColor];
        //设置导航控制器为window的根视图
        self.window.rootViewController = nc;
    } else {
        //版本升级
        [SAMKeychain setPassword:currentVersion forService:@"airbike" account:@"version"];
        WKWebViewController *mVC = [WKWebViewController webVCWithTitlt:nil type:WKWebVCTypeLoading nvBarHidden:YES];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor whiteColor];
        //设置导航控制器为window的根视图
        self.window.rootViewController=mVC;
    }
}

- (void)setUUID {
    NSString *string = [AccountManager UUID];
    if (!string) {
        NSString *UUID= [[UIDevice currentDevice].identifierForVendor UUIDString];
        [SAMKeychain setPassword:UUID forService:@"airbike" account:@"UUID"];
    }
}



- (void)onResp:(BaseResp *)resp {
    [APPManager weixinPayWithResp:resp];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
}

#pragma mark - 支付宝回调  -
//支付9.0后的
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        //支付宝部分
        [APPManager alipayAfter9WithopenURL:url];
        //微信部分
        return [WXApi handleOpenURL:url delegate:self];;
        
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];
    }
    return result;

}

#pragma mark -  这个是支付9.0 之前的 -
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {

        BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        //支付宝部分
        [APPManager alipayBefore9WithopenURL:url];
        //微信部分
        return [WXApi handleOpenURL:url delegate:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShareSuccess" object:nil];
    }
    return result;

}

#pragma mark - 微信9.0前的  -
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    //重新扫描
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scanAgain" object:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
