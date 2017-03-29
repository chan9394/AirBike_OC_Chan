//
//  MenuHeaderView.h
//  Mobike
//
//  Created by 郑洪浩 on 16/10/13.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuHeaderViewDelegate <NSObject>

/**
 推出用户信息vc
 */
-(void)menuVCPushUserInfoVC;
-(void)refreshMenuHeaderView;
-(void)pushCredcitVC;

/**
 推出登录vc
 */
-(void)pushLoginVC;

@end

/*
 MenuView中tableView的头视图,展示个人信息和单车使用说明
 */

@interface MenuHeaderView : UIView

/**
 代理,需要遵守MenuHeaderViewDelegate协议
 */
@property(nonatomic,weak) id<MenuHeaderViewDelegate>delegate;

/**
 设置子视图
 */
- (void)setSubViews;

- (void)refreshSubView;

@end
