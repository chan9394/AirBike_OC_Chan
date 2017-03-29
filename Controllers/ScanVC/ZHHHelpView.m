//
//  ZHHHelpView.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/10/27.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHHelpView.h"

@interface ZHHHelpView ()
@property (weak, nonatomic) IBOutlet UIView *bigView;


@end

@implementation ZHHHelpView

+(instancetype)helpView{
    
    ZHHHelpView *view =[[NSBundle mainBundle] loadNibNamed:@"HelpView" owner:nil options:nil].firstObject;
    view.bigView.layer.cornerRadius = 10;
    view.bigView.layer.masksToBounds = YES;
    return view;
    
}



- (IBAction)clickCanlceBtn:(UIButton *)sender {

    [UIView animateWithDuration:0.3 animations:^{
        
        self.transform = CGAffineTransformMakeTranslation(0, -self.height);
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}

@end
