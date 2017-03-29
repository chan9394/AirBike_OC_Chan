//
//  HHProgressHUD.m
//  Mobike
//
//  Created by 郑洪浩 on 16/10/14.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "HHProgressHUD.h"

@implementation HHProgressHUD

+(void)showHUDInView:(UIView *)view animated:(BOOL)abool withText:(NSString *)text{
 
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bounds = CGRectMake(0, 0, 400, 100);
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.width = 100;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];
    
}

+ (void)showHUDWithText:(NSString *)text {
    [self showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:text];
}

+(void)showHudInView:(UIView *)view successFul:(BOOL)abool{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bounds = CGRectMake(0, 0, 400, 100);
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:abool?@"refund_success_img":@"refund_fail_img"]];
    hud.detailsLabel.text =abool?@"成功":@"失败";
    [hud hideAnimated:YES afterDelay:4];
    
}

+ (void)showTitle:(NSString *)string {
    
}
@end
