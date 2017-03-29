//
//  MenuUserHintView.h
//  Mobike
//
//  Created by 郑洪浩 on 16/10/13.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HintModel;

/*
 MenuView根视图中显示单车使用说明的View
 */

@interface MenuUserHintView : UIView

/**
 显示文字
 */
@property (weak, nonatomic) IBOutlet UILabel *label;

/**
 详细信息
 */
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

/**
 显示图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**
 初始化实例对象

 @param title 标题
 @param imageName 图片名
 @return 实例对象
 */
+(instancetype)initWithTitle:(NSString *)title andImageName:(NSString *)imageName;

/**
 通过模型创建实例对象

 @param model hint模型
 @return 实例对象
 */
+(instancetype)menuUserHintViewWithHintModel:(HintModel *)model;
@end
