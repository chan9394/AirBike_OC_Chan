//
//  RefreshView.m
//  AirBk
//
//  Created by Damo on 2017/2/15.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "RefreshView.h"

@interface RefreshView ()

@property (nonatomic, weak) UIImageView *iconIv;
@property (nonatomic,   weak) UIActivityIndicatorView                        *activityIndicatorView;

@end

@implementation RefreshView {
    CGFloat _height;
}

+ (instancetype)shareRefreshView {
    static RefreshView *view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[RefreshView alloc] initWithFrame:CGRectMake(0, 0.25 *GLOBAL_SCREENH, GLOBAL_SCREENW, GLOBAL_V(100))];
        view.tag = 100;
    });
    return view;
}

+ (instancetype)refreshView {
    RefreshView *view = [[RefreshView alloc] initWithFrame:CGRectMake(0, GLOBAL_V(100), GLOBAL_SCREENW, GLOBAL_V(100))];
    view.tag = 100;
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
        [self startAnimation];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)addSubviews {
    //    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GLOBAL_H(50), GLOBAL_H(50))];
    //    iv.image = [UIImage imageNamed:@"imgs_search_refresh"];
    //    self.iconIv = iv;
    //    _iconIv.centerX = GLOBAL_SCREENW / 2;
    //    [self addSubview:iv];
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.frame = CGRectMake(0, 0, GLOBAL_H(50), GLOBAL_H(50));
    _activityIndicatorView = activityIndicatorView;
    [self addSubview:activityIndicatorView];
    NSLog(@"%@",activityIndicatorView.subviews);
    _activityIndicatorView.centerX = GLOBAL_SCREENW / 2;
    [activityIndicatorView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            obj.frame = _activityIndicatorView.bounds;
        }
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(activityIndicatorView.frame) + GLOBAL_V(20), GLOBAL_SCREENW, GLOBAL_V(30))];
    label.text = @"正在加载中";
    label.textColor = GLOBAL_CONTENTCOLOR;
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _height = CGRectGetMaxY(label.frame);
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)startAnimation {
    //    CABasicAnimation *animaton = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //    animaton.toValue = @(2 *M_PI);
    //    animaton.duration = 2;
    //    animaton.repeatCount = CGFLOAT_MAX;
    //    [self.iconIv.layer addAnimation:animaton forKey:@"iconIv"];
    [_activityIndicatorView startAnimating];
}

@end
