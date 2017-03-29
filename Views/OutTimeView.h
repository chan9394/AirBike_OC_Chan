//
//  OutTimeView.h
//  AirBk
//
//  Created by Damo on 2017/2/15.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  OutTimeViewDelegate <NSObject>

- (void)outTimeRefresh;

@end

@interface OutTimeView : UIView

@property (nonatomic, weak) id <OutTimeViewDelegate> delegate;

@end
