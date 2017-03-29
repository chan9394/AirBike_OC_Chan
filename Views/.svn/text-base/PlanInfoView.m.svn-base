//
//  PlanInfoView.m
//  Mobike
//
//  Created by 郑洪浩 on 16/10/14.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "PlanInfoView.h"
#import "AccountManager.h"
#define orderBtnH GLOBAL_V(44.0)
@interface PlanInfoView()

@property (weak, nonatomic) IBOutlet UILabel   *bikeNum;              //可用自行车数量
@property (weak, nonatomic) IBOutlet UILabel   *distanceLab;         //距离
@property (weak, nonatomic) IBOutlet UILabel   *durationLab;
@property (weak, nonatomic) IBOutlet UILabel   *titleLabel;             //目的地名称
@property (weak, nonatomic) IBOutlet UIButton *unChargeingBtn;

@end

@implementation PlanInfoView

+ (instancetype)planInfoView{
    
    PlanInfoView *view = [[NSBundle mainBundle] loadNibNamed:@"PlanInfoView" owner:nil options:nil].firstObject;
    [view layoutIfNeeded];
//    view.orderBtn.layer.cornerRadius = view.orderBtn.height / 2;
//    [view.orderBtn.layer masksToBounds];
    return view;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_orderBtn setCornerRadiusWithRadius:_orderBtn.height / 2.0];
}


-(void)willMoveToWindow:(UIWindow *)newWindow{
    
    if ([self didLogIn]) {
        [self.orderBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    }else{
        
        [self.orderBtn setTitle:@"立即登录即可预约单车" forState:UIControlStateNormal];
        
    }
}

- (void)setResult:(PlanResult *)result{
//    NSRange range = [result.destination rangeOfString:@"区"];
    if ([result.destination isEqualToString:@""]) {
        self.titleLabel.text = @"未定位到当前位置";
    }
//    else if (range.location && result.destination.length > range.location) {
//        self.titleLabel.text = [result.destination substringFromIndex:range.location + 1];
     else{
        self.titleLabel.text = result.destination;
    }
    self.distanceLab.text = [NSString stringWithFormat:@"%.2f公里",result.distance / 1000.0];
    self.durationLab.text = [NSString stringWithFormat:@"%ld分钟",(long)result.duration/60];
}

-(NSString *)dataFile{
    NSArray *ar = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *fielpath = [ar objectAtIndex:0];
    return [fielpath stringByAppendingPathComponent:@"user.data"];
    //改修后缀名，以免与属性列表创建的文件重复，而加载成旧的的文件。 不用查字典了。。archive表归档
}

//判断是否已登录
-(BOOL)didLogIn{
    if([AccountManager token] ) {
        return YES;
    }else{
        return NO;
    }
    
}

- (IBAction)clickOrderBtn:(UIButton *)sender {

    if ([self didLogIn]) {
        //已登录
        if ([self.delegate respondsToSelector:@selector(clickOrderBtnHasLog:)]) {
            [self.delegate clickOrderBtnHasLog:sender];
        }
        
    }else{
        if ([self.delegate respondsToSelector:@selector(clickMenuVCBtn:)]) {
            [self.delegate clickMenuVCBtn:nil];
        }
        
    }
    
}

#pragma mark - 关锁后未计费  -
- (IBAction)actionUnChargingBtn:(UIButton *)sender {
//    if ([_delegate respondsToSelector:@selector(planInfoView:button:)]) {
//        [_delegate planInfoView:self button:sender];
//    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lockFailed" object:self];
}
@end
