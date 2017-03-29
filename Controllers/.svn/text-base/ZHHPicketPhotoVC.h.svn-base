//
//  ZHHPicketPhotoVC.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/2.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHHPicketPhotoVC;

@protocol ZHHPicketPhotoVCDelegate <NSObject>

/**
 已经选择好图片

 @param picker 图片选择器
 @param info 选中的图片信息
 */
- (void)hhPickerController:(ZHHPicketPhotoVC *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;

@end


@interface ZHHPicketPhotoVC : UIViewController

/**
 代理,需遵守ZHHPicketPhotoVCDelegate协议
 */
@property (nonatomic,weak) id <ZHHPicketPhotoVCDelegate> delegate;

@end
