//
//  MenuUserView.h
//  Mobike
//
//  Created by 郑洪浩 on 16/10/13.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuUserViewDelegate <NSObject>


/**
 推出注册登录vc
 */
@optional
-(void)pushRegisterVC;

@end

/*
 MenuView根视图中显示用户个人信息的View
 */

@interface MenuUserView : UIView

/**
 代理,需遵守 MenuUserViewDelegate 协议
 */
@property(nonatomic,weak) id<MenuUserViewDelegate>delegate;


/**
 实例化对象

 @return 实例对象
 */
+(instancetype)userView;
@end
