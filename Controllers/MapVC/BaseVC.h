//
//  BaseVC.h
//  air_bike
//
//  Created by Damo on 16/12/8.
//  Copyright © 2016年 Damo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickNavLefBtnHandle)();

@interface BaseVC : UIViewController

//点击导航栏做端按钮
@property (nonatomic, strong)clickNavLefBtnHandle clickNavLeftBtnHandle;

//返回上一级界面
- (void)clickBackBtn;

//切圆角
- (void)clipCornerRadiusWith:(NSArray <UIView *>*)array;

@end
