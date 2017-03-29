//
//  ZHHAnimation.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/10.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHHAnimation : NSObject

/**
 闪烁的动画
 
 @param repeatTimes 重复的次数
 @param time 动画时间
 @return CABasicAnimation
 */
+(CABasicAnimation *)opacityAnimationTimes:(float)repeatTimes durTimes:(float)time;

/**
 水平方向移动动画

 @param repeatTimes 重复次数
 @param time 动画时间
 @return CABisicAnimation
 */
+(CABasicAnimation *)moveXAnimationTimes:(float)repeatTimes durTimes:(float)time x:(float)x;


/**
 垂直方向移动动画
 
 @param repeatTimes 重复次数
 @param time 动画时间
 @return CABisicAnimation
 */
+(CABasicAnimation *)moveYAnimationTimes:(float)repeatTimes durTimes:(float)time y:(float)y;


/**
 点移动动画
 @param point 移动到哪一点
 @return CABisicAnimation
 */
+(CABasicAnimation *)pointAnimation:(CGPoint)point;

/**
 缩放动画

 @param multiple 缩放结果
 @param orginMultiple 缩放开始
 @param repeatTimes 次数
 @param time 时间长短
 @return CABasicAnimation
 */
+(CABasicAnimation *)scaleAnimation:(NSNumber *)multiple orgin:(NSNumber *)orginMultiple Times:(float)repeatTimes durTimes:(float)time ;

/**
 3D旋转动画

 @param dur 旋转一次时间
 @param degree 旋转角度
 @param direction 旋转方向
 @param repeatCount 执行次数
 @return CABiscAnimation
 */
+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatcount:(float)repeatCount delegate:(id)delegate;


/**
 2D旋转动画
 @return CABasicAnimation
 */
+(CABasicAnimation *)animationRotate2delegate:(id)delegate;

/**
 动画组

 @param animationAry 要执行的动画组,如果动画设置了beginTime会顺序执行,否则同步执行
 @param times 动画时间
 @param repeatTines 动画次数
 @return CABiscAnimation
 */
+(CABasicAnimation *)groupAnimation:(NSArray *)animationAry durTimes:(float)times repeatTimes:(float)repeatTines delegate:(id)delegate;


/**
 转场动画

 @return CATransition
 */
+(CAAnimation *)animationRotate;

/**
 路径动画

 @param path 路径
 @param times 动画时间
 @return CAKeyframeAnimation
 */
+(CAKeyframeAnimation *)keyframeAnimation:(CGMutablePathRef)path durTimes:(float)times repeatTimes:(float)repeatTimes;

@end
