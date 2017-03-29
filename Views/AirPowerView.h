//
//  AirPowerView.h
//  AirBk
//
//  Created by Damo on 2017/3/7.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AirPowerViewDelegate <NSObject>

- (void)actionMenuButton:(UIButton *)button index:(NSInteger)index;

@end

@interface AirPowerView : UIView

@property (nonatomic,   weak)  id <AirPowerViewDelegate> delegate;

@end
