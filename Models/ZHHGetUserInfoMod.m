//
//  ZHHGetUserInfoMod.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/11.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHGetUserInfoMod.h"
#import "ZHHUserDetailInfo.h"
#import "ZHHBalanceModel.h"

@implementation ZHHGetUserInfoMod
+(instancetype)getUserInfoMod:(NSDictionary *)dic{
    ZHHGetUserInfoMod *mod = [ZHHGetUserInfoMod new];
    mod.user = [ZHHUserDetailInfo userDetailInfo:dic[@"user"]];
    mod.balance = [ZHHBalanceModel balanceModelWithDic:dic[@"balance"]];
    return mod;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.balance forKey:@"balance"];
    [aCoder encodeObject:self.user forKey:@"user"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.balance = [aDecoder decodeObjectForKey:@"balance"];
        self.user = [aDecoder decodeObjectForKey:@"user"];
        
    }
    return self;
}
@end
