//
//  UIImage+Extension.h
//  温锐教育DNA
//
//  Created by 朱玉龙 on 16/11/13.
//  Copyright © 2016年 朱玉龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

//缩小图片
- (UIImage *)scaleImageWithWidth:(CGFloat)width;

//切圆角
- (UIImage *)drawRctWithRoundCorner:(CGFloat)radius andSize:(CGSize) aSize;

//从颜色中获取图片
+ (UIImage *)imageFromColor:(UIColor *)color;

//模糊
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

//当前屏幕的模糊图像
+ (UIImage *)getBlurImge;

//模糊效果好,耗时长,在子线程执行
+ (void)setBlurImgeWithImageView:(UIImageView *)imageView;

//截取当前屏幕
+ (UIImage *)getScreenImage;

+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

@end
