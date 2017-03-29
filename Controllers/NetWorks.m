//
//  NetWorks.m
//  AirBk
//
//  Created by 郑洪浩 on 2017/1/3.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "NetWorks.h"
#import "ZHHScanSuccessView.h"
#import "MapLoadingView.h"
#import "ZHHReisterLogOnVC.h"
#import "RefreshView.h"


NSString *const PublicTVCHasLogOutNotification = @"PublicTVCHasLogOutNotification";

@interface NetWorks()

@property (nonatomic, weak)MapLoadingView *routeLoadingView;//加载视图

@end

@implementation NetWorks

+ (BOOL)isTest {
    return [APPManager shareAppManager].isTest;
}

+ (void)parametersHasNil {
    UINavigationController *nvc = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    ZHHReisterLogOnVC *vc = [[ZHHReisterLogOnVC alloc] init];
    
    vc.clickNavLeftBtnHandle = ^(){
        [nvc popViewControllerAnimated:YES];
    };
    [nvc pushViewController:vc animated:YES];
}

+ (RefreshView *)showLoadingView{
    UIView *subView = [GLOBAL_KEYWINDOW viewWithTag:100];
    if (subView) {
        return (RefreshView *)subView;
    }
    
    RefreshView *view = [RefreshView shareRefreshView];
    //    RefreshView *view = [RefreshView new];
    [GLOBAL_KEYWINDOW addSubview:view];
    return view;
    
}

#pragma mark -   - 预约单车
+ (void)orderBikeNetWorkWithDeviceId:(NSString *)deviceId andSuccessed:(void(^)(id response)) success {
    NSString *token = [AccountManager token];
    NSString *device_id = deviceId;
    NSString *checksum = [[NSString stringWithFormat:@"%@%@%@",token,device_id,@"AIRBIKESALT"] encodeMd5];
    
    if (!(token&&device_id&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"device_id":device_id,
                          @"checksum":checksum
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/bikes/booking" parameters:dic finished:^(id response, NSError *error) {
        
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"预约" andCaseN5:^{
            [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"预约失败" andDetailText:@"正在使用中，不可预约"];
        } andCaseN4:^{
            [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"预约失败" andDetailText:@"已被预约"];
        } andCase1:^{
            [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"预约成功"];
            success(response);
        } andCase2:^{
        }];
    }];
}

#pragma mark - 取消预约单车  -
+ (void)cancleOrderBikeNetWorkWithDeviceId:(NSString *)deviceId andSuccessed:(void (^)(id))success {
    NSString *token = [AccountManager token];
    NSString *device_id = deviceId;
    NSString *checksum = [[NSString stringWithFormat:@"%@%@%@",token,device_id,@"AIRBIKESALT"] encodeMd5];
    if (!(token&&device_id&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"device_id":device_id,
                          @"checksum":checksum
                          };
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/bikes/bookingcancel" parameters:dic finished:^(id response, NSError *error) {
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        
        [self caseWithStatus:status andMessage:message andWorkName:@"取消预约单车" andCaseN10:nil andCaseN9:nil andCaseN8:^{
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"预约已取消"];
            success(response);
        } andCaseN7:nil andCaseN6:^{
            
        } andCaseN5:nil andCaseN4:nil andCaseN3:nil andCaseN2:nil andCaseN1:nil andCase0:nil andCase1:^{
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"预约已取消"];
            success(response);
        } andCase2:nil];
    }];
}

#pragma mark - 查询骑行状态  -
+ (void)finishTrackHttpRequestWithDeviecId:(NSString *)deviceId and:(void(^)(id response)) isRiding and:(void(^)(id response))successFinish andHasLogOut:(void(^)())logOut {
    NSString *token = [AccountManager token];
    NSString *device_id = deviceId;
    NSString *serial = GLOBAL_MANAGER.bikeSerial ? GLOBAL_MANAGER.bikeSerial : GLOBAL_MANAGER.statusModel.serialNo;
    NSString *checksum = [[NSString stringWithFormat:@"%@%@%@AIRBIKESALT",token,device_id,serial] encodeMd5];
    
    if (!(token&&device_id&&checksum)) {
        if (!token) {
            [NetWorks parametersHasNil];
        }
        logOut();
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"device_id":device_id,
                          @"serial_no" : serial,
                          @"checksum":checksum
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/bikes/getcyclingstatus" parameters:dic finished:^(id response, NSError *error) {
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"骑行状态查询" andCaseN5:^{
            if([self isTest]){
                [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"查询失败"];
            }
        } andCaseN4:^{
            [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"车锁id不存在"];
        } andCase1:^{
            isRiding(response);
        } andCase2:^{
            GLOBAL_ISREGFRESH = YES;
            GLOBAL_MANAGER.bikeSerial = nil;
            successFinish(response);
        }];
    }];
}

