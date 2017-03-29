//
//  ZHHwlaaetDetailCell.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHwlaaetDetailCell.h"
#import "ZHHRechargeModel.h"

@interface ZHHwlaaetDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *resultLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *payWayLab;

@end

@implementation ZHHwlaaetDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

#warning 差退款or充值
- (void)setDetailModel:(RechageDetailModel *)detailModel {
    _detailModel = detailModel;
    NSString *code = @"+";
    if ([detailModel.amount integerValue] < 0) {
        code = @"-";
        self.moneyLab.textColor = GLOBAL_ASSISTCOLOR;
    } else {
        self.moneyLab.textColor = [UIColor colorWithRed:113.0 /255 green:218.0 /255 blue:218.0 / 255 alpha:1];
    }
    self.moneyLab.text = [NSString stringWithFormat:@"%@%@",code,detailModel.amount];
    self.timeLab.text = detailModel.created;
    if ([detailModel.paymentType isEqualToString:@"weixin"]) {
        self.payWayLab.text = @"微信支付";
    } else {
        self.payWayLab.text = @"支付宝支付";
    }
}


@end
