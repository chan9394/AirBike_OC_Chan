//
//  AirPowerView.m
//  AirBk
//
//  Created by Damo on 2017/3/7.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "AirPowerView.h"

@interface AirPowerView ()

@property (nonatomic, strong)    NSArray                         *dataArray;

@end


@implementation AirPowerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self setUpSubViews];
    return self;
}

- (void)setUpSubViews {
    CGFloat height          = 4 * 40 + 1.5;
    CGFloat width           = 100;
    CGFloat x               = GLOBAL_SCREENW - width - 4;
    UIView *containerView   = [[UIView alloc] initWithFrame:CGRectMake(x, 16, width, height)];
    containerView.backgroundColor    = [UIColor whiteColor];
    [self addSubview:containerView];
    
    UIBezierPath *path      = [UIBezierPath bezierPathWithRoundedRect:containerView.bounds cornerRadius:5];
    CAShapeLayer *layer     = [CAShapeLayer layer];
    layer.frame             = containerView.bounds;
    layer.path              = path.CGPath;
    layer.fillColor         = [UIColor whiteColor].CGColor;
    containerView.layer.mask = layer;
   
    
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    CGFloat viewX = CGRectGetMinX(containerView.frame);
    CGFloat viewY = CGRectGetMinY(containerView.frame);
    [trianglePath moveToPoint:CGPointMake(viewX + 66, viewY)];
    [trianglePath addLineToPoint:CGPointMake(viewX + 78, viewY - 12)];
    [trianglePath addLineToPoint:CGPointMake(viewX + 90, viewY)];
    [trianglePath closePath];
    CAShapeLayer *triangleLayer = [CAShapeLayer layer];
    triangleLayer.frame = containerView.bounds;
    triangleLayer.path = trianglePath.CGPath;
    triangleLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:triangleLayer];

    for(int i = 0 ; i < 4; i ++) {
        CGFloat y        = 40 * i + 1;
        CGFloat height   = 40;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, y, width, height)];
        [button setTitle:self.dataArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:GLOBAL_CONTENTCOLOR forState:UIControlStateNormal];
        [button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:button];
        
        button.tag = i;
        
        if (i < 3) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame), width, 0.5)];
            line.backgroundColor = RGB(230, 230, 230);
            [containerView addSubview:line];
        }
    }
}

- (void)actionButton:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(actionMenuButton:index:)]) {
        [_delegate actionMenuButton:btn index:btn.tag];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"开锁问题",
                       @"申请维修",
                       @"锁       定",
                       @"挂       失"];
    }
    return _dataArray;
}

@end