#pragma mark - 查询附近单车列表  -
+ (void)getBikeNerabyListWithCoordinate2D:(CLLocationCoordinate2D)location andSuccessGetList:(void (^)(id))success{
    if (!location.latitude) {
        [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"未查询到位置"];
    }
    
    NSString *token = @"airbike-token";
    NSString *longitude =[NSString stringWithFormat:@"%f",location.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f",location.latitude];
    NSString *checksum = [NSString stringWithFormat:@"%@%@%@%@",token,longitude,latitude,AirBike_Salt];
    
    if (!(token&&longitude&&latitude&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"longitude":longitude,
                          @"latitude":latitude,
                          @"checksum":[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/bikes/getlist" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            if ([self isTest] ) {
                [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"查询附近单车列表"  andDetailText:@"查询附近单车,网络问题"];
            }
            return ;
        }
        NSString *message = response[@"message"];
        NSInteger status = [response[@"status"] integerValue];
        [self caseWithStatus:status andMessage:message  andWorkName:@"查询附近单车" andCase1:^{
            success(response);
        } andCaseN2:^{
            if ([self isTest]) {
                [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"查询附近单车列表"  andDetailText:@"没有找到所在经纬度的周边九宫格区域信息"];
            }
        } andCaseN1:^{
            if ([self isTest]) {
                [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"查询附近单车列表"  andDetailText:@"没有找到所在经纬度的区域信"];
            }
        } ];
    }];
}

#pragma mark - 获取骑行列表  -
+ (void)getCyclingListResultSuccessGetList:(void (^)(id))success {
    NSString *token = [AccountManager token];
    NSString *checksum = [[NSString stringWithFormat:@"%@AIRBIKESALT",token] encodeMd5];
    
    if (!(token&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"checksum":checksum
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/cyclinglist" parameters:dic finished:^(id response, NSError *error) {
        if (!error) {
            if ([self isTest]) {
                [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"获取骑行记录列表成功"];
            }
            NSString *message = response[@"message"];
            NSInteger status = [response[@"status"] integerValue];
            [self caseWithStatus:status andMessage:message  andWorkName:@"获取骑行列表" andCase1:^{
                success(response);
            }];
        }
    }];
}

#pragma mark - 获取用户信息  -
+ (void)getUserInfoDetailSuccessGet:(void (^)(id))success pushRegisterVC:(BOOL)shouldPush{
    NSString *token = [AccountManager token];
    
    if (GLOBAL_ISREGFRESH == NO) {
        return;
    }

    NSString *checksum = [[NSString stringWithFormat:@"%@AIRBIKESALT",token] encodeMd5];
    if (!(token&&checksum)) {

        return;
    }

//    RefreshView *view = [self showLoadingView];
    NSDictionary *dic = @{
                          @"token":token,
                          @"checksum":checksum
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/getuser" parameters:dic finished:^(id response, NSError *error) {
//        [view removeFromSuperview];
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"获取用户信息" andCase1:^{
            success(response);
            GLOBAL_ISREGFRESH = NO;
        } andCaseN2:^{
            [[AccountManager shareAccountManager] quit];

            [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"登录过期,请重新登录"];
        } andCaseN1:nil];
    }];
}


#pragma mark -  开锁 -
+ (void)unlockBikeWithDeviceId:(NSString *)adevice_id failed:(void (^)())failed andSuccess:(void (^)(id))success {
    NSString *token = [AccountManager token];
    NSString *device_id = adevice_id;
    NSString *checksum = [NSString stringWithFormat:@"%@%@%@",token,device_id,AirBike_Salt];
    
    if (!(token&&device_id&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token ,
                          @"device_id":device_id,
                          @"checksum":[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/bikes/unlock" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            failed();
            
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"开锁" andCaseN10:^{
            ZHHScanSuccessView *view = [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"开锁失败"  andDetailText:message];
            view.failed = failed;
        }andCaseN9:nil  andCaseN8:^{
            ZHHScanSuccessView *view = [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"开锁失败"  andDetailText:message];
            view.failed = failed;
        }andCaseN7:^{
            ZHHScanSuccessView *view = [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"开锁失败"  andDetailText: message];
            view.failed = failed;
        }andCaseN6:^{
            ZHHScanSuccessView *view = [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"开锁失败"  andDetailText: @"可用余额不够"];
            view.failed = failed;
            
        }andCaseN5:^{
            ZHHScanSuccessView *view =[ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"开锁失败"  andDetailText:@"请检查下编号是否正确"];
            view.failed = failed;;
            
        } andCaseN4:^{
            ZHHScanSuccessView *view =[ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"开锁失败"  andDetailText:@"车锁状态不可用"];
            view.failed = failed;;
            
        } andCaseN3:^{
            ZHHScanSuccessView *view = [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"开锁失败"  andDetailText:message];
            view.failed = failed;
        } andCaseN2:^{
            ZHHScanSuccessView *view = [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"开锁失败"  andDetailText:message];
            view.failed = failed;
        } andCaseN1:^{
            ZHHScanSuccessView *view = [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"开锁失败"  andDetailText:message];
            view.failed = failed;
        } andCase0:^{
            ZHHScanSuccessView *view = [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"开锁失败"  andDetailText:message];
            view.failed = failed;
        } andCase1:^{
            if (message.length >1) {
                [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:message];
            }
            success(response);
        } andCase2:^{
            ZHHScanSuccessView *view = [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"开锁失败"  andDetailText:message];
            view.failed = failed;
        }];
    }];
    
}

