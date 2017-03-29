//
//  ScanHelper.m
//  Map
//
//  Created by 郑洪浩 on 16/10/11.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ScanHelper.h"

#define QRCodeWidth  [UIScreen mainScreen].bounds.size.width*3/5  //正方形二维码的边长
#define SCREENWidth  [UIScreen mainScreen].bounds.size.width   //设备屏幕的宽度
#define SCREENHeight [UIScreen mainScreen].bounds.size.height //设备屏幕的高度

@interface ScanHelper ()<AVCaptureMetadataOutputObjectsDelegate> {
    AVCaptureSession *_session;//输入输出中间桥梁
    AVCaptureVideoPreviewLayer *_layer;//捕捉视频预览层
    AVCaptureMetadataOutput *_output;//捕获元数据输出
    AVCaptureDeviceInput *_input;//采集设备输入
    UIView *_viewContainer;//扫描视图的父视图
}
@property (nonatomic, weak)UIImageView *scanNetImgV;
@end

@implementation ScanHelper

/**
 单例模式

 @return 实例对象
 */
+ (instancetype)manager{
    static ScanHelper *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[ScanHelper alloc] init];
    });
    return singleton;
}

/**
 初始化

 @return 实例对象
 */
- (id)init {
    if (self = [super init]) {
        //初始化链接对象
        _session = [[AVCaptureSession alloc] init];
        //高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        
        //FIXME:避免模拟器运行崩溃
        if (!TARGET_IPHONE_SIMULATOR) {
            //获取摄像装备
//            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            //创建输入流
            _input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
            [_session addInput:_input];
            //创建输出流
            _output = [[AVCaptureMetadataOutput alloc] init];
            //设置处理 在主线程刷新
            [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            [_session addOutput:_output];
            //设置扫码支持的编码格式(条形码和二维码兼容)
            _output.metadataObjectTypes = @[
                                            AVMetadataObjectTypeQRCode,
                                            AVMetadataObjectTypeEAN13Code,
                                            AVMetadataObjectTypeCode128Code,
                                            AVMetadataObjectTypeEAN8Code
                                            ];
            //在addOutput之后,否者ios10 会崩溃
            _layer =[AVCaptureVideoPreviewLayer layerWithSession:_session];
            _layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        }
    }
    return self;
}

#pragma mark - 开始捕获
- (void)startRunning {
    if (!TARGET_IPHONE_SIMULATOR) {
        [_session startRunning];
    }
}

#pragma mark - 停止捕获
- (void)stopRunning {
    if (!TARGET_IPHONE_SIMULATOR) {
        [_session stopRunning];
    }
}

#pragma mark - 退出
- (void)quitScanView {
    [_session stopRunning];
}

#pragma mark - AVCaptureMetadataOutputObjects Delegat
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        [self quitScanView];
        if ([APPManager shareAppManager].isTest) {
            [HHProgressHUD showHUDInView:_viewContainer animated:YES withText:@"扫描成功"];
        }
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        
        if (self.scanBlock) {
            self.scanBlock(metadataObject.stringValue);
        }
    }
}

/**
 设置扫描范围区域 CGRectMake(y的起点/屏幕的高,x的起点/屏幕的款,扫描区域的高/屏幕的高,扫描区域的宽/屏幕的款)
 @param scanRect 扫描范围
 @param scanView 扫描框
 
 */
