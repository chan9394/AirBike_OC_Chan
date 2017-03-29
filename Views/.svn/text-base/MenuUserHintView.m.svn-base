//
//  MenuUserHintView.m
//  Mobike
//
//  Created by 郑洪浩 on 16/10/13.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "MenuUserHintView.h"
#import "HintModel.h"

@interface MenuUserHintView ()
@property (nonatomic, strong) HintModel *model;
@end

@implementation MenuUserHintView

+(instancetype)initWithTitle:(NSString *)title andImageName:(NSString *)imageName{
    
    MenuUserHintView *view = [[NSBundle mainBundle] loadNibNamed:@"MenuUserHintView" owner:nil options:nil].firstObject;
        view.label.text = title;
        view.imageView.image = [UIImage imageNamed:imageName];
    
    return view;
    
}

+ (instancetype)menuUserHintViewWithHintModel:(HintModel *)model{
    MenuUserHintView *view = [[NSBundle mainBundle] loadNibNamed:@"MenuUserHintView" owner:nil options:nil].firstObject;
    view.label.text = model.title;
    view.model = model;
    UIImage *image = [[UIImage imageNamed:model.imageStr] scaleImageWithWidth:GLOBAL_H(345)];
    view.imageView.image = image;
    view.detailLabel.text = model.detail;
    view.detailLabel.preferredMaxLayoutWidth = GLOBAL_H(345);
    view.imageView.height = image.size.height;
    view.detailLabel.y = CGRectGetMaxY(view.imageView.frame) + 5;
    return view;
}

@end
