//
//  UIViewController+NavBar.m
//  air_bike
//
//  Created by Damo on 16/12/6.
//  Copyright © 2016年 Damo. All rights reserved.
//

#import "UIViewController+NavBar.h"
 #import <objc/message.h>

@implementation UIViewController (NavBar)


- (void)setNvLeftBtn:(UIButton *)nvLeftBtn {
    objc_setAssociatedObject(self, "nvLeftBtn", nvLeftBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)nvLeftBtn {
 return  objc_getAssociatedObject(self, "nvLeftBtn");
}

- (void)setNvRightBtn:(UIButton *)nvRightBtn {
    objc_setAssociatedObject(self, "nvRightBtn", nvRightBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)nvRightBtn {
    return objc_getAssociatedObject(self , "nvRightBtn");
}

- (void)setLeftBlock:(void (^)())leftBlock {
    objc_setAssociatedObject(self, @"leftBlock", leftBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)())leftBlock {
    return  objc_getAssociatedObject(self, @"leftBlock");
}

- (void)setRightBlock:(void (^)())rightBlock {
    objc_setAssociatedObject(self, @"rightBlock", rightBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)())rightBlock {
    return objc_getAssociatedObject(self, @"rightBlock");
}

- (void)setupNavigationRightItemWithTitle:(NSString *)title {
    [self setupNavigationRightItemWithTitle:title font:15];
//    [self setupNavigationLeftItemWithTitle:nil leftBlock:nil rightTitle:title rightBlock:nil];
}

- (void)setupNavigationRightItemWithTitle:(NSString *)title block:(void(^)())block {
    [self setupNavigationLeftItemWithTitle:nil leftBlock:nil rightTitle:title rightBlock:block];
}

- (void)setupNavigationRightItemWithImage:(NSArray<NSString *> *)imgNameArr {
    [self setupNavigationItemWithLeftImages:nil leftBlock:nil rightimages:imgNameArr rightBlock:nil];
}

- (void)setupNavigationRightItemWithImage:(NSArray <NSString *>*)imgNameArr block:(void(^)())block {
     [self setupNavigationItemWithLeftImages:nil leftBlock:nil rightimages:imgNameArr rightBlock:block];
}

- (void)setupNavigatonLeftItemWithTitle:(NSString *)title {
    [self setupNavigationLeftItemWithTitle:title leftBlock:nil rightTitle:nil rightBlock:nil];
}

- (void)setupNavigatonLeftItemWithTitle:(NSString *)title block:(void (^)())block {
    [self setupNavigationLeftItemWithTitle:title leftBlock:block rightTitle:nil rightBlock:nil];
}

- (void)setupNavigationItemWithLeftImages:(NSArray *)leftImgs rightimages:(NSArray *)rightImgs {
    [self setupNavigationItemWithLeftImages:leftImgs leftBlock:nil rightimages:rightImgs rightBlock:nil];
}

- (void)setupNavigationLeftItemNil {
    UIButton *button = [[UIButton alloc] init];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setupNavigationLeftItemWithTitle:(NSString *)leftTitle
                               leftBlock:(void (^)())leftBlock
                              rightTitle:(NSString *)rightTitle
                              rightBlock:(void(^)())rightBlock {
    if (rightTitle) {
        UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        right.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [right setTitle:rightTitle forState:UIControlStateNormal];
        right.titleLabel.font = [UIFont systemFontOfSize:15];
        [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:right];
        self.navigationItem.rightBarButtonItem = rightItem;
        self.nvRightBtn = right;
    }
    if (rightBlock) {
        self.rightBlock = rightBlock;
        [self.nvRightBtn addTarget:self action:@selector(actionNvRightBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //左
    if (leftTitle) {
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [leftBtn setImage:[UIImage imageNamed:@"imgs_menu_arrow_left"] forState:UIControlStateNormal];
        [leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        self.navigationItem.leftBarButtonItem = leftItem;
        self.nvLeftBtn = leftBtn;
    }
    
    if (leftBlock) {
        self.leftBlock = leftBlock;
        [self.nvLeftBtn addTarget:self action:@selector(actionNvLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setupNavigationRightItemWithTitle:(NSString *)title font:(CGFloat)font {
    UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    right.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [right setTitle:title forState:UIControlStateNormal];
    right.titleLabel.font = [UIFont systemFontOfSize:font];
    [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = item;
    self.nvRightBtn = right;
}

- (void)setupNavigationItemWithLeftImages:(NSArray *)leftImgs
                                leftBlock:(void(^)())leftBlock
                              rightimages:(NSArray *)rightImgs
                               rightBlock:(void(^)())rightBlock {
    if (leftImgs) {
        UIButton *left =  [self setupButtonWith:leftImgs ];
        left.frame = CGRectMake(0, 0, 17, 30);
        self.nvLeftBtn = left;
        UIBarButtonItem *lItem = [[UIBarButtonItem alloc] initWithCustomView:left];
        self.navigationItem.leftBarButtonItem = lItem;
    }
    
    if (leftBlock) {
        self.leftBlock = leftBlock;
        [self.nvLeftBtn addTarget:self action:@selector(actionNvLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if(rightImgs) {
        UIButton *right = [self setupButtonWith:rightImgs];
        self.nvRightBtn = right;
        UIBarButtonItem *RItem = [[UIBarButtonItem alloc] initWithCustomView:right];
        self.navigationItem.rightBarButtonItem = RItem;
    }
    if(rightBlock) {
        self.rightBlock = rightBlock;
        [self.nvRightBtn addTarget:self action:@selector(actionNvRightBtn) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (UIButton * )setupButtonWith:(NSArray *)images {
    UIButton *button = [[UIButton alloc] init];
    button.bounds = CGRectMake(0, 0, 35, 35);
    if (images) {
        UIImage *nomalIl = [UIImage imageNamed:images[0]];
        [button setImage:nomalIl forState:UIControlStateNormal];
        if (images.count == 2) {
            UIImage *pressIl = [UIImage imageNamed:images[1]];
            [button setImage:pressIl forState:UIControlStateHighlighted];
        }
    }
    return button;
}

- (void)actionNvLeftBtn {
    if (self.leftBlock) {
        self.leftBlock();
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)actionNvRightBtn {
    if (self.rightBlock) {
        self.rightBlock();
    }
}

- (void)setupTitleViewWithImage:(NSString *)image frame:(CGRect)rect {
    UIImage *imageLogo = [[UIImage imageNamed:image] scaleImageWithWidth:rect.size.width];
//#warning 后期有图删除
//    imageLogo = [imageLogo imageWithTintColor:[UIColor whiteColor]];
    UIImageView *logView = [[UIImageView alloc] init];
    logView.image = imageLogo;
    logView.frame = rect;
    self.navigationItem.titleView = logView;
}

- (void)setupTitleViewWithImage:(NSString *)image  {
    [self setupTitleViewWithImage:image frame:CGRectMake(0, 0, 100, 20)];
}

- (void)setupTitleWithText:(NSString *)text  {
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    titleView.text = text;
    titleView.textColor = [UIColor whiteColor];
    titleView.font =  [UIFont systemFontOfSize:17];
    self.navigationItem.titleView = titleView;
}

- (void)removeShadow {
    //自定义一个
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //    //消除阴影
        self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)recoverShadow {
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
@end
