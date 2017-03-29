//
//  ZHHLastTrackView.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/10/31.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHLastTrackView.h"
#import "ZHHTrackInfoModel.h"

@interface ZHHLastTrackView ()
@property (weak, nonatomic) IBOutlet UILabel *bakeIdLab;
@property (weak, nonatomic) IBOutlet UILabel *startLab;
@property (weak, nonatomic) IBOutlet UILabel *endLab;

@end
@implementation ZHHLastTrackView

+(instancetype)zhhLastTrackView{
    
    ZHHLastTrackView *vie = [[NSBundle mainBundle] loadNibNamed:@"LastTrackView" owner:nil options:nil].firstObject;
    return vie;
    
}
- (IBAction)clickNeedHelp:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clicktoPushLastTrackTvc)]) {
        [self.delegate clicktoPushLastTrackTvc];
    }
    
}
- (void)setModel:(TrackListModel *)model {
    _model = model;
    self.bakeIdLab.text = @"后台未返回";
    self.startLab.text = model.startTime;
    self.endLab.text = model.endTime;


}
@end
