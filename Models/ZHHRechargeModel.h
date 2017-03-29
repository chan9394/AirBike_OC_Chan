//
//  ZHHRechargeModel.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RechageDetailModel.h"

@interface ZHHRechargeModel : NSObject <YYModel>

@property (nonatomic,   copy) NSString *count;
@property (nonatomic,   copy) NSString *page;       //页数
@property (nonatomic, strong) NSArray <RechageDetailModel * > *rechageDetailArr; //账目明细

- (void)modelWithJSON:(id)json;

@end
