//
//  MainView.m
//  Mobike
//
//  Created by 郑洪浩 on 16/10/12.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#define PlanInfoViewHeight GLOBAL_V(150)
#import "CommonUtility.h"
#import "MANaviRoute.h"
#import "MapView.h"
#import "POIAnnotation.h"
#import "PlanInfoView.h"
#import "PlanResult.h"
#import "ScanView.h"
#import "ThroughTrackInfoView.h"
#import "ZHHBikeModel.h"
#import "ZHHOrderBikeView.h"
#import "ZHHTrackFinishModel.h"
#import "ZHHgetCyclingStatusModel.h"
#import "MapLoadingView.h"

static const NSInteger RoutePlanningPaddingEdge  = 20;
@interface MapView ()<MAMapViewDelegate,AMapSearchDelegate,ThroughTrackInfoViewDelegate,PlanInfoViewDelegate,ZHHOrderBikeViewDelegate>

@property (assign,  nonatomic) BOOL                             isShowLine;     //显示轨迹
@property (assign,  nonatomic) BOOL                             ordingBike;
@property (assign,  nonatomic) CGFloat                          trackDistance;  //骑行的距离
@property (nonatomic,  assign) CLLocationCoordinate2D           lastLocation;   //点击地图上一次移动的点
@property (strong,  nonatomic) NSArray                          *rendereredLayAry; //已绘制的线路的PloyLine数组
@property (strong,  nonatomic) NSMutableArray                   *annotationAry;    //附近单车位置数组
@property (strong,  nonatomic) NSMutableArray                   *locationAry;      //移动中的位置坐标
@property (weak,    nonatomic) UIView                           *redWaterView;     //流动的红色标记
@property (nonatomic,  strong) MANaviRoute                      *naviRoute;
@property (strong,  nonatomic) AMapRoute                        *mapRoute;         //规划路线
@property (strong,  nonatomic) AMapSearchAPI                    *search;           //搜索工具
@property (strong,  nonatomic) MAPolyline                       *biketrackPolyLine;
@property (strong,  nonatomic) POIAnnotation                    *destinationAnnotation; //骑行结束的位置
@property (strong,  nonatomic) POIAnnotation                    *startAnnotation;        //骑行开始的位置
@property (strong,  nonatomic) POIAnnotation                    *userOldAnnotation;      //记录位置更新后用户的位置
@property (strong,  nonatomic) RedWaterAnnotation               *redWaterAnno;      //地图中心标记
@property (weak,    nonatomic) MAMapView                        *mapView;
@property (weak,    nonatomic) MAUserLocation                   *userLoc;           //用户当前位置
@property (weak,    nonatomic) PlanInfoView                     *showingInfoView;   //预约界面
@property (weak,    nonatomic) ThroughTrackInfoView             *throughTrackView;  //骑行时显示详细信息的View
@property (weak,    nonatomic) ZHHOrderBikeView                 *order;             //取消预约界面
@property (nonatomic,  strong) ZHHBikeModel                     *orederedBikeModel;
@property (nonatomic,    weak) MapLoadingView                   *loadingView;       //加载时的高斯
@property (nonatomic,    weak) MapLoadingView                   *routeLoadingView;  //路径回调时的高斯
@property (weak,    nonatomic) IBOutlet UIButton                *documentBtn;
@property (weak,    nonatomic) IBOutlet UIButton                *refreshBtn;
@property (weak,    nonatomic) IBOutlet NSLayoutConstraint      *documentLayoutH;   //单车说明的高度约束
@property (weak,    nonatomic) IBOutlet UIButton                *productIntroBtn;   //产品介绍按钮
@property (weak,    nonatomic) IBOutlet UIImageView             *refreshBackgroundIv; //刷新按钮的背景图
@property (nonatomic,  assign) BOOL                             flag;   //是否以移动浮标位置查车 0-否 1-是
@property (weak,    nonatomic) UIImageView                      *helpHintPic;         //使用提醒
@property (weak,    nonatomic) UIButton                         *helpHintSkipBtn;     //跳过使用提醒
@property (weak,    nonatomic) IBOutlet UIButton                *scanViewButton;

@end

@implementation MapView

- (MapLoadingView *)loadingView {
    if (!_loadingView) {
        _loadingView = [MapLoadingView mapLoadingView];
    }
    return _loadingView;
}

+ (instancetype)mapView{
    MapView *map = [[NSBundle mainBundle] loadNibNamed:@"MapView" owner:nil options:nil].firstObject;
    [[NSNotificationCenter defaultCenter] addObserver:map selector:@selector(changeUIUserHasLogOutWhenHasOrderBike) name:PublicTVCHasLogOutNotification object:nil];
    
    [map initWithMapView];
    [map setupUI];
    return map;
}

- (void)changeUIUserHasLogOutWhenHasOrderBike {
    if (self.order) {
        [self clickAnnotationWhenHasNavRefe:YES];
    }
}