#pragma mark - 查询锁状态  -
+ (void)checkUnlockStateRequestWithDeviecId:(NSString *)deviceId andSuccess:(void (^)(id))success {
    
    NSString *token = [AccountManager token];
    NSString *device_id = deviceId;
    NSString *checksum = [NSString stringWithFormat:@"%@%@%@",token,device_id,AirBike_Salt];
    
    if (!(token&&device_id&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token ,
                          @"device_id":device_id,
                          @"checksum":[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/bikes/checkunlockresult" parameters:dic finished:^(id response, NSError *error) {
        
        if (error) {
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"开锁失败,网络问题"];
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"查询开锁" andCaseN10:nil andCaseN9:nil  andCaseN8:nil andCaseN7:^{
            
        } andCaseN6:^{
            
        } andCaseN5:^{
            
        } andCaseN4:^{
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"车锁设备ID不存在"];
        } andCaseN3:^{
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"用户未认证"];
        } andCaseN2:^{
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"TOKEN失效"];
        } andCaseN1:^{
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"用户不存在"];
        } andCase0:^{
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"请求不合法！"];
        } andCase1:^{
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"已开锁！"];
            success(response);
        } andCase2:^{
            if([self isTest]) {
                [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"未开锁"];
            }
            success(response);
        }];
        
    }];
}

#pragma mark - 上传图片  -
+ (void)changeHeadImg:(NSString *)pic andSuccess:(void (^)(id))success {
    NSString *token = [AccountManager token];
    NSString *head_image = pic;
    NSString *checksum = [NSString stringWithFormat:@"%@%@",token,AirBike_Salt];
    
    if (!(token&&head_image&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"head_image":head_image,
                          @"checksum":[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/headimage" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"上传照片,网络问题"];
            return ;
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"上传照片" andCase1:^{
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"更改照片成功"];
            GLOBAL_ISREGFRESH = YES;
            success(response);
        }];
    }];
}

#pragma mark - 更改昵称  -
+ (void)changeNickNameNetWorkWithNickName:(NSString *)nickName andSuccess:(void (^)(id))success {
    NSString *token = [AccountManager token];
    NSString *nick_name = nickName;
    NSString *checksum = [NSString stringWithFormat:@"%@%@%@",token,nick_name,AirBike_Salt];
    if (!(token&&nick_name&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"nick_name":nick_name,
                          @"checksum":[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/nickname" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"网络故障"];
            return ;
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"更改昵称" andCase1:^{
            GLOBAL_ISREGFRESH = YES;
            success(response);
        }];
    }];
}

#pragma mark - 更改手机号  -
+ (void)changePhoneNumNetWorkWithPhoneN:(NSString *)num andVariNum:(NSString *)varN andSuccess:(void (^)(id))success {
    NSString *token = [AccountManager token];
    NSString *mobile = num;
    NSString *code = varN;
    NSString *checksum = [NSString stringWithFormat:@"%@%@%@%@",token,mobile,code,AirBike_Salt];
    if (!(token&&mobile&&code&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"mobile":mobile,
                          @"code":code,
                          @"checksum":[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/mobile" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"更改手机号失败"];
            return ;
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        
        [self handleWithStatus:status message:message successStatus:@1 successBlock:^{
            GLOBAL_ISREGFRESH = YES;
            if (success) {
                success(response);
            }
        }];
    }];
}

#pragma mark - 填写邮寄地址  -
+ (void)postAddreBateForUser:(NSString *)name andAdr:(NSString *)addr andGeoAddr:(NSString *)geoAddr andPhoN:(NSString *)pNum andFailed:(void (^)())failed andSuccess:(void (^)(id))success {
    NSString *token = [AccountManager token];
    NSString *post_name = name;
    NSString *post_address = addr;
    NSString *post_mobile = pNum;
    NSString *checksum = [NSString stringWithFormat:@"%@%@%@%@%@",token,post_name,post_address,post_mobile,AirBike_Salt];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    //获取编码
    __block NSNumber *code = @0;
    [geocoder geocodeAddressString:geoAddr completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
        if (!error || placemarks != nil || placemarks.count != 0){
            CLPlacemark *placemark = placemarks.firstObject;
            if (placemark.postalCode) {
                code = @(placemark.postalCode.integerValue);
            }
        }
    }];
    
    if(! (token && post_name && post_mobile && post_address &&code)) {
        [NetWorks parametersHasNil];
        [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"请检查信息是否完整"];
        return ;
    };
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"post_name":post_name,
                          @"post_address":post_address,
                          @"post_code":code,
                          @"post_mobile":post_mobile,
                          @"checksum":[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/battery" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"添加邮件地址,网络问题"];
            return ;
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"添加邮件地址" andCaseN5:^{
            [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:[NSString stringWithFormat:@"%@失败",name]  andDetailText:@"充电宝申请已提交，如需修改请联系客服"];
        } andCaseN4:^{
            [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:[NSString stringWithFormat:@"%@失败",name]  andDetailText:@"充电宝已经寄出，不可修改!"];
        } andCase1:^{
            success(response);
            GLOBAL_ISREGFRESH = YES;
        } andCase2:nil];
    }];
}

