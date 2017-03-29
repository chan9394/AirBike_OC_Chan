//
//  ThemeColorManager.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/26.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ThemeColorManager.h"

@interface ThemeColorManager ()

@property (nonatomic, strong)UIColor *tintColor;//主题颜色

@property (nonatomic, strong)UIColor *assistColor;//辅助色

@property (nonatomic, strong)UIColor *titleColor;   //标题色

@property (nonatomic, strong)UIColor *contentColor; //正文色

@property (nonatomic, strong)UIColor *illustrateColor;       //辅助说明色

@end


@implementation ThemeColorManager

+ (instancetype)shareThemeColorManager {
    static ThemeColorManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[ThemeColorManager alloc] init];
            manager.tintColor = [UIColor colorWithRed:60.0 / 255 green:194.0 / 255 blue:233.0 / 255 alpha:1];
            manager.assistColor = [UIColor colorWithRed:236.0 / 255 green:119.0/255 blue:119.0/255 alpha:1];
            manager.titleColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1];
            manager.contentColor = [UIColor colorWithRed:131.0/255 green:147.0/255 blue:151.0/255 alpha:1];
            manager.illustrateColor = [UIColor colorWithRed:187.0/255 green:187.0/255 blue:187.0/255 alpha:1];
        }
    });
    return manager;
}

@end