- (void)setupUI {
    [self bringSubviewToFront:_refreshBtn];
    [self insertSubview:_refreshBackgroundIv belowSubview:_refreshBtn];
    [self addSubview:self.loadingView];
    
}

- (void)layoutSubviews {
    self.mapView.frame = self.bounds;
}

- (void)initWithMapView{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDateMapViewLoc:) name:@"updateMap" object:nil];
    
    ///初始化地图
    MAMapView *mapView = [[MAMapView alloc] init];
    mapView.delegate = self;
    self.mapView = mapView;
    
    mapView.showsUserLocation = YES;
    //设置地图Logo
    mapView.logoCenter = CGPointMake(CGRectGetWidth(self.bounds)-55, CGRectGetHeight(self.bounds)-5);
    mapView.showsCompass= NO; // 设置成NO表示关闭指南针
    mapView.showsScale= NO;  //设置成NO表示不显示比例尺
//    mapView.distanceFilter = 5; //允许偏差范围
    mapView.logoCenter = CGPointMake(100, 100);
    mapView.desiredAccuracy = kCLLocationAccuracyBest;// kCLLocationAccuracyNearestTenMeters;
    //把地图添加至view
    [self insertSubview:mapView atIndex:0];
    //不停的更新位置
    mapView.pausesLocationUpdatesAutomatically = NO;
    mapView.customizeUserLocationAccuracyCircleRepresentation = NO;
    _mapView.allowsBackgroundLocationUpdates = YES;//iOS9以上系统必须配置
}

- (void)upDateMapViewLoc:(NSNotification *)not{
    POIAnnotation *ano = [not.userInfo objectForKey:@"location"];
    [self.mapView setCenterCoordinate:ano.coordinate animated:YES];
}

#pragma mark - 设置中心view
- (void)initRedWaterView {
    //设置附近单车的View
    UIImageView *view = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"imgs_main_center"];
    view.image = image;
    view.bounds = CGRectMake(0, 0, 20, 45);
    self.redWaterView = view;
    view.tag = 14;
    self.redWaterView.center = self.center;
    NSLog(@"redwater%@",NSStringFromCGPoint(self.redWaterView.center) );
    
    [self addSubview:self.redWaterView];
    [self bringSubviewToFront:self.loadingView];
}

#pragma mark -   - 设置地图模式跟着用户,缩放级别17
- (void)setMapViewTrackingModeFollowWithHeading:(MAMapView *)mapView{
    [mapView setZoomLevel:16 animated:YES];
    [mapView setCenterCoordinate:mapView.userLocation.location.coordinate animated:YES];
    CGPoint point = [self.mapView convertCoordinate:mapView.userLocation.location.coordinate toPointToView:mapView];
    NSLog(@"userlocation%@",NSStringFromCGPoint(point));
    [mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
}

- (void)senderEnable:(UIButton *)sender{
    sender.enabled = YES;
}

#pragma mark -   - //刷新附近单车信息
- (void)refreshBikeLocation {
    [self clickRefreshMobikeBtn:self.refreshBtn];
}

- (IBAction)clickRefreshMobikeBtn:(UIButton *)sender {
    if(self.showingInfoView || !sender.enabled ){
        return;
    }
    sender.enabled = NO;
    [self performSelector:@selector(senderEnable:) withObject:sender afterDelay:4];
    [_redWaterView.layer removeAllAnimations];
    //中心图标弹跳
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.values = @[@0,@(-10),@0,@(-8),@0,@(-6),@0];
    animation.duration = 1;
    [_redWaterView.layer addAnimation:animation forKey:nil];
    
    //刷新按钮旋转
    CABasicAnimation*anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim1.duration = 4;
    anim1.byValue=@(M_PI*2*4);// transform.rotation.z表示以平面轴旋转4圈
    [sender.layer addAnimation:anim1 forKey:nil];
    
    //移除之前已经显示的单车位置数组
    [self.mapView removeAnnotations:self.annotationAry];
    [self.annotationAry removeAllObjects];
    [self getBikeNerabyList];
}

#pragma mark -   - 刷新附近单车 网络请求
- (void)getBikeNerabyList{
//    CLLocationCoordinate2D location = self.mapView.userLocation.location.coordinate;
    CLLocationCoordinate2D location;
    if (_flag == NO) {
        location = self.mapView.userLocation.location.coordinate;
    } else  {
    location = [self.mapView convertPoint:self.redWaterView.center toCoordinateFromView:self];
    }

    
    [NetWorks getBikeNerabyListWithCoordinate2D:location andSuccessGetList:^(id response) {
        if ([APPManager shareAppManager].isTest) {
            [HHProgressHUD showHUDInView:self animated:YES withText:@"查询附近单车列表成功"];
        }
        NSMutableArray *aryMut = [NSMutableArray array];
        NSArray *ary = response[@"result"];
        
        [ary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZHHBikeModel *model = [ZHHBikeModel bikeModelWithDic:obj];
            AMapReGeocodeSearchRequest *req = [[AMapReGeocodeSearchRequest alloc] init];
            AMapGeoPoint *poi = [AMapGeoPoint locationWithLatitude:[model.latitude floatValue]  longitude:[model.longitude floatValue]];
            req.location = poi;
            [self.search AMapReGoecodeSearch:req];
            POIAnnotation *anno = [POIAnnotation annotationWithBikeModel:model];
            [aryMut addObject:anno];
        }];
        
        [self.annotationAry addObjectsFromArray:aryMut];
        [self.mapView addAnnotations:aryMut];
    }];
}

