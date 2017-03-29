//
//  SearchTopView.m
//  AirBk
//
//  Created by Damo on 2017/2/15.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "SearchTopView.h"

@interface SearchTopView ()

@property (nonatomic,   weak) UIButton                      *allBtn;                        //全选
@property (nonatomic,   weak) UIButton                      *removeBtn;                 //移除
@property (nonatomic,   weak) UIButton                      *editBtn;                      //编辑
@property (nonatomic,   weak) UILabel                        *currentLocationLb;      //当前位置
@property (nonatomic,   weak) UILabel                        *locationLb;                 //当前的地址信息
@property (nonatomic,   weak) UILabel                        *titleLb;                       //弹框中显示的信息

@end

@implementation SearchTopView {
    CGFloat _maxY;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    UILabel *defaultLb = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 50, GLOBAL_V(40))];
    defaultLb.text = @"默认地址";
    defaultLb.textColor = GLOBAL_CONTENTCOLOR;
    defaultLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:defaultLb];
    
    UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(GLOBAL_SCREENW - GLOBAL_H(60), 0,GLOBAL_H(60), defaultLb.height)];
    [editBtn setTitleColor:GLOBAL_CONTENTCOLOR forState:UIControlStateNormal];
    _editBtn = editBtn;
    [self addSubview:editBtn];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(editBtn.frame) - 1, 0, 1,defaultLb.height)];
    lineV.backgroundColor = [UIColor colorWithRed:230.0 / 255 green:230.0 / 255 blue:230.0 / 255 alpha:1];
    [self addSubview:lineV];
    UIView *lineB = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(defaultLb.frame), GLOBAL_SCREENW, 1)];
    lineB.backgroundColor = [UIColor colorWithRed:230.0 / 255 green:230.0 / 255 blue:230.0 / 255 alpha:1];
    [self addSubview:lineB];

    UIView *messageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GLOBAL_SCREENW, CGRectGetMaxY(defaultLb.frame) )];
    messageView.backgroundColor = [UIColor blackColor];
    messageView.alpha = 0.7;
    _messageView = messageView;
    UILabel *titleLb = [[UILabel alloc] initWithFrame:messageView.bounds];
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = [UIColor whiteColor];
    _titleLb = titleLb;
    [messageView addSubview:titleLb];
    messageView.hidden = YES;
    [self addSubview:titleLb];
    
    UILabel *currentLocationLb = [[UILabel alloc] initWithFrame:CGRectMake(editBtn.x, CGRectGetMaxY(lineB.frame) + GLOBAL_H(10), defaultLb.width, GLOBAL_V(30))];
    currentLocationLb.textAlignment = NSTextAlignmentCenter;
    currentLocationLb.text = @"当前位置";
    currentLocationLb.textColor = GLOBAL_CONTENTCOLOR;
    _currentLocationLb = currentLocationLb;
    [self addSubview:currentLocationLb];
    
    UILabel *locationLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(currentLocationLb.frame), currentLocationLb.y, GLOBAL_H(200), currentLocationLb.height)];
    locationLb.textColor = [UIColor darkGrayColor];
    locationLb.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLoca"];
    _maxY = CGRectGetMaxY(locationLb.frame);
    [self addSubview:locationLb];
    
    UIButton *allBtn = [[UIButton alloc] initWithFrame:CGRectMake(_currentLocationLb.x, _currentLocationLb.y, GLOBAL_H(60), currentLocationLb.height)];
    [allBtn addTarget:self action:@selector(actionAllBtn:) forControlEvents:UIControlEventTouchUpInside];
    [allBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [allBtn setTitle:@"全选" forState:UIControlStateNormal];
    _allBtn = allBtn;
    allBtn.hidden = YES;
    [self addSubview:allBtn];
    
    UIButton *removeBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(allBtn.frame), allBtn.y, allBtn.width, allBtn.height)];
    [removeBtn addTarget:self action:@selector(actionRemoveBtn:) forControlEvents:UIControlEventTouchUpInside];
    _removeBtn = removeBtn;
    removeBtn.hidden = YES;
    [removeBtn setTitleColor:GLOBAL_CONTENTCOLOR forState:UIControlStateNormal];
    [removeBtn setTitle:@"移除" forState:UIControlStateNormal];
    [self addSubview:removeBtn];
}

- (void)actionRemoveBtn:(UIButton *)btn {
    
}

- (void)actionAllBtn:(UIButton *)btn {
    
}

- (void)startAnimationWithTitle:(NSString *)title {
        _titleLb.text = title;
        [UIView animateWithDuration:1 animations:^{
            _messageView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0f animations:^{
                _messageView.alpha  = .0f;
            }];
        }];
    
}
@end
