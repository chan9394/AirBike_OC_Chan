//
//  AirPowerModel.h
//  AirBk
//
//  Created by Damo on 2017/3/6.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,AirPowerStatus) {
    AirPowerStatusProcessing,           //正在处理
    AirPowerStatusDelivered,            //已发货
    AirPowerStatusMatch,                //已配对
    AirPowerStatusLock,                 //配对取消
    AirPowerStatusLoss,                 //挂失成功
    AirPowerStatusWaitRefundCheck,      //押金退还待审核
    AirPowerStatusRefundChecking,       //押金退还审核中
    AirPowerStatusWaitRepairCheck,      //电源维修待审核
    AirPowerStatusRepairChecking,       //电源维修审核中
    AirPowerStatusRepairCheckFailed,    //电源维修审核失败
};


@interface AirPowerModel : NSObject

@property (nonatomic,   copy)    NSString                    *topStatus;        //已发货
@property (nonatomic,   copy)    NSString                    *bottomStatus;     //已激活
@property (nonatomic,   copy)    NSString                    *imageStr;         //图片名
@property (nonatomic,   copy)    NSString                    *time;             //时间
@property (nonatomic,   copy)    NSString                    *serialNum;        //电源序列号
@property (nonatomic,   copy)    NSString                    *orderNum;         //订单号
@property (nonatomic,   copy)    NSString                    *courierNum;       //快递单号
@property (nonatomic,   copy)    NSString                    *expressCompany;   //快递公司
@property (nonatomic,   copy)    NSString                    *depreciation;     //折旧金额
@property (nonatomic,   copy)    NSString                    *sender;           //发货人
@property (nonatomic,   copy)    NSString                    *senderCity;       //市
@property (nonatomic,   copy)    NSString                    *senderArea;       //区
@property (nonatomic,   copy)    NSString                    *senderAddr;       //具体地址
@property (nonatomic,   copy)    NSString                    *senderPhone;      //电话
@property (nonatomic,   copy)    NSString                    *receiver;         //本人
@property (nonatomic,   copy)    NSString                    *receiverCity;
@property (nonatomic,   copy)    NSString                    *receiverArea;
@property (nonatomic,   copy)    NSString                    *receiverAddr;
@property (nonatomic,   copy)    NSString                    *receiverPhone;
@property (nonatomic, assign)    AirPowerStatus              status;            //电源状态
@property (nonatomic,   copy)    NSString                    *note;             //留言

@end
