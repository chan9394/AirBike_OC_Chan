//
//  RechageDetailModel.h
//  AirBk
//
//  Created by Damo on 2017/1/16.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechageDetailModel : NSObject <YYModel>

@property (nonatomic, copy) NSString            *amount;            //账户金额
@property (nonatomic, copy) NSString            *created;            //充值时间
@property (nonatomic, copy) NSString            *rechaId;            //充值编号
@property (nonatomic, copy) NSString            *paymentNo;      //充值账号
@property (nonatomic, copy) NSString            *paymentType;   //充值方式 1.weixin
@property (nonatomic, copy) NSString            *type;
@property (nonatomic, copy) NSString            *userId;

- (void)modelWithJSON:(id)json;

@end
