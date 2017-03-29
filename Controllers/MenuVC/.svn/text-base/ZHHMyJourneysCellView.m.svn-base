
//
//  ZHHMyJourneysCellView.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/3.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHMyJourneysCellView.h"
#import "ZHHTrackInfoModel.h"

@interface ZHHMyJourneysCellView()

@property (weak, nonatomic) IBOutlet UILabel *startTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *bikeIdLab;
@property (weak, nonatomic) IBOutlet UILabel *trackTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *payLab;
@property (weak, nonatomic) IBOutlet UILabel *payIntroLb;

@end

@implementation ZHHMyJourneysCellView

+ (ZHHMyJourneysCellView *)myJourneysCellView {
    ZHHMyJourneysCellView *cell = [[NSBundle mainBundle] loadNibNamed:@"myNibs" owner:nil options:nil][0];
    return cell;
}

- (void)setTrackM:(TrackListModel *)trackM {
    _trackM = trackM;
    self.startTimeLab.text = trackM.startTime;
    self.bikeIdLab.text = trackM.deviceId;
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"yy-MM-dd HH-mm-ss";
    
    NSDate *endDate =  [dateformatter dateFromString:trackM.endTime];
    NSDate *startDate = [dateformatter dateFromString:trackM.startTime];
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:startDate];
    NSInteger min = timeInterval / 60 ;
    NSInteger hour = timeInterval / 3600;
    if(timeInterval < 60) {
        self.trackTimeLab.text = [NSString stringWithFormat:@"%.lf秒",timeInterval];
    } else  if (hour < 1 && min > 0) {
        self.trackTimeLab.text = [NSString stringWithFormat:@"%ld分钟",(long)min];
    } else  if (hour > 0) {
        self.trackTimeLab.text = [NSString stringWithFormat:@"%ld小时",(long)hour];
    }
    if (trackM.cost) {
        self.payLab.text = [NSString stringWithFormat:@"%@元",trackM.cost];
    }
}

- (void)layoutSubviews {
    if(GLOBAL_SCREENW < 375) {
        _payLab.y = _trackTimeLab.y;
        _payIntroLb.y = _trackTimeLab.y;
    }
}
@end
