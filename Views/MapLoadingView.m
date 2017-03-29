//
//  MapLoadingView.m
//  AirBk
//
//  Created by Damo on 16/12/31.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "MapLoadingView.h"
#import "UIImage+ImageEffects.h"

@interface MapLoadingView ()

@property (weak, nonatomic) IBOutlet UIView *containerView;     //弹框

@property (weak, nonatomic) IBOutlet UIImageView *backIv;       //背景模糊效果

@end

@implementation MapLoadingView

+ (instancetype)mapLoadingView {
    MapLoadingView *view = [[NSBundle mainBundle] loadNibNamed:@"MapLoadingView" owner:nil options:nil].firstObject;
    view.tag = 200;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tap:)];
    [view addGestureRecognizer:tap];
    return view;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}

- (void)awakeFromNib {
    [super awakeFromNib ];
    _containerView.layer.cornerRadius = 10;
    [_containerView.layer masksToBounds];
    
//    UIImage *image = [UIImage getScreenImage];
//    image =  [image applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:0.5 alpha:0.2] saturationDeltaFactor:1.8 maskImage:nil];
//    _backIv.image = image;
}
@end
