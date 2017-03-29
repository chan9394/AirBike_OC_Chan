//
//  TrackListModel.h
//  AirBk
//
//  Created by Damo on 2017/1/16.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackListModel : NSObject <YYModel>

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *lockId;
@property (nonatomic, copy) NSString *isBattery;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *mileage;
@property (nonatomic, copy) NSString *cost;
@property (nonatomic, copy) NSString *creditPoints;
@property (nonatomic, copy) NSString *analysis_gps_data;
@property (nonatomic, copy) NSString *lockData;
@property (nonatomic, copy) NSString *appData;
@property (nonatomic, copy) NSString *status;

- (void)modelWithJSON:(id)json;

@end
