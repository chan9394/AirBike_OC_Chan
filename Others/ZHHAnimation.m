//
//  ZHHAnimation.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/10.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHAnimation.h"

@implementation ZHHAnimation

/**
 闪烁的动画
 
 @param repeatTimes 重复的次数
 @param time 动画时间
 @return CABasicAnimation
 */
+(CABasicAnimation *)opacityAnimationTimes:(float)repeatTimes durTimes:(float)time{
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"opacity"];
    ani.fromValue = [NSNumber numberWithFloat:1.0];
    ani.toValue = [NSNumber numberWithFloat:0.5];
    ani.repeatCount = repeatTimes;
    ani.duration = time;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    ani.autoreverses = YES;
    return ani;
    
}

/**
 水平方向移动动画
 
 @param repeatTimes 重复次数
 @param time 动画时间
 @return CABisicAnimation
 */
+(CABasicAnimation *)moveXAnimationTimes:(float)repeatTimes durTimes:(float)time x:(float)x{
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    ani.toValue = [NSNumber numberWithFloat:x];
    ani.repeatCount = repeatTimes;
    ani.duration = time;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    ani.autoreverses = YES;
    return ani;
    
}


/**
 垂直方向移动动画
 
 @param repeatTimes 重复次数
 @param time 动画时间
 @return CABisicAnimation
 */
+(CABasicAnimation *)moveYAnimationTimes:(float)repeatTimes durTimes:(float)time y:(float)y{
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    ani.toValue = [NSNumber numberWithFloat:y];
    ani.repeatCount = repeatTimes;
    ani.duration = time;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    ani.autoreverses = YES;
    return ani;
    
}


/**
 点移动动画
 @param point 移动到哪一点
 @return CABisicAnimation
 */
+(CABasicAnimation *)pointAnimation:(CGPoint)point{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.toValue=[NSValue valueWithCGPoint:point];
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
    
}

/**
 缩放动画
 
 @param multiple 缩放结果
 @param orginMultiple 缩放开始
 @param repeatTimes 次数
 @param time 时间长短
 @return CABasicAnimation
 */
+(CABasicAnimation *)scaleAnimation:(NSNumber *)multiple orgin:(NSNumber *)orginMultiple Times:(float)repeatTimes durTimes:(float)time{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=orginMultiple;
    animation.toValue=multiple;
    animation.duration=time;
    animation.autoreverses=YES;
    animation.repeatCount=repeatTimes;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
    
}

/**
 3D旋转动画
 
 @param dur 旋转一次时间
 @param degree 旋转角度
 @param direction 旋转方向
 @param repeatCount 执行次数
 @return CABiscAnimation
 */
+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatcount:(float)repeatCount delegate:(id)delegate{
    
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0,0,direction);//(CGFloat angle, CGFloat x,CGFloat y, CGFloat z)坐标控制旋转方式。
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration= dur;
    animation.autoreverses= NO;//为真时，旋转一次，再按原方向转回去
    animation.cumulative= YES;//为NO时，旋转一次，回到原图再旋转
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.repeatCount= repeatCount;
    animation.delegate= delegate;
    
    return animation;
    
}

/**
 2D旋转动画
 @return CABasicAnimation
 */
+(CABasicAnimation *)animationRotate2delegate:(id)delegate{

    // rotate animation
    CATransform3D rotationTransform  = CATransform3DMakeRotation(M_PI, 1.0, 0, 0.0);
    
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration = 0.5;
    animation.autoreverses = NO;
    animation.cumulative = YES;
    animation.repeatCount = FLT_MAX;  //"forever":FLT_MAX
    //设置开始时间，能够连续播放多组动画
    animation.beginTime = 0.5;
    //设置动画代理
    animation.delegate = delegate;
    
    return animation;

}

/**
 动画组
 
 @param animationAry 要执行的动画组,如果动画设置了beginTime会顺序执行,否则同步执行
 @param times 动画时间
 @param repeatTines 动画次数
 @return CABiscAnimation
 */
+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)times repeatTimes:(float)repeatTines delegate:(id)delegate{
    
    CAAnimationGroup *animation=[CAAnimationGroup animation];
    animation.animations=animationAry;
    animation.duration=times;
    animation.delegate=delegate;
    animation.repeatCount=repeatTines;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
    
}

/**
 转场动画
 
 @return CATransition
 */
+(CAAnimation *)animationRotate{
    
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    
    animation.type = kCATransitionPush;
    //设置4种动画效果 kCATransitionFade淡出kCATransitionMoveIn覆盖原图 kCATransitionPush推出 kCATransitionReveal底部显出来
    
    animation.subtype = kCATransitionFromTop;
    
    //设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
    
    //[animation setType:@"pageCurl"];//pageCurl 向上翻一页, pageUnCurl 向下翻一页, rippleEffect滴水效果 ,suckEffect 收缩效果，如一块布被抽走 ,  cube 立方体效果 ,  oglFlip 上下翻转效果,suckEffect
    
    return animation;
    
}

/**
 路径动画
 
 @param path 路径
 @param times 动画时间
 @return CAKeyframeAnimation
 */
+(CAKeyframeAnimation *)keyframeAnimation:(CGMutablePathRef)path durTimes:(float)times repeatTimes:(float)repeatTimes{
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path=path;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses=NO;
    animation.duration=times;
    animation.repeatCount=repeatTimes;
    return animation;
    
}
@end
