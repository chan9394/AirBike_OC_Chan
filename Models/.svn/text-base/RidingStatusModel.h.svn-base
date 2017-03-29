//
//  UserStatusModel.h
//  AirBk
//
//  Created by Damo on 2017/2/8.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RidingStatusModel : NSObject <YYModel>

@property (nonatomic, copy) NSString *ridingStatus;  //状态 0-默认 1-骑行 2-预约
@property (nonatomic, copy) NSString *serialNo;        //骑行状态唯一标识
@property (nonatomic, copy) NSString *lockId;           //🔒的ID
@property (nonatomic, copy) NSNumber *seconds;   //预约状态的剩余时间


//json转模型
- (void)modelWIthJSON:(id)json;

@end
