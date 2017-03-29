//
//  ZHHBalanceModel.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/7.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHHBalanceModel : NSObject<NSCoding>

@property (nonatomic, copy)NSString *user_id;           //用户id
@property (nonatomic, copy)NSString *credit_points;    //信用分
@property (nonatomic, copy)NSString *deposit;           //押金
@property (nonatomic, copy)NSString *freeze;            //
@property (nonatomic, copy)NSString *balance;          //余额
@property (nonatomic, copy)NSString *activity;          //

+(instancetype)balanceModelWithDic:(NSDictionary *)dic;

@end
