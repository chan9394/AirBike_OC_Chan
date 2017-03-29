//
//  ReminderView.m
//  AirBk
//
//  Created by Damo on 16/12/28.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ReminderView.h"
#import <objc/runtime.h>
#import "UIImage+ImageEffects.h"

typedef NS_ENUM(NSInteger,ReminderViewType) {
    ReminderViewTypeDoubleBtn = 0,
    ReminderViewTypeSingleBtn
};

@interface ReminderView ()

@property (weak, nonatomic) IBOutlet UILabel               *messageLb;       //中间显示的信息
@property (weak, nonatomic) IBOutlet UIButton              *leftBtn;         //左侧的按钮
@property (weak, nonatomic) IBOutlet UIButton              *rightBtn;        //右侧的按钮
@property (weak, nonatomic) IBOutlet UIView                *containerView;   //弹框
@property (weak, nonatomic) IBOutlet UIImageView           *backIv;          //背景模糊效果
@property (weak, nonatomic) IBOutlet UIButton              *singleBtn;       //单个button
@property (weak, nonatomic) IBOutlet UILabel               *titleLb;         //消息栏上部
@property (weak, nonatomic) IBOutlet UILabel               *detailLb;        //消息栏细节
@property (weak, nonatomic) IBOutlet UIImageView           *iv;
@property (weak, nonatomic) IBOutlet UILabel               *singleTitleLb;   //单个按钮的上部
@property (weak, nonatomic) IBOutlet UILabel               *singleDetailLb;  //单个按钮的细节
@property (weak, nonatomic) IBOutlet NSLayoutConstraint    *ivLayoutH;       //图片的高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint    *ivLayoutW;       //图片的宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint    *detailLbLayoutH; //细节的高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint    *rightBtnLayoutW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint    *leftBtnLayoutW;
@property (nonatomic, copy) void(^leftBlock)();
@property (nonatomic, copy) void(^rightBlock)();

@end

@implementation ReminderView

+ (instancetype)reminderViewWithMessage:(NSString *)message
                           leftBtnTitle:(NSString *)leftTitle
                          rightBtnTitle:(NSString *)rightTitle{
  return  [self reminderViewWithMessage:message title:nil detail:nil leftBtnTitle:leftTitle leftBtnBackgroundColor:nil rightBtnTitle:rightTitle type:ReminderViewTypeDoubleBtn];
}

+ (instancetype)reminderViewWithMessage:(NSString *)message btnTitle:(NSString *)title {
    return [self reminderViewWithMessage:message title:nil detail:nil leftBtnTitle:title leftBtnBackgroundColor:nil rightBtnTitle:nil type:ReminderViewTypeSingleBtn];
}

+ (instancetype)reminderViewWithMessage:(NSString *)message
                                  title:(NSString *)title
                                 detail:(NSString *)detail
                           leftBtnTitle:(NSString *)leftTitle
                 leftBtnBackgroundColor:(UIColor *)leftColor
                          rightBtnTitle:(NSString *)rightTitle{
    ReminderViewType type = ReminderViewTypeDoubleBtn;
    if (!rightTitle) {
        type = ReminderViewTypeSingleBtn;
    }
    return [self reminderViewWithMessage:message title:title detail:detail leftBtnTitle:leftTitle leftBtnBackgroundColor:leftColor rightBtnTitle:rightTitle type:type];
}

+ (instancetype)reminderViewWithtitle:(NSString *)title
                               detail:(NSString *)detail
                         leftBtnTitle:(NSString *)leftTitle
               leftBtnBackgroundColor:(UIColor *)leftColor
                            leftBlock:(void(^)())leftBlock
                        rightBtnTitle:(NSString *)rightTitle
                           rightBlock:(void(^)())rightBlock {
    ReminderView *view = [self reminderViewWithMessage:nil title:title detail:detail leftBtnTitle:leftTitle leftBtnBackgroundColor:leftColor rightBtnTitle:rightTitle];
    if (leftBlock) {
        view.leftBlock = leftBlock;
    }
    if (rightBlock) {
        view.rightBlock = rightBlock;
    }
    return view;
}

