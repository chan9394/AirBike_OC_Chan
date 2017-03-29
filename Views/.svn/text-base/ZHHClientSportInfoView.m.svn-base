//
//  ZHHClientSportInfo.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/3.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHClientSportInfoView.h"
#import "ZHHLogModel.h"

@interface ZHHClientSportInfoView()

@property (weak, nonatomic) IBOutlet UILabel *totalKmLa;
@property (weak, nonatomic) IBOutlet UILabel *totalCo2La;
@property (weak, nonatomic) IBOutlet UILabel *totalCalLa;

@end


@implementation ZHHClientSportInfoView

+(instancetype)clientSportInfo{
    
    ZHHClientSportInfoView *view = [[NSBundle mainBundle] loadNibNamed:@"ClientSportInfoView" owner:nil options:nil].firstObject;
    return view;
    
}

-(void)setUser:(ZHHLogModel *)user{
    
    _user = user;
    self.totalKmLa.text = [NSString stringWithFormat:@"%@",[user mileage]];
    self.totalCalLa.text = [NSString stringWithFormat:@"%@",[user calorie]];
    self.totalCo2La.text = [NSString stringWithFormat:@"%@",[user carbon_emission]];
    
    
}

@end
