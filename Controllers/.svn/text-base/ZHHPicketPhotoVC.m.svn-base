//
//  ZHHPicketPhotoVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/2.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHPicketPhotoVC.h"

@interface ZHHPicketPhotoVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,assign) BOOL alertVC;

@end


@implementation ZHHPicketPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor clearColor];
    self.alertVC = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    if (!self.alertVC) {
        
        UIAlertController *vc = [[UIAlertController alloc] init];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self getPhoto:NO];
            
        }];
        [vc addAction:action1];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self getPhoto:YES];
            
            
        }];
        [vc addAction:action2];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }];
        
        [vc addAction:cancle];
        //模拟器
#if TARGET_IPHONE_SIMULATOR
        
        //真机
#elif TARGET_OS_IPHONE
        if ([cancle valueForKey:@"titleTextColor"]) {
            [cancle setValue:[UIColor redColor] forKey:@"titleTextColor"];
        }        
#endif

        [self presentViewController:vc animated:YES completion:^{
            
        }];


    }
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.alertVC = YES;
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
    if ([self.delegate respondsToSelector:@selector(hhPickerController:didFinishPickingMediaWithInfo:)]) {
        [self.delegate hhPickerController:self didFinishPickingMediaWithInfo:info];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
     self.alertVC = YES;
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
   
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

-(void)getPhoto:(BOOL) sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //模拟器
#if TARGET_IPHONE_SIMULATOR
    if (!sender) {
        return;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    //真机
#elif TARGET_OS_IPHONE
    if(sender) {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    else {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
#endif

    [self presentViewController:picker animated:YES completion:nil];
}
@end
