//
//  AccountManager.m
//  AirBk
//
//  Created by Damo on 2017/1/12.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "AccountManager.h"
#import <SAMKeychain.h>
#import <objc/runtime.h>

@implementation AccountManager

+ (instancetype)shareAccountManager {
   static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (NSString *)urlStr {
    if (!self.userModel.headImage) {
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"http://airbike.wrteach.com%@",self.userModel.headImage];
    return  urlStr;
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
             @"userModel"       : @"result.user",
             @"balanceModel"  : @"result.balance",
             @"bikeSerial"        : @"result.serial_no"
             };
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"userModel"           : [UserModel class],
             @"balanceModel"      : [BalanceModel class],
             @"rechargeModel"     : [ZHHRechargeModel class],
             };
}

- (BOOL)hasRealName{
    if ([self.userModel.realName isEqual:[NSNull new]]) {
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)hasBalance {
    if (self.balanceModel.balance.integerValue > 1 ) {
        return YES;
    }
    return NO;
}

- (BOOL)hasDeposit{
    NSInteger depo = [self.balanceModel.deposit integerValue];
    if (depo == 0) {
        return NO;
    }
    return YES;
}

+ (NSString *)token {
    NSString *token = [SAMKeychain passwordForService:@"airbike" account:@"token"];
    return token;
}

+ (NSString *)UUID {
    return [SAMKeychain passwordForService:@"airbike" account:@"UUID"];
}

- (void)modelWIthJSON:(id)json {
    BOOL result = [self yy_modelSetWithJSON:json];
    if (result == 0) {
        NSLog(@"%s", __FUNCTION__);
    }
}


- (void)quit {
    self.userModel = nil;
    self.balanceModel = nil;
    self.rechargeModel = nil;
    self.trackInfoModel = nil;
    self.statusModel = nil;
    self.urlStr = nil;
    self.bikeSerial = nil;
    [SAMKeychain deletePasswordForService:@"airbike" account:@"token"];
}

- (ZHHRechargeModel *)rechargeModel {
    if (!_rechargeModel) {
        _rechargeModel = [[ZHHRechargeModel alloc] init];
    }
    return _rechargeModel;
}

- (ZHHTrackInfoModel *)trackInfoModel {
    if (!_trackInfoModel) {
        _trackInfoModel = [[ZHHTrackInfoModel alloc] init];
    }
    return _trackInfoModel;
}

- (RidingStatusModel *)statusModel {
    if (!_statusModel) {
        _statusModel = [[RidingStatusModel alloc] init];
    }
    return _statusModel;
}


@end
