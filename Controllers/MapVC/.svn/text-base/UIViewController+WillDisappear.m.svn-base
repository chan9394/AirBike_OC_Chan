//
//  UIViewController+WillDisappear.m
//  AirBk
//
//  Created by Damo on 2017/3/10.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "UIViewController+WillDisappear.h"
#import <objc/runtime.h>
#import "RefreshView.h"

typedef void (*_VIMP) (id,SEL,...);
typedef id (* _IMP) (id,SEL,...);

@implementation UIViewController (WillDisappear)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method viewWillDisappear    = class_getInstanceMethod(self, @selector(viewDidLoad));
        _VIMP viewWillDisappear_VIMP   = (_VIMP)class_getMethodImplementation(self, @selector(viewDidLoad));
        method_setImplementation(viewWillDisappear,imp_implementationWithBlock(^(id target,SEL action){
            viewWillDisappear_VIMP(target,@selector(viewDidLoad));
            if ([RefreshView shareRefreshView]) {
                [[RefreshView shareRefreshView] removeFromSuperview];
            }
        }));
        
    });
}



@end
