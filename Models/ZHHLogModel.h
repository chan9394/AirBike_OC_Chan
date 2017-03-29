//
//  ZHHLogModel.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/6.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZHHUserModel,ZHHBalanceModel;

@interface ZHHLogModel : NSObject<NSCoding>

@property (nonatomic, strong) ZHHBalanceModel *balance;///<标注#>
@property (nonatomic, strong) ZHHUserModel *user;///<标注#>


@property (nonatomic, strong)NSMutableArray *addrAry;//收货地址数组

-(NSString *)userbalance;
-(NSString *)mobile;
-(NSString *)realname;
-(NSString *)token;
-(NSString *)mileage;
-(NSString *)calorie;
-(NSString *)carbon_emission;
-(NSString *)creditScore;
-(NSString *)nickName;
-(NSString *)deposit;
-(NSString *)userId;
-(BOOL)hasRealName;
-(BOOL)hasDeposit;
- (BOOL)hasBalance;
-(BOOL)onceDeposit;
+(instancetype)registerWithDic:(NSDictionary *)dic;

@end
