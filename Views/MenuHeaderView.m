//
//  MenuHeaderView.m
//  Mobike
//
//  Created by 郑洪浩 on 16/10/13.
//  Copyright © 2016年 ZHH. All rights reserved.
//
#import "MenuHeaderView.h"
#import "MenuUserHintView.h"
#import "MenuUserView.h"
#import "ZHHClientSportInfoView.h"
#import "HintModel.h"
#import "MenuUserViewLoged.h"

@interface MenuHeaderView ()<MenuUserViewDelegate,MenuUserViewLogedDelegate>

@property (nonatomic, weak) MenuUserView          *userView;            //注册/登录
@property (nonatomic, weak) MenuUserViewLoged *userViewLoged;   //用户信息
@property (nonatomic, weak) UIView                      *viewbig;              //网络
@end

@implementation MenuHeaderView

- (instancetype)init {
    if (self = [super init]) {
        [self setSubViews];
    }
    return self;
}

- (void)setSubViews {
    MenuUserViewLoged *userLogedView = [MenuUserViewLoged menuUserViewLoged];
    userLogedView.delegate =self;
    _userViewLoged = userLogedView;
    CGFloat scale = self.width/userLogedView.width;
    userLogedView.width = self.width;
    userLogedView.height = userLogedView.height *scale;
    [self addSubview:userLogedView];
    self.height = CGRectGetMaxY(userLogedView.frame);
    
    __weak typeof(self) weakSelf = self;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变时调用
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                GLOBAL_ISREGFRESH = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                GLOBAL_ISREGFRESH = YES;
                if (weakSelf.viewbig) {
                    break;
                }
                
                UIView *viewBig = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(userLogedView.frame), weakSelf.width, 110)];
                viewBig.backgroundColor = [UIColor colorWithRed:235/255.0 green:119/255.0 blue:119/255.0 alpha:1];
                
                CGFloat imageViewH =  viewBig.height/3;
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewH/2, 0.5*(viewBig.height - imageViewH), imageViewH/7*9, imageViewH)];
                imageView.image = [UIImage imageNamed:@"imgs_menu_unnetwork"];
                [viewBig addSubview:imageView];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, 0, viewBig.width-imageView.width, viewBig.height)];
                label.text = @"当前网络无反应,请检查您的网络设置";
                label.textColor = [UIColor whiteColor];
                label.font = [UIFont systemFontOfSize:17];
                [viewBig addSubview:label];
                
                weakSelf.viewbig = viewBig;
                [weakSelf addSubview:viewBig];
                weakSelf.height = CGRectGetMaxY(viewBig.frame);
                NSLog(@"没有网络");
                [weakSelf callDelegateRefresh];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:
                if (weakSelf.viewbig) {
                    [weakSelf.viewbig removeFromSuperview];
                    weakSelf.height = CGRectGetMaxY(userLogedView.frame);
                }
                
                [weakSelf callDelegateRefresh];
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                if (weakSelf.viewbig) {
                    [weakSelf.viewbig removeFromSuperview];
                    weakSelf.height = CGRectGetMaxY(userLogedView.frame);
                }
                
                [weakSelf callDelegateRefresh];
                NSLog(@"WIFI");
                break;
        }
    }];
    //开始监控
    [manager startMonitoring];
    //    }
}

- (void)refreshSubView {
    if (_userViewLoged) {
        [_userViewLoged setSubViews];
    }
}

//- (void)pushRegisterVC {
//    if ([self.delegate respondsToSelector:@selector(pushLoginVC)]) {
//        [self.delegate pushLoginVC];
//    }
//}

- (void)pushCredcitVC {
    if ([self.delegate respondsToSelector:@selector(pushCredcitVC)]) {
        [self.delegate pushCredcitVC];
    }
}

- (void)menuVCPushUserInfoVC {
    if ([self.delegate respondsToSelector:@selector(menuVCPushUserInfoVC)]) {
        [self.delegate menuVCPushUserInfoVC];
    }
}

- (void)callDelegateRefresh {
    if ([self.delegate respondsToSelector:@selector(refreshMenuHeaderView)]) {
        [self.delegate refreshMenuHeaderView];
    }
}

@end