#pragma mark - 充值  -
+ (void)chargeForUser:(NSString *)amount andPayWay:(NSString *)payWay andIsDeposit:(NSString *)aisDeposit andSuccessed:(void (^)(id))success {
    AccountManager *manager = [AccountManager shareAccountManager];
    NSString *token = [AccountManager token];
    NSString *payment_no = manager.userModel.mobile;
    NSString *count = amount;
    NSString *patWay = payWay;
    NSString *isDeposit = aisDeposit;
    NSString *checksum = [NSString stringWithFormat:@"%@%@%@%@%@%@",token,payment_no,patWay,count,isDeposit,AirBike_Salt];
    
    if (!(token&&payment_no&&patWay&&count&&isDeposit&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"payment_no":payment_no,
                          @"payment_type":patWay,
                          @"amount":count,
                          @"is_deposit":isDeposit,
                          @"checksum":[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/recharge" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"充值失败,网络问题"];
            return ;
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"充值" andCase1:^{
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"充值成功"];
            GLOBAL_ISREGFRESH = YES;
            success(response);
        }];
    }];
}

#pragma mark - 更改邀请码  -
+ (void)changeinviteFriNum:(NSString *)num andSuccessed:(void (^)(id))success {
    NSString *token = [AccountManager token];
    NSString *invit_code = num;
    NSString *checksum = [NSString stringWithFormat:@"%@%@%@",token,invit_code,AirBike_Salt];
    if (!(token&&invit_code&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"invit_code":invit_code,
                          @"checksum":[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/invitcode" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"更改邀请码,网络问题"];
            return ;
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"更改邀请码" andCase1:^{
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"更改邀请码成功"];
            GLOBAL_ISREGFRESH = YES;
            success(response);
        }];
    }];
}

#pragma mark - 获取骑行记录  -
+ (void)getTrackListSuccessed:(void (^)(id))success page:(NSString *)page {
    NSString *token = [AccountManager token];
    if (!page) {
        page = @"0";
    }
    NSString *checksum = [[NSString stringWithFormat:@"%@%@%@",token,page,AirBike_Salt] encodeMd5];
    if (!(token&&page&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"page":page,
                          @"checksum":checksum
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/cyclinglist" parameters:dic finished:^(id response, NSError *error) {
        if (!error) {
            NSInteger status = [response[@"status"] integerValue];
            NSString *message = response[@"message"];
            [self caseWithStatus:status andMessage:message  andWorkName:@"获取骑行记录" andCase1:^{
                if ([self isTest]) {
                    [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"获取骑行记录成功"];
                }
                success(response);
            }];
        }
    }];
}

+ (void)getTrackListSuccessed:(void (^)(id))success {
    return [self getTrackListSuccessed:success page:@"0"];
}

#pragma mark - 获取我的信息  -
+ (void)getMyNewsListSuccessed:(void (^)(id))success {
    NSString *token = [AccountManager token];
    NSString *checksum = [NSString stringWithFormat:@"%@%@",token,AirBike_Salt];
    if (!(token&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }

    NSDictionary *dic = @{
                          @"token":token,
                          @"checksum":[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/messages" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"获取信息列表,网络问题"];
            return ;
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"获取信息列表" andCase1:^{
            if ([self isTest]) {
                [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"获取信息列表成功"];
            }
            GLOBAL_ISREGFRESH = YES;
            success(response);
        }];
    }];
}

#pragma mark - 我的充值列表  -
+ (void)getMyChargeListSuccessed:(void (^)(id))success {
    NSString *token = [AccountManager token];
    NSString *checksum = [[NSString stringWithFormat:@"%@AIRBIKESALT",token] encodeMd5];
    if (!(token&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"checksum":checksum
                          };
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/rechargelist" parameters:dic finished:^(id response, NSError *error) {
        if (!error) {
            NSInteger status = [response[@"status"] integerValue];
            NSString *message = response[@"message"];
            [self caseWithStatus:status andMessage:message  andWorkName:@"充值列表列表" andCase1:^{
                success(response);
            }];
        }
    }];
}

#pragma mark - 我的钱包详情  -
+ (void)getMyWalletListSuccessed:(void (^)(id))success andFailed:(void (^)())failed {
    NSString *token = [AccountManager token];
    NSString *checksum = [[NSString stringWithFormat:@"%@AIRBIKESALT",token] encodeMd5];
    if (!(token&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"checksum":checksum
                          };
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/getbalance" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            return ;
        }
        failed();
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        
        [self caseWithStatus:status andMessage:message  andWorkName:@"充值列表列表" andCase1:^{
            if ([self isTest]) {
                [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"查询余额成功"];
            }
            success(response);
        }];
    }];
}

