//
//  AirPowerCell.m
//  AirBk
//
//  Created by Damo on 2017/3/6.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "AirPowerCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width * 0.5 - 40.0f

@interface AirPowerCell ()

@property (weak, nonatomic) IBOutlet UILabel            *topStatusLb;
@property (weak, nonatomic) IBOutlet UILabel            *bottomStatusLb;
@property (weak, nonatomic) IBOutlet UIImageView        *powerIv;
@property (weak, nonatomic) IBOutlet UILabel            *timeLb;
@property (weak, nonatomic) IBOutlet UILabel            *serialNumLb;
@property (weak, nonatomic) IBOutlet UIButton           *introBtn;
@property (weak, nonatomic) IBOutlet UILabel            *titleLb;
@property (weak, nonatomic) IBOutlet UILabel            *messageLb;
@property (weak, nonatomic) IBOutlet UILabel            *personLb;
@property (weak, nonatomic) IBOutlet UILabel            *cityLb;
@property (weak, nonatomic) IBOutlet UILabel            *areaLb;
@property (weak, nonatomic) IBOutlet UILabel            *addressLb;
@property (weak, nonatomic) IBOutlet UILabel            *phoneLb;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressLbLayoutH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageLbLayoutH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noAccreditViewLayoutH;
@property (weak, nonatomic) IBOutlet UIView             *noAccreditView;

@end

@implementation AirPowerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (!_introBtn) {
        return;
    }
    UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:_introBtn.bounds cornerRadius:_introBtn.bounds.size.height];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = _introBtn.bounds;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = GLOBAL_THEMECOLOR.CGColor;
    shapeLayer.path = bezier.CGPath;
    [_introBtn.layer addSublayer:shapeLayer];
    
    _noAccreditViewLayoutH.constant = 1;
    [_noAccreditView setCornerRadiusWithRadius:10];
}

- (void)setStatus:(AirPowerStatus)status {
    _status = status;
    
    if (status >= AirPowerStatusWaitRefundCheck) {
        _introBtn.hidden = YES;
    } else {
        _introBtn.hidden = NO;
    }
    
    if (status == AirPowerStatusRepairCheckFailed) {
        _noAccreditViewLayoutH.constant = 125;
        _noAccreditView.hidden = NO;
    } else {
        _noAccreditViewLayoutH.constant = 0;
        _noAccreditView.hidden = YES;
    }
}

- (IBAction)actionIntroBtn:(id)sender {
    !_introBlock?:_introBlock();
}

- (void)setTopStatus:(NSString *)topStatus {
    _topStatus = topStatus;
    _topStatusLb.text = topStatus;
}

- (void)setBottomStatus:(NSString *)bottomStatus {
    _bottomStatus = bottomStatus;
    _bottomStatusLb.text = bottomStatus;
}

- (void)setImageStr:(NSString *)imageStr {
    _imageStr = imageStr;
    if (imageStr) {
        _powerIv.image = [UIImage imageNamed:imageStr];
    }
}

- (void)setTime:(NSString *)time {
    _time = time;
    _timeLb.text = time;
}

- (void)setSerialNum:(NSString *)serialNum {
    _serialNum = serialNum;
    _serialNumLb.text = serialNum;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLb.text = title;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    _messageLb.text = message;
    _messageLb.textColor = GLOBAL_CONTENTCOLOR;
    
    if (message == nil) {
        _messageLb.text = @"-";
    }
    if ([message containsString:@"."]) {
        _messageLb.text = [NSString stringWithFormat:@"-%@元",message];
        _messageLb.textColor = GLOBAL_ASSISTCOLOR;
    }
    
    CGSize size =  [message boundingRectWithSize:CGSizeMake(kWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:_messageLb.font,NSFontAttributeName, nil] context:nil].size;
    _messageLbLayoutH.constant = size.height;
}

- (void)setPerson:(NSString *)person {
    _person = person;
    _personLb.text = person;
}

- (void)setCity:(NSString *)city {
    _city = city;
    _cityLb.text = city;
}

- (void)setArea:(NSString *)area {
    _area = area;
    _areaLb.text = area;
}

- (void)setAddress:(NSString *)address {
    _address = address;
    _addressLb.text = address;
    if(address == nil) {
        _addressLbLayoutH.constant = 0;
    } else {
        CGSize size =   [address boundingRectWithSize:CGSizeMake(kWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:_addressLb.font,NSFontAttributeName, nil] context:nil].size;
        _addressLbLayoutH.constant = size.height;
    }
}

- (void)setPhone:(NSString *)phone {
    _phone = phone;
    _phoneLb.text = phone;
}

- (void)layoutSubviews {
    _addressLb.preferredMaxLayoutWidth = kWidth;
    _messageLb.preferredMaxLayoutWidth = kWidth;
    [super layoutSubviews];
}
@end
