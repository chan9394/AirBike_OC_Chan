//
//  HintModel.m
//  Mobike
//
//  Created by 郑洪浩 on 16/10/13.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "HintModel.h"
#define margin 15
#define maxW GLOBAL_V(375) - margin * 2

@implementation HintModel

+ (instancetype)hintModelWith:(NSDictionary *)dic{
    
    HintModel *model  = [[HintModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    UIImage *image = [[UIImage imageNamed:model.imageStr] scaleImageWithWidth:GLOBAL_V(375) - margin * 2];
    model.image = image;
//    CGSize size =   [model.detail boundingRectWithSize:CGSizeMake(maxW , CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil] context:nil].size;
//    model.modelHeight = image.size.height + size.height + GLOBAL_V(56);
    return model;
}

@end
