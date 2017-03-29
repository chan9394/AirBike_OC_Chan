//
//  WKWebViewController.h
//  AirBk
//
//  Created by Damo on 16/12/27.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "BaseVC.h"
@class ZHHTrackFinishModel;

typedef NS_ENUM(NSInteger,WKWebVCType)  {
    WKWebVCTypeProductIntro = 0,                  //产品说明
    WKWebVCTypeRefundIntro = 1,                   //退款选择
    WKWebVCTypeMoveDetail = 2,                    //行程详情
    WKWebVCTypeNegaticeCredit = 3,                //负面记录
    WKWebVCTypeMoveEnd = 4,                       //骑行结束
    WKWebVCTypeMoveShare = 5,                     //骑行分享
    WKWebVCTypePhoneNumber = 6,                   //手机号
    WKWebVCTypeChangeNumSuccess = 7,              //手机号更换成功
    WKWebVCTypeAbountAirBike = 8,                 //关于AirBike
    WKWebVCTypeAbountCredit = 9,                  //关于信用积分规则
    WKWebVCTypeAddCredit = 10,                    //信用分增加
    WKWebVCTypeMyCredit = 11,                     //我的信用
    WKWebVCTypeConnect = 12,                      //联系我们
    WKWebVCTypeDespoit = 13,                      //押金说明
    WKWebVCTypeDespoitNext = 14,                  //押金说明下一步
    WKWebVCTypeDespoitOverTime = 15,              //押金说明超过七个工作日
    WKWebVCTypeReturnDespoitProtocol = 16 ,       //押金退还条款
    WKWebVCTypeSenReturnIntroSuccess = 17,        //退款说明提交成功
    WKWebVCTypeLoading = 18,                      //首页轮播
    WKWebVCTypeNoCar = 19,                        //找不到车
    WKWebVCTypeQuestion = 20,                     //问题反馈
    WKWebVCTypeRechargeIntro = 21,                //充值说明
    WKWebVCTypeRechargeSuccess = 22,              //充值成功(押金)
    WKWebVCTypeRechargeProtocol = 23,             //充值协议
    WKWebVCTypeSendSource = 24,                   //发送移动电源
    WKWebVCTypeChangeSource = 25 ,                //更换移动电源
    WKWebVCTypeUserProtocol = 26,                 //用户协议
    WKWebVCTypeAccountDetail = 27,                //账目明细
    WKWebVCTypeQueryOrdernumber = 28,             //订单号查询
    WKWebVCTypePlayIntro,                         //使用说明
};

@interface WKWebViewController : BaseVC

@property (nonatomic, assign) WKWebVCType           type;           //跳转的类型
@property (nonatomic,   copy) NSString              *nvTitle;       //页面的标题
@property (nonatomic,   copy) NSString              *nvRightTitle;  // 右侧按钮文字
@property (nonatomic,   copy) NSString              *nvLeftTitle;   //左侧的按钮文字
@property (nonatomic, assign) BOOL                  nvBarHidden;    //是否隐藏导航栏
@property (nonatomic, strong) void(^leftBlock)();                   //左侧按钮点击事件,默认返回上一级界面
@property (nonatomic  , copy) void(^rightBlock)();                  //右侧按钮点击事件
@property (nonatomic, strong) void(^tapRecHandel)(UITapGestureRecognizer *tapRec) ; //单击模糊背景的

//@property (nonatomic, strong) ZHHTrackFinishModel *finishModel; //骑行结束

//界面的标题 和 界面的类型
- (instancetype)initWithTitlt:(NSString *)title type:(WKWebVCType)type;

+ (instancetype)webVCWithtype:(WKWebVCType)type;

+ (instancetype)webVCWithTitlt:(NSString *)title type:(WKWebVCType)type;

//是否隐藏navigationbar
+ (instancetype)webVCWithTitlt:(NSString *)title type:(WKWebVCType)type nvBarHidden:(BOOL)isHidden;

- (void)loadHTMLString:(NSString *)htmlString;

//分享界面
- (void)addEffectView;

//移除分享界面
- (void)removeEffectView;

//骑行结束和骑行详情
- (instancetype)initWithTitle:(NSString *)title type:(WKWebVCType)type cycleID:(NSString *)cycleId;

+ (NSString *)InviteFriendUrl;

@end