#pragma mark -   - 定位用户位置
- (IBAction)clickMapUserLocationBtn:(UIButton *)sender {
    [self.mapView setRotationDegree:0.0 animated:YES duration:0.5];
    [self.mapView setCameraDegree:0.0f animated:YES duration:0.5];
    [self setMapViewTrackingModeFollowWithHeading:self.mapView];
}

#pragma mark - 产品说明  -
- (IBAction)actionProductIntroBtn:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(mainView:didClickProductIntoBtn:)]) {
        [_delegate mainView:self didClickProductIntoBtn:sender];
    }
}

#pragma mark - 个人中心  -
- (void)clickMenuVCBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickBarLeftBtn)]) {
        [self.delegate clickBarLeftBtn];
    }
}

#pragma mark - 未登录使用说明  -
- (IBAction)clickInstructionBtn:(UIButton *)sender {
    [self clickMenuVCBtn:nil];
}

#pragma mark - 客服  -
- (IBAction)clickServerBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(pushAlertVC)]) {
        [self.delegate pushAlertVC];
    }
}

#pragma mark - 点击地图调用  -
- (void)clickAnnotationWhenHasNavRefe:(BOOL)refresh{
    self.refreshBtn.hidden = NO;
    _refreshBackgroundIv.hidden = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.isShowLine = NO;
        if (self.showingInfoView) {
            self.showingInfoView.y = -PlanInfoViewHeight;
        }
        if (self.order){
            self.ordingBike = NO;
            self.order.y = -PlanInfoViewHeight;
        }
        
        [self.naviRoute removeFromMapView];
        [self.mapView removeAnnotation:self.redWaterAnno];
        self.redWaterAnno = nil;
        [self.redWaterView setHidden:NO];
        
    } completion:^(BOOL finished) {
        if (self.showingInfoView) {
            [self.showingInfoView removeFromSuperview];
        }
        if (self.order){
            [self.order removeFromSuperview];
        }
        if (refresh) {
            [self clickRefreshMobikeBtn:self.refreshBtn];
        }
    }];
}