#pragma mark - 退出登录  -
+ (void)logOutsucdess:(void (^)(id))success  {
    NSString *token = [AccountManager token];
    NSString *checksum = [NSString stringWithFormat:@"%@%@",token,AirBike_Salt];
    if (!(token&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    NSDictionary *dic = @{
                          @"token":token,
                          @"checksum":[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/logout" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"退出登录,网络问题"];
            return ;
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"推出登录" andCase1:^{
                        if ([self isTest]) {
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"用户登出成功"];
                        }
            [[NSNotificationCenter defaultCenter] postNotificationName:PublicTVCHasLogOutNotification object:nil];
            success(response);
        }];
    }];
}

#pragma mark - 实名认证  -
+ (void)authenticationForUser:(NSString *)pics andNum:(NSString *)num andName:(NSString *)name andSuccessed:(void (^)(id success))success {
    NSString *token = [AccountManager token];
    NSString *real_name = name;
    NSString *id_card_number = num;
    NSString *id_card_pictures = pics;
    NSString *checksum = [[NSString stringWithFormat:@"%@%@%@AIRBIKESALT",token,real_name,id_card_number] encodeMd5];
    if (!(token&&real_name&&id_card_number&&id_card_pictures&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"real_name":real_name,
                          @"id_card_number":id_card_number,
                          @"id_card_pictures":id_card_pictures,
                          @"checksum":checksum
                          };
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/authentication" parameters:dic finished:^(id response, NSError *error) {
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"认证" andCase1:^{
            
            if ([self isTest]) {
                [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"认证成功,恭喜完成注册"];
            }
            success(response);
            GLOBAL_ISREGFRESH = YES;
        }];
    }];
}

#pragma mark - 邀请码绑定  -
+ (void)bindInviteCode:(NSString *)code  successBlock:(void(^)(id respense))successBlock; {
    if (!([AccountManager token] && code)) {
        if ([self isTest]) {
            [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"token或邀请码缺失"];
        }
        return;
    }
    NSString *checksum = [NSString stringWithFormat:@"%@%@%@",[AccountManager token],code,AirBike_Salt];
    NSDictionary *dict = @{
                           @"token"             :  [AccountManager token],
                           @"invite_code"     :  code,
                           @"checksum"       : [checksum encodeMd5]
                           };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/bindinvitecode" parameters:dict finished:^(id response, NSError *error) {
        if (error) {
            [HHProgressHUD showHUDWithText:@"提交失败"];
            return;
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        switch (status) {
            case 0:
                successBlock(response);
                break;
                
            default:
                [HHProgressHUD showHUDWithText:message];
                break;
        }
        
    }];
    
}


#pragma mark - 注册  -
+ (void)registNetWorkWithVerify:(NSString *)verStr andFriendInvitNum:(NSString *)invNum andPhoNum:(NSString *)phoNum andSuccessed:(void (^)(id resuponse))success logSuccess:(void (^)(id resuponse))logOn {
    NSString *strPho = phoNum;
    NSString *verify = verStr;
    NSString *checksum = [NSString stringWithFormat:@"%@%@AIRBIKESALT",strPho,verify];
    if (!(strPho&&verify&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"mobile":strPho ,
                          @"code":verify,
                          //                          @"invit_code":friendInvitNum,
                          @"checksum":[checksum encodeMd5]
                          };
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/register" parameters:dic finished:^(id response, NSError *error) {
        
        if (error) {
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"注册失败,网络问题"];
            return ;
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"注册" andCaseN6:^{
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"注册失败"];
        } andCaseN5:^{
            logOn(response);
            GLOBAL_ISREGFRESH = YES;
        }andCaseN4:^{
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"手机号不合法"];
        } andCase1:^{
            success(response);
            GLOBAL_ISREGFRESH = YES;
            logOn(response);
            if([self isTest]) {
                [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"注册成功"];
            }
        }];
    }];
}

#pragma mark - 获取验证码  -
+(void)getCheckCodeWithMobile:(NSString *)mobile successBlock:(void(^)(id respense))block {
    if ([mobile isEqualToString:@""]) {
        [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"无手机号"];
        return ;
    }
    NSString *token = @"airbike-token";
    NSString *checksum = [NSString stringWithFormat:@"%@%@AIRBIKESALT",token,mobile];
    NSDictionary *dic = @{
                          @"token" : token,
                          @"mobile" : mobile,
                          @"checksum" :[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/getcheckcode" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"获取验证码,网络问题"];
            return ;
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"获取验证码" andCaseN10:nil andCaseN9:nil  andCaseN8:nil andCaseN7:nil andCaseN6:^ {
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"获取验证码失败"];
        }andCaseN5:nil andCaseN4:nil andCaseN3:nil andCaseN2:nil andCaseN1:^{
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"60s内只能获取一次验证码"];
        } andCase0:^{
            if (message.length >1) {
                [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:message];
            }
            block(response);
        } andCase1:nil andCase2:^{
            if (message.length >1) {
                [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:message];
            }
        }];
    }];
}

