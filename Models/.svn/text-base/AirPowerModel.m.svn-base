//
//  AirPowerModel.m
//  AirBk
//
//  Created by Damo on 2017/3/6.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "AirPowerModel.h"

@implementation AirPowerModel

- (void)setStatus:(AirPowerStatus)status {
    _status             = status;
    NSDictionary *dict  = [self statusMessageWithIndex:status];
    _topStatus          = [dict valueForKey:@"topStatus"];
    _bottomStatus       = [dict valueForKey:@"bottomStatus"];
    _imageStr = @"imgs_main_power";
    if (status == AirPowerStatusLock) {
        _imageStr = @"imgs_menu_power_lock";
    }
}

- (NSDictionary *)statusMessageWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return @{@"topStatus"     : @"正在处理",
                     @"bottomStatus"  : @"已激活"};
            break;
        case 1:
            return @{@"topStatus"     : @"已发货",
                     @"bottomStatus"  : @"已激活"};
            break;
        case 2:
            return @{@"topStatus"     : @"已配对您的账户",
                     @"bottomStatus"  : @"已激活"};
            break;
        case 3:
            return @{@"topStatus"     : @"AirPower配对已取消",
                     @"bottomStatus"  : @"已锁定"};
            break;
        case 4:
            return @{@"topStatus"     : @"挂失成功,正在处理",
                     @"bottomStatus"  : @"待激活"};
            break;
        case 5:
            return @{@"topStatus"     : @"待审核",
                     @"bottomStatus"  : @"押金退还"};
            break;
        case 6:
            return @{@"topStatus"     : @"审核中",
                     @"bottomStatus"  : @"押金退还"};
            break;
        case 7:
            return @{@"topStatus"     : @"待审核",
                     @"bottomStatus"  : @"申请维修"};
            break;
        case 8:
            return @{@"topStatus"     : @"审核中",
                     @"bottomStatus"  : @"申请维修"};
            break;
        case 9:
            return @{@"topStatus"     : @"审核未通过",
                     @"bottomStatus"  : @"申请维修"};
            break;
        default:
            break;
    }
    
    return @{@"topStatus"     : @"正在处理",
                    @"bottomStatus"  : @"已锁定"};
}

@end
