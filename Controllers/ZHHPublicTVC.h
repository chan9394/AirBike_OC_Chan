//
//  ZHHPublicTVC.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/1.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PublicType) {
    PublicTypeGuide,    //用户指南
    PublicTypeSetting,   //设置
};


@interface ZHHPublicTVC : BaseTC



@property (nonatomic, assign) PublicType type;
@end