#pragma mark -mapView代理方法 当前地图加载完成
- (void)mapInitComplete:(MAMapView *)mapView{
    [self setMapViewTrackingModeFollowWithHeading:mapView];
    [self.loadingView removeFromSuperview];
    //隐藏底部Logo
//    [self.mapView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isKindOfClass:[UIImageView class]]) {
//            obj.alpha = 0;
//        }
//    }];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    [self.annotationAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (request.location.latitude == ((POIAnnotation *)obj).coordinate.latitude && request.location.longitude == ((POIAnnotation *)obj).coordinate.longitude) {
            ((POIAnnotation *)obj).title = response.regeocode.formattedAddress;
            [self.mapView addAnnotation:obj];
        }
    }];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    //自定义设置用户位置显示的View
    if ([annotation isMemberOfClass:[MAUserLocation class]]) {
        MAAnnotationView *view = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"1"];
        view.image = [UIImage imageNamed:@"imgs_main_user"];
        view.frame = CGRectMake(0, 0, 23, 30);
        return view;
        
    } else if ([annotation isMemberOfClass:[POIAnnotation class]]) {
        //设置附近单车的View
        MAAnnotationView *view = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"mobikeLocation"];
        view.image = [[UIImage imageNamed:@"imgs_main_bike"] scaleImageWithWidth:GLOBAL_H(50)];
        view.centerOffset = CGPointMake(0, -15);
        
        // 设定为缩放
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        // 动画先加速后减速
        animation.timingFunction =
        [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
        // 缩放倍数
        animation.fromValue = [NSNumber numberWithFloat:0.1]; // 开始时的倍率
        animation.toValue = [NSNumber numberWithFloat:1.2]; // 结束时的倍率
        
        CABasicAnimation *animation1 =
        [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        // 终点设定
        animation1.toValue = [NSNumber numberWithFloat:-5];
        
        //动画组1
        CAAnimationGroup *group1 = [CAAnimationGroup animation];
        group1.duration = 0.2;
        group1.repeatCount = 1;
        group1.animations = [NSArray arrayWithObjects:animation, animation1,nil];
        group1.fillMode=kCAFillModeForwards;
        group1.removedOnCompletion = NO;
        
        // 设定为缩放
        CABasicAnimation *animation11 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        
        // 动画先加速后减速
        animation11.timingFunction =
        [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
        // 缩放倍数
        animation11.toValue = [NSNumber numberWithFloat:1]; // 结束时的倍率
        
        CABasicAnimation *animation2 =
        [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        // 终点设定
        animation2.toValue = [NSNumber numberWithFloat:3];;
        // 动画组1
        CAAnimationGroup *group22 = [CAAnimationGroup animation];
        group22.duration = 0.2;
        group22.repeatCount = 1;
        group22.animations = [NSArray arrayWithObjects:animation11, animation2,nil];
        group22.beginTime = 0.2;
        group22.fillMode=kCAFillModeForwards;
        group22.removedOnCompletion = NO;
        
        CABasicAnimation *animation3 =[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        // 终点设定
        animation3.toValue = [NSNumber numberWithFloat:-2];
        animation3.duration = 0.2;
        animation3.repeatCount = 1;
        animation3.beginTime = 0.4;
        animation3.fillMode=kCAFillModeForwards;
        animation3.removedOnCompletion = NO;
        
        // 动画组
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.repeatCount = 1;
        // 添加动画
        group.duration = 0.6;
        group.fillMode=kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.animations = [NSArray arrayWithObjects:group1,group22, animation3,nil];
        [view.layer addAnimation:group forKey:@"scale-layer"];
        return view;
        
    } else if ([annotation isMemberOfClass:[RedWaterAnnotation class]]) {
        MAAnnotationView *view = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"search_center_ic"];
        UIImage *image = [[UIImage imageNamed:@"imgs_main_start_location"] scaleImageWithWidth:GLOBAL_H(50)];
        view.image = image;
        view.bounds = CGRectMake(0, 0, GLOBAL_H(50), GLOBAL_H(50));
        view.centerOffset = CGPointMake(0, -view.height*0.5);
        return view;
    }
    return nil;
    
}

#pragma mark -点击了地图上的单车
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    //判断是否已预约
    if (self.order) {
        return;
    }
    
    if ([view.annotation isMemberOfClass:[POIAnnotation class]]) {
        self.orederedBikeModel = ((POIAnnotation *)view.annotation).modelBike;
        self.refreshBtn.hidden = YES;
        self.refreshBackgroundIv.hidden = YES;
        //红色标记没有隐藏,重新计算路线起点
        if (!self.redWaterView.hidden) {
            CGPoint point = CGPointMake(self.redWaterView.center.x, self.redWaterView.centerY+0.5*self.redWaterView.height);
            //将红标记的位置坐标转换为地图经纬坐标
            CLLocationCoordinate2D redC = [self.mapView convertPoint:point toCoordinateFromView:self];
            self.startAnnotation.coordinate = redC;
            //将红标记固定在地图上
            RedWaterAnnotation *poi = [[RedWaterAnnotation alloc] initWithCoordinate:redC];
            self.redWaterAnno = poi;
            self.redWaterView.hidden = YES;
            [self.mapView addAnnotation:poi];
            [self.mapView showAnnotations:@[poi] animated:YES];
        }
        
        self.destinationAnnotation = (POIAnnotation *)view.annotation;
        AMapWalkingRouteSearchRequest *navi = [[AMapWalkingRouteSearchRequest alloc] init];
        
        //出发点
        navi.origin = [AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude
                                               longitude:self.startAnnotation.coordinate.longitude];
        // 目的地
        navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationAnnotation.coordinate.latitude
                                                    longitude:self.destinationAnnotation.coordinate.longitude];
        [self.search AMapWalkingRouteSearch:navi];
        //正在加载...
        MapLoadingView *view = [MapLoadingView mapLoadingView];
        view.frame = [UIScreen mainScreen].bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        self.routeLoadingView = view;
    }
}

#pragma mark - 路径规划搜索回调 -
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
    [self.routeLoadingView removeFromSuperview];
    
    if (response.route == nil) {
        [HHProgressHUD showHUDInView:self animated:YES withText:@"单车正在休息"];
        return;
    }
    
    AMapPath *path = response.route.paths[0];
    PlanResult *result = [[PlanResult alloc] initWithDistance:path.distance andDuration:path.duration andDestination:self.destinationAnnotation.title];
    
    if (self.showingInfoView == nil) {
        PlanInfoView *planinfoView = [PlanInfoView planInfoView];
        planinfoView.frame = CGRectMake(0, 0, GLOBAL_SCREENW, GLOBAL_V(150));
        self.showingInfoView.height = PlanInfoViewHeight;
        planinfoView.delegate = self;
        planinfoView.y = - planinfoView.height;
        self.showingInfoView = planinfoView;
        [self addSubview:self.showingInfoView];
    }
    
    self.showingInfoView.result = result;
    self.showingInfoView.modelBike = self.orederedBikeModel;
    if(self.showingInfoView.y!=0){
        [UIView animateWithDuration:0.3 animations:^{
            self.showingInfoView.y = 0;
        }];
    }
    
    self.mapRoute = response.route;
    [self presentCurrentCourse];
}

