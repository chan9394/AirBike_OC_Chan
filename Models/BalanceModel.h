//
//  BalanceModel.h
//  AirBk
//
//  Created by Damo on 2017/1/12.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BalanceModel : NSObject  <YYModel>

@property (nonatomic, copy) NSString *userId;              //用户id
@property (nonatomic, copy) NSString *creditPoint;       //信用分
@property (nonatomic, copy) NSString *deposit;            //押金
@property (nonatomic, copy) NSString *freeze;              //冻结金额
@property (nonatomic, copy) NSString *balance;            //余额
@property (nonatomic, copy) NSString *activity;             //活动赠送金额

//json转模型
- (void)modelWIthJSON:(id)json;

@end
