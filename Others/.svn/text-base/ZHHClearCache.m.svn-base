//
//  ZHHClearCache.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/11.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHClearCache.h"

@interface ZHHClearCache () <ReminderViewDelegate>

@end

@implementation ZHHClearCache {
    UIViewController *_vc;
}

// 计算目录大小
+ (CGFloat)folderSizeAtPath:(NSString *)path
{
    // 利用NSFileManager实现对文件的管理</span>
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
        // 获取该目录下的文件，计算其大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        // 将大小转化为M  
        return size / 1024.0 / 1024.0;   
    }
    
    return 0;
}

// 根据路径删除文件
+ (void)cleanCaches:(NSString *)path
{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }  
}
+ (void)cleanCaches
{
    
    [ZHHClearCache cleanCaches:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject];
    [ZHHClearCache cleanCaches:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject];
    [ZHHClearCache cleanCaches:NSTemporaryDirectory()];
}

// 清除缓存

- (void)setupClearView {
    ReminderView *view = [ReminderView reminderViewWithMessage:@"是否确定清理本地缓存数据" leftBtnTitle:@"清除" rightBtnTitle:@"取消"];
    view.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (void)reminderViewDidClickLeftBtn {
    [ZHHClearCache cleanCaches];
    [HHProgressHUD showHUDWithText:@"清理缓存成功"];
}

+ (void)showAlertVCInVC:(UIViewController *)vc {
    
    CGFloat size = [ZHHClearCache folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject] +
    [ZHHClearCache folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject] +
    [ZHHClearCache folderSizeAtPath:NSTemporaryDirectory()];

    NSString *message = size > 1 ? [NSString stringWithFormat:@"缓存%.2fM, 删除缓存", size] : [NSString stringWithFormat:@"缓存%.2fK, 删除缓存", size * 1024.0];

    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [self cleanCaches];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:action];
    [alert addAction:cancel];
    [vc showDetailViewController:alert sender:nil];
  
}

@end