#pragma mark -  展示当前路线方案  -
- (void)presentCurrentCourse {
    [self.naviRoute removeFromMapView];
    
    MANaviAnnotationType type = MANaviAnnotationTypeWalking;
    AMapGeoPoint *startPoint = [AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude];
    AMapGeoPoint *endPoint = [AMapGeoPoint locationWithLatitude:self.destinationAnnotation.coordinate.latitude longitude:self.destinationAnnotation.coordinate.longitude];
    self.naviRoute = [MANaviRoute naviRouteForPath:self.mapRoute.paths[0] withNaviType:type showTraffic:YES startPoint:startPoint endPoint:endPoint];
    self.naviRoute.anntationVisible = NO;
    [self.naviRoute addToMapView:self.mapView];
    
    // 缩放地图使其适应polylines的展示
    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:self.naviRoute.routePolylines]
                        edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge+PlanInfoViewHeight, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                           animated:YES];
    
}

//根据折线模型获取Renderer对象
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    if ([overlay isKindOfClass:[LineDashPolyline class]]) {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth   = 5;
        polylineRenderer.lineDash = NO;
        polylineRenderer.strokeColor = [UIColor redColor];
        return polylineRenderer;
    }
    
    if ([overlay isKindOfClass:[MANaviPolyline class]])  {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        polylineRenderer.lineWidth = 5;
        
        if (naviPolyline.type == MANaviAnnotationTypeWalking) {
            polylineRenderer.strokeColor = self.naviRoute.walkingColor;
        } else if (naviPolyline.type == MANaviAnnotationTypeRailway) {
            polylineRenderer.strokeColor = self.naviRoute.railwayColor;
        } else {
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        return polylineRenderer;
    }
    
    if ([overlay isKindOfClass:[MAMultiPolyline class]]) {
        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
        polylineRenderer.lineWidth = 5;
        polylineRenderer.strokeColors = [self.naviRoute.multiPolylineColors copy];
        polylineRenderer.gradient = YES;
        return polylineRenderer;
    }
    
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolylineRenderer *plLine = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        plLine.lineWidth = 5;
        plLine.strokeColor = [UIColor blueColor];
        plLine.lineJoinType = kMALineJoinRound;//连接类型
        plLine.lineCapType = kMALineCapRound;//端点类型
        return plLine;
    }
    return nil;
}

#pragma mark - 绘制折现 -
- (void)mapView:(MAMapView *)mapView didAddOverlayRenderers:(NSArray *)overlayRenderers {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:overlayRenderers.count];
    
    [overlayRenderers enumerateObjectsUsingBlock:^(MAOverlayRenderer *render, NSUInteger idx, BOOL *stop) {
        MAPolyline *polyline = nil;
        polyline = ((MAOverlayRenderer *)overlayRenderers[idx]).overlay;
        [arr addObject:polyline];
    }];
    self.rendereredLayAry = arr;
}

#pragma mark - 点击地图  -
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    //判断取消窗口是否显示
    if (self.order) {
        return;
    }
    
    if (self.showingInfoView) {
        [UIView animateWithDuration:1.5 animations:^{
            [self.mapView setCenterCoordinate:self.redWaterAnno.coordinate animated:YES];
            [self.mapView setZoomLevel:18 animated:YES];
        } completion:^(BOOL finished) {
            [self clickAnnotationWhenHasNavRefe:YES];
        }];
    }
}

#pragma mark - 扫码,当位置更新时，会进定位回调，通过回调函数，能获取到定位点的经纬度坐标
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation {
    if(updatingLocation) {
        //取出当前位置的坐标
        self.userLoc = userLocation;
        CGFloat log = userLocation.location.coordinate.longitude;
        CGFloat lat = userLocation.location.coordinate.latitude;
        
        if(!log || !lat) {
            return;
        }
        
        NSDictionary *dic = @{@"log":@(log),@"lat":@(lat)};
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userLoc"];
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:userLocation.location
                       completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks,NSError * _Nullable error) {
                           if(error || placemarks == nil || placemarks.count == 0) {
                               NSLog(@"%@",error);
                               return;
                           }
                           
                           CLPlacemark *placemark = placemarks.lastObject;
                           NSMutableString *mStr = [NSMutableString string];
                           if (placemark.locality) {
                               [mStr appendString:placemark.locality];
                           }
                           if (placemark.subLocality) {
                               [mStr appendString:placemark.subLocality];
                           }
                           if (placemark.name) {
                               [mStr appendString:placemark.name];
                           }
                           NSString *userLocation = mStr.copy;
                           [[NSUserDefaults standardUserDefaults] setObject:userLocation forKey:@"userLoca"];
                       }];
    }
}

