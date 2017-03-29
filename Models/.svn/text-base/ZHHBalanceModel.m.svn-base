//
//  ZHHBalanceModel.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/7.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHBalanceModel.h"

@implementation ZHHBalanceModel

+(instancetype)balanceModelWithDic:(NSDictionary *)dic{
    
    ZHHBalanceModel *model = [[ZHHBalanceModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.user_id forKey:@"user_id"];
    [aCoder encodeObject:self.credit_points forKey:@"credit_points"];
    [aCoder encodeObject:self.deposit forKey:@"deposit"];
    [aCoder encodeObject:self.freeze forKey:@"freeze"];
    [aCoder encodeObject:self.balance forKey:@"balance"];
    [aCoder encodeObject:self.activity forKey:@"activity"];
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.user_id = [aDecoder decodeObjectForKey:@"user_id"];
        self.credit_points = [aDecoder decodeObjectForKey:@"credit_points"];
        self.deposit = [aDecoder decodeObjectForKey:@"deposit"];
        self.freeze = [aDecoder decodeObjectForKey:@"freeze"];
        self.balance = [aDecoder decodeObjectForKey:@"balance"];
        self.activity = [aDecoder decodeObjectForKey:@"activity"];
        
    }
    return self;
    
}
@end
