//
//  HHProgressHUD.m
//  Mobike
//
//  Created by 郑洪浩 on 16/10/14.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ProgressHUD.h"

@implementation ProgressHUD

+ (void)showHUDInView:(UIView *)view animated:(BOOL)abool withText:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.width = 100;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:3];
}

+ (void)showHudInView:(UIView *)view success:(BOOL)abool {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:abool?@"imgs_scan_success":@"imgs_scan_faile"]];
    hud.detailsLabel.text =abool?@"成功":@"失败";
    [hud hideAnimated:YES afterDelay:4];
}

@end