+ (instancetype)reminderViewWithMessage:(NSString *)message
                                  title:(NSString *)title
                               detail:(NSString *)detail
                         leftBtnTitle:(NSString *)leftTitle
               leftBtnBackgroundColor:(UIColor *)leftColor
                        rightBtnTitle:(NSString *)rightTitle
                                   type:(ReminderViewType)type {
    ReminderView *view = [[NSBundle mainBundle] loadNibNamed:@"ReminderView" owner:nil options:nil][type];
    [view bringSubviewToFront:view.containerView];
    view.frame = [UIApplication sharedApplication].keyWindow.bounds;
    if (message) {
        view.messageLb.text = message;
    }
    if (title) {
        view.titleLb.text = title;
    }
    if (detail) {
        view.detailLb.text = detail;
    }
    if (leftTitle) {
        [view.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
    }
    if (rightTitle) {
        [view.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
    }
    if (leftColor) {
        [view.leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
    }
    return view;
}

+ (instancetype)reminderViewWithtitle:(NSString *)title
                           titleColor:(UIColor *)titleColor
                               detail:(NSString *)detail
                            imageName:(NSString *)imageName
                         leftBtnTitle:(NSString *)leftBtnTitle
                         leftBtnColor:(UIColor *)leftColor
                            leftBlock:(void(^)())leftBlock
                        rightBtnTitle:(NSString *)rightBtnTitle
                        rightBtnColor:(UIColor *)rightColor
                           rightBlock:(void (^)())rightBlock {
    ReminderView *view = [[NSBundle mainBundle] loadNibNamed:@"ReminderView" owner:nil options:nil][2];
    [view bringSubviewToFront:view.containerView];
    view.frame = [UIApplication sharedApplication].keyWindow.bounds;
    
    view.titleLb.text = title;
    view.detailLb.text = detail;
    [view.leftBtn setTitle:leftBtnTitle forState:UIControlStateNormal];
    [view.rightBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
    
    view.leftBlock = leftBlock;
    view.rightBlock = rightBlock;
    
    if(imageName) {
        UIImage *image = [UIImage imageNamed:imageName];
        view.iv.image = image;
        if ([imageName containsString:@"money"]) {
            view.ivLayoutH.constant = 50;
            view.ivLayoutW.constant = 45;
        }
    } else {
        view.ivLayoutH.constant = 0;
    }
    if (!view.detailLb.text) {
        view.detailLbLayoutH.constant = 0;
    }
    if (!rightBtnTitle) {
        view.rightBtnLayoutW.constant = 0;
        view.leftBtnLayoutW.constant = 260;
    }
    if (leftColor) {
        [view.leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
    }
    if (rightColor) {
        [view.rightBtn setTitleColor:rightColor forState:UIControlStateNormal];
    }
    if (titleColor) {
        view.titleLb.textColor = titleColor;
    }
    
    return view;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    _containerView.layer.cornerRadius = 10;
    [_containerView.layer masksToBounds];
    UIImage *image = [UIImage getScreenImage];
    image =  [image applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:0.3 alpha:0.2] saturationDeltaFactor:1.8 maskImage:nil];
    _backIv.image = image;
}

- (IBAction)actionLeftBtn:(id)sender {
    if ([_delegate respondsToSelector:@selector(reminderViewDidClickLeftBtn)]) {
        [_delegate reminderViewDidClickLeftBtn];
    }
    !_leftBlock?:_leftBlock();
    [self removeFromSuperview];
}

- (IBAction)actionRightBtn:(id)sender {
    if ([_delegate respondsToSelector:@selector(reminderViewDidClickRightBtn)]) {
        [_delegate reminderViewDidClickRightBtn];
    }

    !_rightBlock?:_rightBlock();
    
    [self removeFromSuperview];
}

- (IBAction)actionSingleBtn:(id)sender {
    if ([_delegate respondsToSelector:@selector(reminderViewDidClickLeftBtn)]) {
        [_delegate reminderViewDidClickLeftBtn];
    }
    [self removeFromSuperview];
}


@end
