//
//  ThroughTrackInfoView.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/10/19.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ThroughTrackInfoView.h"
#import "ZHHgetCyclingStatusModel.h"

@interface ThroughTrackInfoView ()

@property (assign, nonatomic) CGFloat charge;//费用
@property (strong,nonatomic) NSDate *startDate;
@property (weak, nonatomic) IBOutlet UILabel *chargeLabel;//费用文本框
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//骑行时间文本框
@property (weak, nonatomic) IBOutlet UILabel *deviceIdLab;
@property (weak, nonatomic) IBOutlet UILabel *averagespeedLab;
@property (weak, nonatomic) IBOutlet UILabel *mileageLab;

@end

@implementation ThroughTrackInfoView

+(instancetype)throughTrackInfoView{
    
    ThroughTrackInfoView *view = [[NSBundle mainBundle] loadNibNamed:@"ThroughTrackInfoView" owner:nil options:nil].firstObject;
    return view;
    
}
-(void)setModel:(ZHHgetCyclingStatusModel *)model{
    _model = model;
    self.timeLabel.text =[NSString stringWithFormat:@"%.f分钟",[model.riding_minute floatValue]];
    self.mileageLab.text =[NSString stringWithFormat:@"%.1f公里",[model.mileage floatValue]];
    if([model.riding_minute floatValue] > 0) {
        self.averagespeedLab.text =[NSString stringWithFormat:@"%.1f公里/小时",[model.mileage floatValue] * 60 / [model.riding_minute floatValue]  ];
    }
    self.chargeLabel.text =[NSString stringWithFormat:@"%.1f",[model.cost floatValue]];
    self.deviceIdLab.text =[NSString stringWithFormat:@"%@",model.device_id];

}
- (IBAction)clickUnsettleAcountsBtn:(UIButton *)sender {
    
    if (    [self.delegate respondsToSelector:@selector(pushLoclkFailedVC)]
) {
        [self.delegate pushLoclkFailedVC];
    }
    
}

-(void)removeFromSuperview{
    
    [super removeFromSuperview];
    
}
- (IBAction)clickHowLockBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(showHowToLockView)]) {
        [self.delegate showHowToLockView];
    }
}



@end
