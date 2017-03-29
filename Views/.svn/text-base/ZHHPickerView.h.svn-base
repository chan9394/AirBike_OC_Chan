//
//  ZHHPickerView.h
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/2.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHHPickerView;
@protocol ZHHPickerViewDelegate <NSObject>

-(void)pickerView:(ZHHPickerView *)pickerView clickOkBtnWithProvince:(NSString *)province andCity:(NSString *)city andRegion:(NSString *)region;
-(void)pickerViewClickcancleBtn:(ZHHPickerView *)pickerView;
@end

@interface ZHHPickerView : UIView

@property (nonatomic, weak)id <ZHHPickerViewDelegate>delegate;//代理

+(instancetype)pickerView;

@end
