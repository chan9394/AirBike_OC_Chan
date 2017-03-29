//
//  ScreenScale.m
//  StudyDNA
//
//  Created by Damo on 16/11/20.
//  Copyright © 2016年 Damo. All rights reserved.
//

#import "ScreenScale.h"
CGFloat kCurrentScreenW = 375;
CGFloat kCurrentScrrenH = 667;

@implementation ScreenScale

+ (instancetype)shareScale {
    static ScreenScale *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       instance = [[self  alloc]init];
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        CGFloat scaleH =  width / kCurrentScreenW;
        instance.scaleH = scaleH;
        CGFloat scaleV = height/ kCurrentScrrenH;
        instance.scaleV = scaleV;
    });
    
    return instance;
}
@end
