//
//  UIImageView+Extentsion.m
//  AirBk
//
//  Created by Damo on 16/12/26.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "UIImageView+Extentsion.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (Extentsion)

- (void)setImage:(UIImage *)image radius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius] addClip];
    [image drawInRect:self.bounds];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (void)loadImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius {
    NSURL *url;
    if (placeHolderStr == nil) {
        placeHolderStr = @"imgs_menu_person";
    }
    
    //这里传CGFLOAT_MIN，就是默认以图片宽度的一半为圆角
    if (radius == CGFLOAT_MIN) {
        radius = self.frame.size.width/2.0;
    }
    
    url = [NSURL URLWithString:urlStr];
    
    if (radius != 0.0) {
        //头像需要手动缓存处理成圆角的图片
        NSString *cacheurlStr = [urlStr stringByAppendingString:@"radiusCache"];
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlStr];
        if (cacheImage) {
            self.image = cacheImage;
        }
        else {
            [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeHolderStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error) {
//                    UIImage *radiusImage = [UIImage createRoundedRectImage:image size:self.frame.size radius:radius];
                    UIImage *radiusImage = [image scaleImageWithWidth:radius *2];
                    radiusImage = [radiusImage drawRctWithRoundCorner:radius andSize:CGSizeMake(radius * 2, radius * 2)];
                    self.image = radiusImage;
                    [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:cacheurlStr];
                    //清除原有非圆角图片缓存
                    [[SDImageCache sharedImageCache] removeImageForKey:urlStr];
                }
            }];
        }
    }
    else {
        [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeHolderStr] completed:nil];
    }
}

@end
