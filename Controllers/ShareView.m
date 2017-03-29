//
//  shareView.m
//  
//
//  Created by 郑洪浩 on 2017/1/22.
//
//

#import "ShareView.h"
//微信SDK头文件
#import <UMSocialCore/UMSocialCore.h>
#import <WXApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "ZHHGetUserInfoMod.h"
#define kUrl  @"http://1.liwww.applinzi.com/myapp/html/share.html"

@interface ShareView ()
@property (weak, nonatomic) IBOutlet UIButton *weixinCircleBtn;
@property (weak, nonatomic) IBOutlet UIButton *weixinBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *sinaBtn;
@property (weak, nonatomic) IBOutlet UILabel *weixinCircleLb;
@property (weak, nonatomic) IBOutlet UILabel *weixinLb;
@property (weak, nonatomic) IBOutlet UILabel *qqLb;
@property (weak, nonatomic) IBOutlet UILabel *sinaLb;



@end

@implementation ShareView

#pragma mark - 微信好友  -

+(instancetype)shareView{
    ShareView *view = [[NSBundle mainBundle] loadNibNamed:@"shareView" owner:nil options:nil][0];
    return view;
}

- (void)layoutSubviews {
    [self setButtons:@[_weixinCircleBtn,_weixinBtn,_qqBtn,_sinaBtn]];
}

- (void)setButtons:(NSArray <UIButton *> *) array {
    [array enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.size = CGSizeMake(GLOBAL_H(40), GLOBAL_H(40));
        UILabel *lable = [self viewWithTag:(100 + idx)];
        lable.centerX = obj.centerX;
        lable.y = CGRectGetMaxY(obj.frame) + GLOBAL_V(5);
    }];
}


- (IBAction)shareWe:(UIButton *)sender {
    NSString *kLinkURL = kUrl;
    //    static NSString *kLinkTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    static NSString *kLinkTitle = @"出了地铁口还要再走10分钟?累?怎么不试试AirBike";
    static NSString *kLinkDescription = @"AirBike,新的出行方式";
    UIImage *image = [UIImage imageNamed:@"umImage"];
    
    if ([WXApi isWXAppInstalled]) {
        
        //创建发送对象实例
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;//不使用文本信息
        sendReq.scene = 0;//0 = 好友列表 1 = 朋友圈 2 = 收藏
        
        //创建分享内容对象
        WXMediaMessage *urlMessage = [WXMediaMessage message];
        urlMessage.title = kLinkTitle;//分享标题
        urlMessage.description = kLinkDescription;//分享描述
        [urlMessage setThumbImage:image];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
        
        //创建多媒体对
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = kLinkURL;//分享链接
        
        //完成发送对象实例
        urlMessage.mediaObject = webObj;
        sendReq.message = urlMessage;
        
        //发送分享信息
        [WXApi sendReq:sendReq];
    }
}

#pragma mark - 微信朋友圈  -
- (IBAction)wxTimesShare:(id)sender {
    
    NSString *kLinkURL = kUrl;
    //    static NSString *kLinkTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    static NSString *kLinkTitle = @"出了地铁口还要再走10分钟?累?怎么不试试AirBike";
    static NSString *kLinkDescription = @"AirBike,新的出行方式";
    UIImage *image = [UIImage imageNamed:@"umImage"];
    
    if ([WXApi isWXAppInstalled]) {
        
        //创建发送对象实例
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;//不使用文本信息
        sendReq.scene = 1;//0 = 好友列表 1 = 朋友圈 2 = 收藏
        
        //创建分享内容对象
        WXMediaMessage *urlMessage = [WXMediaMessage message];
        urlMessage.title = kLinkTitle;//分享标题
        urlMessage.description = kLinkDescription;//分享描述
        [urlMessage setThumbImage:image];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
        
        //创建多媒体对象
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = kLinkURL;//分享链接
        
        //完成发送对象实例
        urlMessage.mediaObject = webObj;
        sendReq.message = urlMessage;
        
        //发送分享信息
        [WXApi sendReq:sendReq];
    }
    
}

#pragma mark - qq  -
- (IBAction)qqShareBtn:(UIButton *)sender {
    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
        NSLog(@"安装了q");
        UIImage *image = [UIImage imageNamed:@"umImage"];
        UMShareWebpageObject *shareObj = [UMShareWebpageObject shareObjectWithTitle:@"出了地铁口还要再走10分钟?累?怎么不试试AirBike" descr:@"AirBike,新的出行方式" thumImage:image];
        shareObj.webpageUrl = kUrl;
        UMSocialMessageObject *obj = [UMSocialMessageObject messageObjectWithMediaObject:shareObj];
        
        
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:obj currentViewController:self completion:^(id result, NSError *error) {
            NSLog(@"qq分享了");
            NSString *message = nil;
            if (!error) {
                message = [NSString stringWithFormat:@"分享成功"];
            } else {
                message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            }
             NSLog(@"%@",message);
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
//                                                            message:message
//                                                           delegate:nil
//                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                  otherButtonTitles:nil];
//            [alert show];
        }];
    };
}

#pragma mark - 微博  -
- (IBAction)weiboShareBtn:(UIButton *)sender {
    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
        NSLog(@"安装了新浪");
        UIImage *image = [UIImage imageNamed:@"umImage"];
        UMShareWebpageObject *shareObj = [UMShareWebpageObject shareObjectWithTitle:@"出了地铁口还要再走10分钟?累?怎么不试试AirBike" descr:@"AirBike,新的出行方式" thumImage:image];
        shareObj.webpageUrl =kUrl;
        UMSocialMessageObject *obj = [UMSocialMessageObject messageObjectWithMediaObject:shareObj];
        
        
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:obj currentViewController:self completion:^(id result, NSError *error) {
            NSLog(@"新浪分享了");
            NSString *message = nil;
            if (!error) {
                message = [NSString stringWithFormat:@"分享成功"];
            } else {
                message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            }
            NSLog(@"%@",message);
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
//                                                            message:message
//                                                           delegate:nil
//                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                  otherButtonTitles:nil];
//            [alert show];
        }];
    };
}


@end