- (void)setScaningRect:(CGRect)scanRect scanView:(UIView *)scanView {
    CGFloat x,y,width,height;
    x= scanRect.origin.y/_layer.frame.size.height;
    y = scanRect.origin.x/_layer.frame.size.width;
    width = scanRect.size.height/_layer.frame.size.height;
    height = scanRect.size.width/_layer.frame.size.width;
    _output.rectOfInterest = CGRectMake(x, y, width, height);
    self.scanView = scanView;
    
    if (self.scanView) {
        self.scanView.frame = scanRect;
        if (_viewContainer) {
            [_viewContainer addSubview:scanView];
        }
    }

    //设置扫描区域的四个角的边框
    UIImage *imgLeft = [UIImage imageNamed:@"imgs_scan_size_left"];
    [imgLeft scaleImageWithWidth:scanRect.size.width];
    UIImageView *topLeft = [[UIImageView alloc]initWithFrame:CGRectMake(-imgLeft.size.width+2,0, imgLeft.size.width, scanRect.size.height)];
    [topLeft setImage:imgLeft];
    [scanView addSubview:topLeft];
    
    UIImage *imgRight = [UIImage imageNamed:@"imgs_scan_size_right"];
    [imgRight scaleImageWithWidth:scanRect.size.width];
    UIImageView *topRight = [[UIImageView alloc]initWithFrame:CGRectMake(scanRect.size.width-2,0, imgLeft.size.width, scanRect.size.height)];
    [topRight setImage:imgRight];
    [scanView addSubview:topRight];
    
    UIImage *imgTop = [UIImage imageNamed:@"imgs_scan_size_top"];
    UIImageView *top = [[UIImageView alloc]initWithFrame:CGRectMake(0,2-imgTop.size.height, scanRect.size.width, imgTop.size.height)];
    [top setImage:imgTop];
    [scanView addSubview:top];
    
    UIImage *imgbottom = [UIImage imageNamed:@"imgs_scan_size_bottom"];
    UIImageView *bottom = [[UIImageView alloc]initWithFrame:CGRectMake(0,scanRect.size.height-2, scanRect.size.width, imgTop.size.height)];
    [bottom setImage:imgbottom];
    [scanView addSubview:bottom];
    
    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imgs_scan_size"]];
    view.frame = scanRect;
    [_viewContainer addSubview:view];
    //设置扫描区域的动画效果
    CGFloat scanNetImageViewH1 = 4;
    CGFloat scanNetImageViewW2 = QRCodeWidth*3/4;
    UIImageView *scanNetImageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"imgs_scan_line"]];
    scanNetImageView1.frame = CGRectMake((QRCodeWidth - scanNetImageViewW2)/2, 0, scanNetImageViewW2, scanNetImageViewH1);
    self.scanNetImgV = scanNetImageView1;
    [scanView addSubview:scanNetImageView1];
}

- (void)scanNetAnimate:(UIImageView *)scanNetImageView1 {
    CABasicAnimation *scanNetAnimation1 = [CABasicAnimation animation];
    scanNetAnimation1.keyPath =@"transform.translation.y";
    scanNetAnimation1.byValue = @(QRCodeWidth);
    scanNetAnimation1.duration = 2.0;
    scanNetAnimation1.repeatCount = MAXFLOAT;
    [scanNetImageView1.layer addAnimation:scanNetAnimation1 forKey:@"scanNetAnimation"];
}

- (void)startAnimateScanNetImageView{
    [self scanNetAnimate:self.scanNetImgV];
}
/**
 显示图层

 @param viewContainer 需要在哪个view显示
 */
- (void)showLayer:(UIView *)viewContainer{
    _viewContainer = viewContainer;
    _layer.frame = _viewContainer.layer.frame;
    [_viewContainer.layer insertSublayer:_layer atIndex:0];

    //设置统一的视图颜色和视图的透明度
    UIColor *color = [UIColor blackColor];
    float alpha = 1;
    
    //设置扫描区域外部上部的视图
    UIView *topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0,0,viewContainer.width, (viewContainer.height-QRCodeWidth)/2.0-64);
    topView.backgroundColor = color;
    topView.alpha = alpha;
    
    //设置扫描区域外部左边的视图
    UIView *leftView = [[UIView alloc]init];
    leftView.frame = CGRectMake(0, topView.frame.size.height, (viewContainer.width-QRCodeWidth)/2.0,QRCodeWidth);
    leftView.backgroundColor = color;
    leftView.alpha = alpha;
    
    //设置扫描区域外部右边的视图
    UIView *rightView = [[UIView alloc]init];
    rightView.frame = CGRectMake((viewContainer.width-QRCodeWidth)/2.0+QRCodeWidth,topView.frame.size.height, (viewContainer.width-QRCodeWidth)/2.0,QRCodeWidth);
    rightView.backgroundColor = color;
    rightView.alpha = alpha;
    
    //设置扫描区域外部底部的视图
    UIView *botView = [[UIView alloc]init];
    botView.frame = CGRectMake(0, QRCodeWidth+topView.frame.size.height,viewContainer.width,viewContainer.height-QRCodeWidth-topView.frame.size.height);
    botView.backgroundColor = color;
    botView.alpha = alpha;
    
    //将设置好的扫描二维码区域之外的视图添加到视图图层上
    [_viewContainer.layer insertSublayer:topView.layer above:_layer];
    [_viewContainer.layer insertSublayer:leftView.layer above:_layer];
    [_viewContainer.layer insertSublayer:rightView.layer above:_layer];
    [_viewContainer.layer insertSublayer:botView.layer above:_layer];
}

@end