#pragma mark - 用户拖动地图结束  -
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    //判断是否在骑行中
    if (self.throughTrackView) {
        return;
    }
    if (!self.throughTrackView&&!self.order&&!self.showingInfoView) {
        if (!_lastLocation.latitude) {
            _lastLocation = mapView.userLocation.coordinate;
        }
        //添加1000米的最小刷新距离
        MAMapPoint last = MAMapPointForCoordinate(_lastLocation);
        MAMapPoint current = MAMapPointForCoordinate( [self.mapView convertPoint:self.redWaterView.center toCoordinateFromView:self]);
        BOOL isContains = MACircleContainsPoint(last , current, 1000);
        if (isContains) {
            return ;
        }
        _lastLocation = [self.mapView convertPoint:self.redWaterView.center toCoordinateFromView:self];
        [self clickRefreshMobikeBtn:self.refreshBtn];
    }
    _flag = YES;
//    if (!_lastLocation.latitude) {
//        _lastLocation = mapView.userLocation.coordinate;
//    }
}

#pragma mark - 扫描  -
- (IBAction)clickScan2DBbtn:(UIButton *)sender {
    AccountManager *manager = [AccountManager shareAccountManager];
    //未登录
    if (![AccountManager token]) {
        if ([self.delegate respondsToSelector:@selector(clickBarLeftBtn)]) {
            [self.delegate clickBarLeftBtn];
        }
        return;
    }
    //数据正在请求
    if(GLOBAL_ISREGFRESH) {
        [HHProgressHUD showHUDInView:GLOBAL_KEYWINDOW animated:YES withText:@"正在获取账户信息"];
    }
    
    //已登录未实名
    if ([AccountManager token] && ![manager hasRealName]) {
        if ([self.delegate respondsToSelector:@selector(pushRealNameVC)]) {
            [self.delegate pushRealNameVC];
        }
        return;
    }
    //已登录已实名未冲押金
    if ([AccountManager token] && [manager hasRealName] && ![manager hasDeposit]) {
        if ([self.delegate respondsToSelector:@selector(pushDepositVC)]) {
            [self.delegate pushDepositVC];
        }
        return;
    }
    //已登录已实名已冲押金余额小于1
    if ([AccountManager token] && [manager hasRealName] && [manager hasDeposit] && ![manager hasBalance]) {
        if ([self.delegate respondsToSelector:@selector(pushDepositVC)]) {
            [self.delegate pushDepositVC];
        }
        return;
    }
    //已登录已实名,已冲押金余额大于1
    if ([_delegate respondsToSelector:@selector(pushScanVC)]) {
        [_delegate pushScanVC];
    }
}

#pragma mark - 扫描成功回调  -
- (void)scanSuccesssScanView:(NSString *)deviceId{
    self.isShowLine = YES;
    [self scanSuccessAndHideSubViews:deviceId];
}

- (void)scanSuccessAndHideSubViews:(NSString *)deviceId{
    //将其他标记隐藏
    if (self.mapView.annotations.count > 0) {
        [self.mapView.annotations enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[POIAnnotation class]]) {
                [self.mapView removeAnnotation:obj];
                [self.annotationAry removeObject:obj];
            }
        }];
    }
    
    if (self.showingInfoView) { //预约
        [self.showingInfoView removeFromSuperview];
    }
    if (self.redWaterAnno) {
        [self.mapView removeAnnotation:self.redWaterAnno];
        self.redWaterAnno = nil;
    }
    if (self.naviRoute){
        [self.naviRoute removeFromMapView];
    }
    
    for (int i = 10; i<17; i++) {
        [UIView animateWithDuration:0.5 animations:^{
            [[self viewWithTag:i] setHidden:YES];
        }];
    }
    
    ThroughTrackInfoView *throughTrackView = [ThroughTrackInfoView throughTrackInfoView];
    throughTrackView.deviceId = deviceId;
    self.throughTrackView = throughTrackView;
    throughTrackView.frame = CGRectMake(0, 0, self.width, self.width/5*2);
    throughTrackView.delegate = self;
    [self addSubview:throughTrackView];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(finishTrackHttpRequest:) userInfo:throughTrackView repeats:YES];
    self.trackDistance = 0;
}

#pragma mark - 如何关锁  -
- (void)showHowToLockView{
    if ([self.delegate respondsToSelector:@selector(showHowToLockView)]) {
        [self.delegate showHowToLockView];
    }
}

#pragma mark - 关锁失败  -
-(void)pushLoclkFailedVC{
    if ([self.delegate respondsToSelector:@selector(pushLoclkFailedVC)]) {
        [self.delegate pushLoclkFailedVC];
    }
}

#pragma mark -  定时器发送查询骑行状态请求  -
- (void)finishTrackHttpRequest:(NSTimer *) timer {
    ThroughTrackInfoView *thView = timer.userInfo;
    
    [NetWorks finishTrackHttpRequestWithDeviecId:thView.deviceId and:^(id response){
        //骑行中
        [self TrackingWithResponse:response];
    } and:^(id response){
        //骑行结束
        [self finishTrackWithResponse:response timer:timer];
    } andHasLogOut:^{
        //退出登录2
        [self transferUIFromOnBikingToUnBiking:thView andTimer:timer];
    }];
}