+ (void)reportQuestionWithType:(NSString *)atype andCategory:(NSString *)acategoty andPictures:(NSString *)pics andDescription:(NSString *) adescription andSuccessed:(void (^)(id))success failed:(void (^)())failed {
    NSString *token = [AccountManager token];
    NSString *type =atype ;
    NSString *category = acategoty;
    NSString *imagesBase64 = pics;
    NSString *description = adescription;
    NSString *checksum = [[NSString stringWithFormat:@"%@%@%@%@AIRBIKESALT",token,type,category,description] encodeMd5];
    if (!(token&&type&&category&&imagesBase64&&description&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"type":type,
                          @"category":category,
                          @"pictures":imagesBase64,
                          @"description":description,
                          @"checksum":checksum
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/report" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            failed();
        }
        if (!error) {
            NSInteger status = [response[@"status"] integerValue];
            NSString *message = response[@"message"];
            [self caseWithStatus:status andMessage:message  andWorkName:@"反馈信息" andCase1:^{
                success(response);
            }];
        }
    }];
}

#pragma mark - 问题反馈  -
+ (void)reportQuestionWithType:(NSString *)atype andCategory:(NSString *)acategoty andPictures:(NSString *)pics andDescription:(NSString *)adescription andSuccessed:(void (^)(id))success {
    NSString *token = [AccountManager token];
    NSString *type =atype ;
    NSString *category = acategoty;
    NSString *imagesBase64 = pics;
    NSString *description = adescription;
    NSString *checksum = [[NSString stringWithFormat:@"%@%@%@%@AIRBIKESALT",token,type,category,description] encodeMd5];
    if (!(token&&type&&category&&imagesBase64&&description&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"type":type,
                          @"category":category,
                          @"pictures":imagesBase64,
                          @"description":description,
                          @"checksum":checksum
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/report" parameters:dic finished:^(id response, NSError *error) {
        if (!error) {
            NSInteger status = [response[@"status"] integerValue];
            NSString *message = response[@"message"];
            [self caseWithStatus:status andMessage:message  andWorkName:@"反馈信息" andCase1:^{
                success(response);
            }];
        }
    }];
}

#pragma mark - 退款申请  -
+ (void)refundDepositWithName:(NSString *)aname andShippint:(NSString *)ashippint andReceipt:(NSString *)receipt andSuccessed:(void (^)(id))success {
    NSString *token = [AccountManager token];
    NSString *name = @"123";
    NSString *shipping_by  =@"123456";
    NSString *receipt_number =@"123";
    NSString *checksum =[NSString stringWithFormat:@"%@%@%@%@AIRBIKESALT",token,name,shipping_by,receipt_number];
    if (!(token&&name&&shipping_by&&receipt_number&&checksum)) {
        [NetWorks parametersHasNil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token ,
                          @"name":name,
                          @"shipping_by":shipping_by,
                          @"receipt_number":receipt_number,
                          @"checksum":[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/refund" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            UIWindow *view = [UIApplication sharedApplication].keyWindow;
            [HHProgressHUD showHUDInView:view animated:YES withText:@"退款失败,网络问题"];
            return ;
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"申请退押金" andCase1:^{
            if ([self isTest]) {
                [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:@"退款申请提交成功"  andDetailText:@"退款申请提交成功"];
            }
            GLOBAL_ISREGFRESH = YES;
            success(response);
        } andCaseN4:^{
            [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"退款申请已通过，不可修改"];
        }];
    }];
}

#pragma mark - 清空搜索  -
+ (void)cleanSearchHistoryWithSearchKey:(NSString *)key Successed:(void(^)(id success))success {
    NSString *token = [AccountManager token];
    NSString *checksum = [NSString stringWithFormat:@"%@%@%@",token,key,AirBike_Salt];
    if (!(token && key &&checksum)) {
        return;
    }
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"search_key" : key,
                          @"checksum":[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/delsearchfavorite" parameters:dic finished:^(id response, NSError *error) {
        if (error) {
            UIWindow *view = [UIApplication sharedApplication].keyWindow;
            [HHProgressHUD showHUDInView:view animated:YES withText:@"清空搜索记录失败"];
            return ;
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"清空搜索记录" andCase1:^{
            success(response);
        }];
    }];
}

