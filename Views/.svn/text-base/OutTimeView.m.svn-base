//
//  OutTimeView.m
//  AirBk
//
//  Created by Damo on 2017/2/15.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "OutTimeView.h"

@interface OutTimeView ()

@property (nonatomic, weak) UILabel                     *titleLb;
@property (nonatomic, weak) UIImageView             *iconIv;

@end

@implementation OutTimeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addSubviews {
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GLOBAL_H(50), GLOBAL_H(50))];
    iv.centerX = self.centerX;
    _iconIv = iv;
    iv.centerY = GLOBAL_SCREENH * 0.2;
    iv.image = [UIImage imageNamed:@"imgs_search_out_time"];
    [self addSubview:iv];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iv.frame) + GLOBAL_V(20), GLOBAL_SCREENW, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = GLOBAL_CONTENTCOLOR;
    _titleLb = label;
    label.text = @"网络连接超时";
    label.font = [UIFont systemFontOfSize:17];
    [self addSubview:label];
    
    UIButton *leftBtn = [self setButtonWithTitle:@"刷新"];
    leftBtn.centerX = self.centerX - 80;
    [leftBtn setCornerRadius];
    [leftBtn addTarget:self action:@selector(actionLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    
    UIButton *rightBtn = [self setButtonWithTitle:@"返回"];
    rightBtn.centerX = self.centerX + 80;
    [rightBtn setCornerRadius];
    [rightBtn addTarget:self action:@selector(actionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
}

- (void)actionLeftBtn:(UIButton *)btn {
    
    if (_iconIv.alpha < 1) {
        return ;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _iconIv.alpha = 0;
        _titleLb.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _iconIv.alpha = 1;
            _titleLb.alpha = 1;
        }];
    }];

    if ([self.delegate respondsToSelector:@selector(outTimeRefresh)]) {
        [self.delegate outTimeRefresh];
    }
}

- (void)actionRightBtn:(UIButton *)btn {
    [self removeFromSuperview];
}

- (UIButton *)setButtonWithTitle:(NSString *)title {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.centerY - GLOBAL_V(50), GLOBAL_H(120), GLOBAL_V(44))];
    btn.layer.borderColor = GLOBAL_THEMECOLOR.CGColor;
    btn.layer.borderWidth = 1.0f;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:GLOBAL_THEMECOLOR forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setupNormalColor:[UIColor whiteColor] highLightedColor:GLOBAL_THEMECOLOR disabledColor:[UIColor lightGrayColor]];
    return btn;
}


@end