- (void)TrackingWithResponse:(id)response {
    //骑行中
    ZHHgetCyclingStatusModel *mod = [ZHHgetCyclingStatusModel getCuclingStatusModel:response[@"result"]];
    self.throughTrackView.model = mod;
    if ([APPManager shareAppManager].isTest) {
        [HHProgressHUD showHUDInView:self animated:YES withText:@"正在骑行"];
    }
    [_mapView removeOverlay:self.biketrackPolyLine];
    
    NSArray *lock_gps_dataAry = response[@"result"][@"lock_gps_data"];
    
    if (![lock_gps_dataAry isEqual:[NSNull new]]) {
        CLLocationCoordinate2D coor[lock_gps_dataAry.count];
        for (int i = 0; i<lock_gps_dataAry.count; i++) {
            coor[i].latitude= [lock_gps_dataAry[i][@"lat"] doubleValue];
            coor[i].longitude= [lock_gps_dataAry[i][@"lng"] doubleValue];
        }
        
        if (lock_gps_dataAry.count>1) {
            POIAnnotation *an = [[POIAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake([lock_gps_dataAry[lock_gps_dataAry.count-2][@"lat"] doubleValue],[lock_gps_dataAry[lock_gps_dataAry.count-2][@"lng"] doubleValue])];
            POIAnnotation *anLast = [[POIAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake([[lock_gps_dataAry lastObject][@"lat"] doubleValue],[[lock_gps_dataAry lastObject][@"lng"] doubleValue])];
            
            //将两个经纬度点转成投影点
            MAMapPoint point1 = MAMapPointForCoordinate(anLast.coordinate);
            MAMapPoint point2 = MAMapPointForCoordinate(an.coordinate);
            
            //2.计算距离
            if (anLast) {
                self.trackDistance += MAMetersBetweenMapPoints(point1,point2);
                if (self.throughTrackView) {
                    //                    self.throughTrackView.distanceLabel.text = [NSString stringWithFormat:@"%.1f",self.trackDistance];
                }
            }
        }
        
        //构造折线对象
        MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:coor count:lock_gps_dataAry.count];
        self.biketrackPolyLine = commonPolyline;
        [self.mapView addOverlay:commonPolyline];
    }
}

- (void)finishTrackWithResponse:(id)response timer:(NSTimer *)timer {
    //骑行结束
    ThroughTrackInfoView *thView = timer.userInfo;
    if ([APPManager shareAppManager].isTest) {
        [HHProgressHUD showHUDInView:self animated:YES withText:@"骑行结束"];
    }
    [timer invalidate];
    
    [UIView animateWithDuration:2 animations:^{
        thView.y = -self.height;
    } completion:^(BOOL finished) {
        [thView removeFromSuperview];
    }];
    
    for (int i = 10; i<17; i++) {
        [UIView animateWithDuration:0.5 animations:^{
            if (i == 15) {
                if([AccountManager token]) {
                    self.documentBtn.hidden = YES;
                } else {
                    self.documentBtn.hidden = NO;
                }
            } else {
                [[self viewWithTag:i] setHidden:NO];
            }
        }];
    }
    self.isShowLine = NO;
    [self.mapView removeOverlay:self.biketrackPolyLine];
    
    self.biketrackPolyLine = nil;
    //    [HHProgressHUD showHUDInView:self animated:YES withText:@"骑行结束"];
    [self transferUIFromOnBikingToUnBiking:thView andTimer:timer];
    if ([self.delegate respondsToSelector:@selector(pushBikingResultVC:)]) {
        ZHHTrackFinishModel *model = [ZHHTrackFinishModel trackFinishModel:response[@"result"]];
        [self.delegate pushBikingResultVC:model];
    }
}


//骑行下的界面转为未骑行
- (void)transferUIFromOnBikingToUnBiking:(ThroughTrackInfoView *)thView andTimer:(NSTimer  *)timer{
    [timer invalidate];
    [UIView animateWithDuration:2 animations:^{
        thView.y = -self.height;
    } completion:^(BOOL finished) {
        [thView removeFromSuperview];
    }];
    
    for (int i = 10; i<17; i++) {
        [UIView animateWithDuration:0.5 animations:^{
            
            if (i == 15) {
                if([AccountManager token]) {
                    self.documentBtn.hidden = YES;
                    
                }else{
                    self.documentBtn.hidden = NO;
                }
            }else{
                [[self viewWithTag:i] setHidden:NO];
            }
        }];
    }
    self.isShowLine = NO;
    [self.mapView removeOverlay:self.biketrackPolyLine];
    
    self.biketrackPolyLine = nil;
    
}

#pragma mark - 预约单车  -
-(void)clickOrderBtnHasLog:(UIButton *)sender{
    //是否已预约
    if (self.order) {
        return;
    }
    PlanInfoView *view = (PlanInfoView *)sender.superview;
    
    [NetWorks orderBikeNetWorkWithDeviceId:view.modelBike.device_id andSuccessed:^(id response) {
        ZHHOrderBikeView *order = [ZHHOrderBikeView orderBikeView];
        order.frame = CGRectMake(0, 0, self.width, self.width/3);
        order.destinationAnnotation = self.destinationAnnotation;
        order.seconds = [response[@"result"][@"expire_secs"] integerValue];
        order.y = -order.height;
        self.order = order;
        order.delegate = self;
        [self addSubview:order];
        self.ordingBike = YES;
        [UIView animateWithDuration:0.5 animations:^{
            order.y = 0;
            self.showingInfoView.y = -PlanInfoViewHeight;
        } completion:^(BOOL finished) {
            [self.showingInfoView removeFromSuperview];
        }];
        self.isShowLine = NO;
        
        //移除之前已经显示的单车位置数组
        [self.annotationAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj != self.destinationAnnotation) {
                [self.mapView removeAnnotation:obj];
                [self.annotationAry removeObject:obj];
            }
        }];
    }];
}

