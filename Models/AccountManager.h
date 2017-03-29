//
//  AccountManager.h
//  AirBk
//
//  Created by Damo on 2017/1/12.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "BalanceModel.h"
#import "ZHHRechargeModel.h"
#import "ZHHTrackInfoModel.h"
#import "RidingStatusModel.h"

@interface AccountManager : NSObject <YYModel>

@property (nonatomic, strong) UserModel               *userModel;        //用户信息
@property (nonatomic, strong) BalanceModel          *balanceModel;   //账户信息
@property (nonatomic, strong) ZHHRechargeModel *rechargeModel;  //充值明细
@property (nonatomic, strong) ZHHTrackInfoModel *trackInfoModel;  //骑行记录
@property (nonatomic, strong) RidingStatusModel   *statusModel;     //状态
@property (nonatomic,   copy) NSString                  *urlStr;               //头像的地址
@property (nonatomic,   copy) NSString                  *bikeSerial;        //当前车锁的序列号
@property (nonatomic, assign) BOOL                       isRefresh;         //是否刷新个人信息

//单例对象
+ (instancetype)shareAccountManager;

//是否实名
- (BOOL)hasRealName;

//是否有押金
- (BOOL)hasDeposit;

//余额是否大于1
- (BOOL)hasBalance;

//本地存储的token
+ (NSString *)token;

//本机的唯一标识
+ (NSString *)UUID;

//json转模型
- (void)modelWIthJSON:(id)json;

//退出登录
- (void)quit;

@end
