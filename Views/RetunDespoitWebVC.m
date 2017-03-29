//
//  RetunDespoitWebVC.m
//  AirBk
//
//  Created by Damo on 16/12/30.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "RetunDespoitWebVC.h"
#import <WebKit/WebKit.h>

@interface RetunDespoitWebVC () <WKNavigationDelegate>

@property (nonatomic, weak) WKWebView *webView;

@end

@implementation RetunDespoitWebVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTitleWithText:@"押金退还条款"];
    WKWebView *webview = [[WKWebView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    _webView = webview;
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://1.liwww.applinzi.com/myapp/html/oldruler.html"]];
    [webview loadRequest:Request];
    [self.view addSubview:webview];
    webview.navigationDelegate = self;
}

//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden =  YES;
//    self.navigationController.navigationBar.translucent = 0;
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}


@end
