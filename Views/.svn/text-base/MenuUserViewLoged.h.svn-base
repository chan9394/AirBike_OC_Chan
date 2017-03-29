//
//  MenuUserViewLoged.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/30.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuUserViewLogedDelegate <NSObject>

//用户信息
- (void)menuVCPushUserInfoVC;
//信用中心
- (void)pushCredcitVC;

@end

@interface MenuUserViewLoged : UIView

@property (nonatomic, weak)id <MenuUserViewLogedDelegate>delegate;//代理

//快速创建对象
+ (instancetype)menuUserViewLoged;

//设置视图
- (void)setSubViews;

@end
