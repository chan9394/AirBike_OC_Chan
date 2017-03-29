//
//  ZHHLogModel.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/6.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHLogModel.h"
#import "ZHHPostAddress.h"
#import "ZHHBalanceModel.h"
#import "ZHHUserModel.h"
@implementation ZHHLogModel


+(instancetype)registerWithDic:(NSDictionary *)dic{
    ZHHLogModel *log = [[ZHHLogModel alloc] init];
    log.balance = [ZHHBalanceModel balanceModelWithDic:dic[@"blance"]];
    log.user = [ZHHUserModel userModelWithDic:dic[@"user"]];
    return log;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.balance forKey:@"balance"];
    [aCoder encodeObject:self.user forKey:@"user"];
    [aCoder encodeObject:self.addrAry forKey:@"addrAry"];
}
-(instancetype)init{
    if (self = [super init]) {
        self.addrAry = [NSMutableArray array];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
       
        self.addrAry = [aDecoder decodeObjectForKey:@"addrAry"];
        self.balance = [aDecoder decodeObjectForKey:@"balance"];
        self.user = [aDecoder decodeObjectForKey:@"user"];
        
    }
    return self;
}
-(BOOL)hasDeposit{
    NSInteger depo = [self.balance.deposit integerValue];
    if (depo == 0) {
        return NO;
    }
    return YES;
}
-(NSString *)deposit{
    return self.balance.deposit;
}
-(NSString *)nickName{
    if ([self.user.nick_name isEqual:[NSNull new]]||!self.user.nick_name) {
        
        return [self.user.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
    }
    return self.user.nick_name;
}
-(NSString *)userbalance{
    return self.balance.balance;
}
-(NSString *)creditScore{
    
    return self.balance.credit_points;
    
}
-(NSString *)carbon_emission{
    return self.user.carbon_emission;
}
-(NSString *)calorie{
    return self.user.calorie;
}
-(NSString *)mileage{
    return self.user.mileage;
}
-(NSString *)token{
    return self.user.access_token;
}
-(NSString *)realname{
    return self.user.real_name;
}
-(NSString *)mobile{
    return self.user.mobile;
}
-(NSString *)userId{
    return self.user.iD;
}
-(BOOL)hasRealName{
    if ([self.user.real_name isEqual:[NSNull new]]) {
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)hasBalance {
    if (self.balance.balance.integerValue > 1 ) {
        return YES;
    }
    return NO;
}

-(BOOL)onceDeposit{
    if ([self.user.hasDeposit isEqual:@(0)]) {
        return NO;
    }else{
        return YES;
    }
}
@end
