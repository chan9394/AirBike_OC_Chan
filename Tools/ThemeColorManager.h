//
//  ThemeColorManager.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/26.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeColorManager : NSObject

@property (readonly,nonatomic, strong)UIColor *tintColor;//主题颜色

@property (readonly,nonatomic, strong)UIColor *assistColor;//辅助色

@property (readonly,nonatomic, strong)UIColor *titleColor;   //标题色

@property (readonly,nonatomic, strong)UIColor *contentColor; //正文色

@property (readonly,nonatomic, strong)UIColor *illustrateColor;       //辅助说明色

+ (instancetype)shareThemeColorManager;

@end