#pragma mark - 获取搜索记录  -
+ (void)getSearchHistoryListFinished:(void(^)(id response, NSError *error))finished {
    NSString *checksum = [NSString stringWithFormat:@"%@%@",GLOBAL_TOKEN,AirBike_Salt];
    if (!(GLOBAL_TOKEN&&checksum)) {
        return;
    }
    
    RefreshView *view = [self showLoadingView];
    NSDictionary *dic = @{
                          @"token":GLOBAL_TOKEN,
                          @"checksum":[checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/getsearchfavorite" parameters:dic finished:^(id response, NSError *error) {
        [view removeFromSuperview];
        if (error) {
            finished(nil,error);
            return ;
        }
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message  andWorkName:@"获取搜搜记录" andCase1:^{
            if ([self isTest]) {
                [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"获取搜索记录成功"];
            }
            finished(response,nil);
        }];
        
    }];
}

#pragma mark - 添加搜索记录  -
+ (void)addSearchHistoryWithSearchKey:(NSString *)key searchAddress:(NSString *)address successBlock:(void(^)(id response))success topNumBlockFaild:(void(^)(id response))topNum{
    NSString *token = [AccountManager token];
    NSString *checksum = [NSString stringWithFormat:@"%@%@%@%@",token,key,address,AirBike_Salt];
    if (!(token&&key&&address&&checksum)) {
        return;
    }
    
    NSDictionary *dic = @{
                          @"token"          :  token,
                          @"search_key"  :  key,
                          @"search_addr" : address,
                          @"checksum"   :  [checksum encodeMd5]
                          };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/setsearchfavorite" parameters:dic finished:^(id response, NSError *error) {
        
        if (error) {
            [HHProgressHUD showHUDInView:[UIApplication sharedApplication].keyWindow animated:YES withText:@"添加记录,网络问题"];
            return ;
        }
        
        NSInteger status = [response[@"status"] integerValue];
        NSString *message = response[@"message"];
        [self caseWithStatus:status andMessage:message andWorkName:@"添加记录" andCaseN10:nil andCaseN9:^{
            topNum(response);
        } andCaseN8:nil andCaseN7:nil andCaseN6:nil andCaseN5:nil andCaseN4:nil andCaseN3:nil andCaseN2:nil andCaseN1:nil andCase0:nil andCase1:^{
            success(response);
        } andCase2:nil];
    }];
}

//状态查询
+ (void)statusqueryWithSuccessBlock:(void(^)(id response))success{
    if (![AccountManager token]) {
        return;
    }
    NSString *checksum = [NSString stringWithFormat:@"%@%@",[AccountManager token],AirBike_Salt];
    NSDictionary *dict = @{@"token" : [AccountManager token],
                           @"checksum" : [checksum encodeMd5],
                           };
    
    [[NetworkTools shareNetworkTools] postUrlString:@"/v1/users/queryridingstatus" parameters:dict finished:^(id response, NSError *error) {
        if(error) {
            if ([self isTest]) {
                [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:error.localizedFailureReason];
            }
            return ;
        }
        
        if ([self isTest]) {
            NSString *string = @"";
            if([response[@"result"][@"riding_status"] isEqual:@1]) {
                string = @"骑行状态";
            }
            if([response[@"result"][@"riding_status"] isEqual:@2]) {
                string = @"预约状态";
            }
            if (string.length >1) {
                [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:string];
            }
        }
        
        if ([response[@"status"] isEqual:@1]) {
            success(response);
        }
    }];
}

+ (void)caseWithStatus:(NSInteger)status andMessage:(NSString *)message andWorkName:(NSString *)name  andCase1:(void(^)())case1 andCaseN4:(void(^)())caseN4 {
    [self caseWithStatus:status andMessage:message andWorkName:name andCaseN10:nil andCaseN9:nil andCaseN8:nil andCaseN7:nil andCaseN6:nil andCaseN5:nil andCaseN4:caseN4 andCaseN3:nil andCaseN2:nil andCaseN1:nil andCase0:nil andCase1:case1 andCase2:nil];
}

+ (void)caseWithStatus:(NSInteger)status andMessage:(NSString *)message andWorkName:(NSString *)name andCaseN6:(void(^)())caseN6 andCaseN5:(void(^)())caseN5 andCaseN4:(void(^)())caseN4 andCase1:(void(^)())case1 {
    [self caseWithStatus:status andMessage:message andWorkName:name andCaseN10:nil andCaseN9:nil andCaseN8:nil andCaseN7:nil andCaseN6:caseN6 andCaseN5:caseN5 andCaseN4:caseN4 andCaseN3:nil andCaseN2:nil andCaseN1:nil andCase0:nil andCase1:case1 andCase2:nil];
}

+ (void)caseWithStatus:(NSInteger)status andMessage:(NSString *)message andWorkName:(NSString *)name  andCase1:(void(^)())case1 {
    [self caseWithStatus:status andMessage:message andWorkName:name andCase1:case1 andCaseN2:nil andCaseN1:nil];
}

