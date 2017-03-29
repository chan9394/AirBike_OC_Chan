 //
//  ZHHBikingResultVCView.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/7.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHBikingResultVCView.h"
#import "ZHHTrackFinishModel.h"
@interface ZHHBikingResultVCView ()
@property (weak, nonatomic) IBOutlet UILabel *payLabBig;
@property (weak, nonatomic) IBOutlet UILabel *payLabSma;
@property (weak, nonatomic) IBOutlet UILabel *costTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *myWallLab;

@end

@implementation ZHHBikingResultVCView


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setupTitleWithText:@"骑行结束页"];

}
-(void)setTrackMocel:(ZHHTrackFinishModel *)trackMocel{
    _trackMocel = trackMocel;
    self.payLabBig.text = [NSString stringWithFormat:@"成功支付 %.2f元",[self.trackMocel.cost floatValue]];
    self.payLabSma.text = [NSString stringWithFormat:@"%.1f元",[self.trackMocel.cost floatValue]];
    CGFloat min = [self.trackMocel.riding_minute floatValue] + 0.5;
    self.costTimeLab.text = [NSString stringWithFormat:@"%.f分钟",min];
}
-(void)clickBackBtn{
    
    [self.navigationController popViewControllerAnimated:YES];

}

@end
