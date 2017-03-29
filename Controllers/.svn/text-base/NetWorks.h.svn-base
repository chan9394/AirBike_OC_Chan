//
//  NetWorks.h
//  AirBk
//
//  Created by 郑洪浩 on 2017/1/3.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const PublicTVCHasLogOutNotification;

@interface NetWorks : NSObject
//预约单车
+(void)orderBikeNetWorkWithDeviceId:(NSString *)deviceId andSuccessed:(void(^)(id response)) success;
//取消预约单车
+(void)cancleOrderBikeNetWorkWithDeviceId:(NSString *)deviceId andSuccessed:(void(^)(id response)) success;
//查询骑行状态
+(void)finishTrackHttpRequestWithDeviecId:(NSString *)deviceId and:(void(^)(id response)) isRiding and:(void(^)(id response))successFinish andHasLogOut:(void(^)())logOut;
//查询附近单车列表
+(void)getBikeNerabyListWithCoordinate2D:(CLLocationCoordinate2D)location andSuccessGetList:(void(^)(id response))success;
//获取骑行列表
+(void)getCyclingListResultSuccessGetList:(void(^)(id response))success;
//获取用户详细信息
+(void)getUserInfoDetailSuccessGet:(void(^)(id response))success  pushRegisterVC:(BOOL)shouldPush;
//开锁
+(void)unlockBikeWithDeviceId:(NSString *)device_id failed:(void(^)()) failed andSuccess:(void(^)(id response))success;
//查询锁状态
+(void)checkUnlockStateRequestWithDeviecId:(NSString *)deviceId andSuccess:(void(^)(id response))success;
//上传头像
+(void)changeHeadImg:(NSString *)pic andSuccess:(void(^)(id response))success;
//更改昵称
+(void)changeNickNameNetWorkWithNickName:(NSString *)nickName andSuccess:(void(^)(id response))success;
//更改手机号
+(void)changePhoneNumNetWorkWithPhoneN:(NSString *)num andVariNum:(NSString *)varN andSuccess:(void(^)(id response))success;
//充电宝邮寄地址
+(void)postAddreBateForUser:(NSString *)name andAdr:(NSString *)addr andGeoAddr:(NSString *)geoAddr andPhoN:(NSString *)pNum andFailed:(void(^)())failed andSuccess:(void(^)(id response))success;
//充值
+(void)chargeForUser:(NSString *)amount andPayWay:(NSString *)patWay andIsDeposit:(NSString *)isDeposit andSuccessed:(void(^)(id response))success;
//更改邀请码
+(void)changeinviteFriNum:(NSString *)num andSuccessed:(void(^)(id response))success;
//获取骑行记录
+(void)getTrackListSuccessed:(void(^)(id response))success;
//获取我的消息
+(void)getMyNewsListSuccessed:(void(^)(id response))success;
//获取我的充值列表
+(void)getMyChargeListSuccessed:(void(^)(id response))success;
//获取我的钱包详情
+(void)getMyWalletListSuccessed:(void(^)(id response))success andFailed:(void(^)())failed;
//退出登录
+(void)logOutsucdess:(void(^)(id response))success;
//实名认证
+(void)authenticationForUser:(NSString *)pics andNum:(NSString *)num andName:(NSString *)name andSuccessed:(void(^)(id success))success;
//邀请码绑定
+ (void)bindInviteCode:(NSString *)code  successBlock:(void(^)(id respense))successBlock;
//注册
+(void)registNetWorkWithVerify:(NSString *)verStr andFriendInvitNum:(NSString *)invNum andPhoNum:(NSString *)phoNum andSuccessed:(void(^)(id success))success logSuccess:(void (^)(id response))logOn;
//获取验证码
+(void)getCheckCodeWithMobile:(NSString *)mobile successBlock:(void(^)(id respense))block;
//问题反馈
+(void)reportQuestionWithType:(NSString *)type andCategory:(NSString *)categoty andPictures:(NSString *)pics andDescription:(NSString *)description andSuccessed:(void(^)(id response))success;

+(void)reportQuestionWithType:(NSString *)atype andCategory:(NSString *)acategoty andPictures:(NSString *)pics andDescription:(NSString *) adescription andSuccessed:(void (^)(id))success failed:(void (^)())failed;
//退款申请
+(void)refundDepositWithName:(NSString *)aname andShippint:(NSString *)ashippint andReceipt:(NSString *)receipt andSuccessed:(void(^)(id success))success;
//清空搜索
+ (void)cleanSearchHistoryWithSearchKey:(NSString *)key Successed:(void(^)(id success))success;
//获取搜索记录
+ (void)getSearchHistoryListFinished:(void(^)(id response, NSError *error))finished;
//添加搜索记录
+ (void)addSearchHistoryWithSearchKey:(NSString *)key searchAddress:(NSString *)address successBlock:(void(^)(id response))success topNumBlockFaild:(void(^)(id response))topNum;
//状态查询
+ (void)statusqueryWithSuccessBlock:(void(^)(id response))success;

@end