+ (void)caseWithStatus:(NSInteger)status andMessage:(NSString *)message andWorkName:(NSString *)name andCaseN5:(void(^)())caseN5 andCaseN4:(void(^)())caseN4  andCase1:(void(^)())case1 andCase2:(void(^)())case2 {
    [self caseWithStatus:status andMessage:message andWorkName:name andCaseN10:nil andCaseN9:nil andCaseN8:nil andCaseN7:nil andCaseN6:nil andCaseN5:caseN5 andCaseN4:caseN4 andCaseN3:nil andCaseN2:nil andCaseN1:nil andCase0:nil andCase1:case1 andCase2:case2];
}

+ (void)caseWithStatus:(NSInteger)status andMessage:(NSString *)message andWorkName:(NSString *)name  andCase1:(void(^)())case1 andCaseN2:(void(^)())caseN2 andCaseN1:(void(^)())caseN1 {
    [self caseWithStatus:status andMessage:message andWorkName:name andCaseN10:nil andCaseN9:nil  andCaseN8:nil andCaseN7:nil andCaseN6:nil andCaseN5:nil andCaseN4:nil andCaseN3:nil andCaseN2:caseN2 andCaseN1:caseN1 andCase0:nil andCase1:case1 andCase2:nil];
}

+ (void)caseWithStatus:(NSInteger)status andMessage:(NSString *)message andWorkName:(NSString *)name andCaseN10:(void(^)())caseN10 andCaseN9:(void(^)())caseN9 andCaseN8:(void(^)())caseN8 andCaseN7:(void(^)())caseN7 andCaseN6:(void(^)())caseN6 andCaseN5:(void(^)())caseN5 andCaseN4:(void(^)())caseN4 andCaseN3:(void(^)())caseN3 andCaseN2:(void(^)())caseN2 andCaseN1:(void(^)())caseN1 andCase0:(void(^)())case0 andCase1:(void(^)())case1 andCase2:(void(^)())case2 {
    switch (status) {
        case -99:
            if (message.length >1) {
                [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:message];
            }
            break;
        case -10:
            if (caseN10) {
                caseN10();
            }
            break;
        case -9:
            if (caseN9) {
                caseN9();
            }
            break;

        case -8:
            if (caseN8) {
                caseN8();
            }
            break;
            
        case -7:
            if (caseN7 != nil) {
                caseN7();
            }
            if (message.length >1) {
                [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:message];
            }
            break;
        case -6:
            if (caseN6 != nil) {
                caseN6();
            }
            break;
        case -5:
            if (caseN5 != nil) {
                caseN5();
            }
            break;
        case -4:
            if (caseN4 != nil) {
                caseN4();
            }
            
            break;
        case -3:
            if (caseN3 == nil) {
                if (message.length >1) {
                    [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:message];
                }
                break;
            }
            caseN3();
            break;
        case -2:
        {
            if (caseN2 != nil) {
                caseN2();
                break;
            }
            [GLOBAL_MANAGER quit];
            ZHHScanSuccessView *viewScan = [ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:[NSString stringWithFormat:@"%@失败",name]  andDetailText:message];
            viewScan.failed = ^() {
                [NetWorks parametersHasNil];
            };
            break;
        }
        case -1:{
            if (caseN1 != nil) {
                caseN1();
                break;
            }
            [GLOBAL_MANAGER quit];
            ZHHScanSuccessView *viewScan =[ZHHScanSuccessView showViewAtAppKeyWindowsWithTitleText:[NSString stringWithFormat:@"%@失败",name] andDetailText:message];
            viewScan.failed = ^() {
                [NetWorks parametersHasNil];
            };
            break;
        }
        case 0:
            if (case0 == nil) {
                if (message.length >1) {
                    [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:message];
                }
                break;
            }
            case0();
            break;
            
        case 2:
        {
            if (case2 != nil) {
                case2();
                break;
            }
            break;
        }
        case 1:
        {
            if (case1 != nil) {
                case1();
                break;
            }
            break;
        }
        default:
            if (message.length >1) {
                [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:message];
            }
            break;
    }
}

+ (void)handleWithStatus:(NSInteger )status
                 message:(NSString *)message
      successStatus:(NSNumber *)successStatus
            successBlock:(void(^)())successBlock {
    [self handleWithStatus:status message:message successStatusArray:@[successStatus] failedStatusArray:nil successBlock:successBlock failedBlock:nil defaultBlock:^{
        [HHProgressHUD showHUDWithText:message];
    }];
}

+ (void)handleWithStatus:(NSInteger )status
                 message:(NSString *)message
      successStatusArray:(NSArray <NSNumber *>*)successStatusArr
       failedStatusArray:(NSArray <NSNumber *> *)failedStatusArr
            successBlock:(void(^)())successBlock
             failedBlock:(void(^)())failedBlock
            defaultBlock:(void (^)())defaultBlock {
    if ([successStatusArr containsObject:[NSNumber numberWithInteger:status]]) {
        if (successBlock) {
            successBlock();
        }
    }
    
   else  if ([failedStatusArr containsObject:[NSNumber numberWithInteger:status]]) {
        if (failedBlock) {
            failedBlock();
        }
    }
    
   else {
       if (defaultBlock) {
           defaultBlock();
       }
   }
}

@end
