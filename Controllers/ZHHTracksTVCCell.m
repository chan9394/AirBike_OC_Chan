//
//  ZHHTracksTVCCell.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHTracksTVCCell.h"
#import "ZHHTrackInfoModel.h"
@interface ZHHTracksTVCCell ()
@property (weak, nonatomic) IBOutlet UILabel *startTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *bikeIdLab;
@property (weak, nonatomic) IBOutlet UILabel *trackTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *payLab;

@end

@implementation ZHHTracksTVCCell

- (void)setModel:(TrackListModel *)model {
    _model = model;

    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"yy-MM-dd HH-mm-ss";
    NSDate *endDate =  [dateformatter dateFromString:model.endTime];
    NSDate *startDate = [dateformatter dateFromString:model.startTime];
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:startDate];
    NSInteger min = timeInterval/60 ;
    
    self.startTimeLab.text = model.startTime;
    self.bikeIdLab.text = model.deviceId;
    if (min > 1) {
        self.trackTimeLab.text = [NSString stringWithFormat:@"%ld分钟",(long)min];
    } else {
         self.trackTimeLab.text = [NSString stringWithFormat:@"%ld秒",(long)timeInterval];
    }
    
    if (model.cost) {
        self.payLab.text = [NSString stringWithFormat:@"%@元",model.cost];
    }
    
}

@end
