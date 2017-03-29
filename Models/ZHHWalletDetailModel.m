//
//  ZHHWalletDetailModel.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHWalletDetailModel.h"

@implementation ZHHWalletDetailModel

+(ZHHWalletDetailModel *)walletDetailModelWithTime:(NSString *)time andResult:(NSString *)result andMoney:(NSNumber *)money andPayway:(NSString *)payWay{
    
    ZHHWalletDetailModel *model = [[ZHHWalletDetailModel alloc] init];
    model.time = time;
    model.result = result;
    model.money = money;
    model.payWay = payWay;
    return model;
    
}

@end