#pragma mark - 恢复取消预约界面   -
- (void)recoverCancleOrderViewWithDeviceId:(NSString *)deviceId seconds:(NSNumber *)seconds {
    ZHHOrderBikeView *order = [ZHHOrderBikeView orderBikeView];
    order.frame = CGRectMake(0, 0, self.width, self.width/3);
    order.seconds = seconds.integerValue;
    order.deviceId = deviceId;
    order.location = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLoca"];
    order.y = -order.height;
    self.order = order;
    order.delegate = self;
    [self addSubview:order];
    self.ordingBike = YES;
    [UIView animateWithDuration:0.5 animations:^{
        order.y = 0;
        self.showingInfoView.y = -PlanInfoViewHeight;
    } completion:^(BOOL finished) {
        [self.showingInfoView removeFromSuperview];
    }];
    self.isShowLine = NO;
}

#pragma mark - 取消预约  -
- (void)clickCancleOrderBtn {
    [self clickAnnotationWhenHasNavRefe:YES];
}

- (MAUserLocation *)userLoc {
    if (_userLoc == nil) {
        MAUserLocation *userL = [[MAUserLocation alloc] init];
        _userLoc = userL;
    }
    return _userLoc;
}
- (NSMutableArray *)locationAry {
    if (_locationAry == nil) {
        _locationAry = [NSMutableArray array];
    }
    return _locationAry;
}

- (NSMutableArray *)annotationAry {
    if (_annotationAry == nil) {
        _annotationAry = [NSMutableArray array];
    }
    return _annotationAry;
}

- (AMapRoute *)mapRoute {
    if (_mapRoute == nil) {
        _mapRoute = [[AMapRoute alloc] init];
    }
    return _mapRoute;
}

- (AMapSearchAPI *)search {
    if (_search == nil) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}

- (POIAnnotation *)startAnnotation {
    if (_startAnnotation == nil ){
        POIAnnotation *anno = [[POIAnnotation alloc] init];
        _startAnnotation = anno;
    }
    return _startAnnotation;
}

- (POIAnnotation *)destinationAnnotation {
    if (_destinationAnnotation == nil ){
        POIAnnotation *anno = [[POIAnnotation alloc] init];
        _destinationAnnotation = anno;
    }
    return _destinationAnnotation;
}

- (POIAnnotation *)userOldAnnotation {
    if (_userOldAnnotation == nil ){
        POIAnnotation *anno = [[POIAnnotation alloc] init];
        _userOldAnnotation = anno;
    }
    return _userOldAnnotation;
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    if([AccountManager token]) {
        self.documentBtn.hidden = YES;
    }else{
        self.documentBtn.hidden = NO;
    }
}

-(void)showHelpHint{
    
    UIImage *picImg = [UIImage imageNamed:@"imgs_main_hint.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:picImg];
    self.helpHintPic = imgView;
    imgView.frame = GLOBAL_KEYWINDOW.frame;
    imgView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skipHelpHint)];
    tapGR.numberOfTapsRequired = 1;
    tapGR.numberOfTouchesRequired = 1;
    [imgView addGestureRecognizer:tapGR];
    
    [self.superview insertSubview:imgView belowSubview:self.scanViewButton];
    
    float height = 30;
    float widith = 46;
    float x = GLOBAL_KEYWINDOW.width - widith - 10;
    float y = 25;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, widith, height)];
    [button setTitle:@"跳过" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button addTarget:self action:@selector(skipHelpHint) forControlEvents:UIControlEventTouchUpInside];
    self.helpHintSkipBtn = button;
    [self addSubview:button];
    
    
}

-(void)skipHelpHint{
    
    [self.helpHintSkipBtn removeFromSuperview];
    [self.helpHintPic removeFromSuperview];
    
}
@end
