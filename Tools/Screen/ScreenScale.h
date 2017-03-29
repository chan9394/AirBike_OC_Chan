//
//  ScreenScale.h
//  StudyDNA
//
//  Created by Damo on 16/11/20.
//  Copyright © 2016年 Damo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ScreenScale : NSObject

//屏幕的水平比例饿
@property(nonatomic,assign) CGFloat scaleH;

//屏幕的垂直比例
@property(nonatomic,assign) CGFloat scaleV;

//快速创建像
+ (instancetype) shareScale;

@end
