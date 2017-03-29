//
//  ZHHSearchTVC.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/11/2.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#define ROW_HEIGHT 50

#import "ZHHSearchTVC.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "POIAnnotation.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "OutTimeView.h"
#import "RefreshView.h"
#import "UIImage+Extension.h"
#import "SearchHistoryModel.h"
#import "NSArray+Order.h"

typedef NS_ENUM(NSUInteger, SearchTVCState) {
    SearchTVCStateDefault,      //默认 未登录
    SearchTVCStateLoged,        //已登录
    SearchTVCStateEditing,      //已登录 编辑状态
};

typedef NS_ENUM(NSUInteger, SearchTVCRemindView) {
    SearchTVCRemindViewDeleteSuccessed,
    SearchTVCRemindViewAddSuccessed,
    SearchTVCRemindViewTopNummber,
};

@interface ZHHSearchTVC ()<AMapSearchDelegate,OutTimeViewDelegate,UISearchBarDelegate>

@property (nonatomic, strong) AMapSearchAPI             *search;
@property (nonatomic, strong) NSMutableArray            *aryShow;             //展示的数据
@property (nonatomic, strong) NSMutableArray            *getAry;              //收藏 + 本地的数据
@property (nonatomic, strong) NSMutableArray            *netAry;              //收藏的数据
@property (nonatomic, strong) NSMutableArray            *localAry;            //本地的数据
@property (nonatomic,   weak) UISearchBar               *searchBar;           //搜索框
@property (nonatomic,   weak) OutTimeView               *outTimeView;         //网络超时
@property (nonatomic,   weak) RefreshView               *refreshView;         //菊花
@property (nonatomic, strong) SearchHistoryModel        *model;               //网络搜索记录
@property (nonatomic, strong) NSArray                   *aryCollected;        //收藏
@property (nonatomic, assign) SearchTVCState            uiState;              //通过状态 刷新UI
@property (nonatomic, assign) BOOL                      showEditorBtn;        //展示编辑按钮
@property (nonatomic, strong) NSMutableArray            *removeAry;           //被移除的收藏
@property (nonatomic,   copy) NSString                  *noHistoryStr;        //无历史记录的显示
@property (nonatomic,   weak) UIButton                  *removeBtn;           //移除按钮
@property (nonatomic,   weak) UIImageView               *remindImgView;       //提示图

@end

@implementation ZHHSearchTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //判断是否登录
    if (GLOBAL_TOKEN) {
        self.uiState = SearchTVCStateLoged;
    } else {
        self.uiState = SearchTVCStateDefault;
    }
    
    [self getSearchHistory];
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self setSearchBar];
    NSLog(@"%@",NSHomeDirectory());
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 35)];
    [btn setTitle:@"取消"  forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    if (GLOBAL_SCREENW > 350) {
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 16, 35)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_refreshView removeFromSuperview];
    self.navigationItem.hidesBackButton = true;
}

#pragma mark - 设置搜索栏  -
- (void)setSearchBar{
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    self.searchBar = searchBar;
    searchBar.contentMode =UIViewContentModeLeft;
    searchBar.frame = CGRectMake(0, 0, self.view.width - 100, 28);
    searchBar.placeholder = @"请输入您要搜索的位置";
    searchBar.delegate = self;
    searchBar.backgroundImage = [UIImage new];
    searchBar.barTintColor = [UIColor whiteColor];
    [searchBar setContentMode:UIViewContentModeLeft];
    self.searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
    UITextField *searchField = [searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 14.0f;
        searchField.layer.masksToBounds = YES;
        searchField.tintColor = GLOBAL_THEMECOLOR;
    }
    self.navigationItem.titleView = searchBar;
}

- (void)clickCancelBtn:(UIButton *)sender {
    [sender.superview endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (self.uiState == SearchTVCStateEditing) {
        self.uiState = SearchTVCStateLoged;
    }
    
    if (![searchBar.text isEqualToString: @""]) {
        AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
        tips.keywords = searchBar.text;
        [self.search AMapInputTipsSearch:tips];
    } else {
        self.aryShow = self.getAry;
        [self.tableView reloadData];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (self.aryShow.count == 0) {
        return ;
    }
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

#pragma mark -   - /* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response {
    NSMutableArray *aryMut = [NSMutableArray array];
    
    [response.tips enumerateObjectsUsingBlock:^(AMapTip * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *strN = ((AMapTip *)obj).name;
        AMapGeoPoint *poi = ((AMapTip *)obj).location;
        CLLocationCoordinate2D lo = CLLocationCoordinate2DMake(poi.latitude, poi.longitude);
        POIAnnotation *ani = [[POIAnnotation alloc] initWithCoordinate:lo andTitle:strN subTitle:obj.district];
        [self.getAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            POIAnnotation *poiA = obj;
            if ([poiA.title isEqualToString:ani.title]) {
                ani.hasCollected = poiA.hasCollected;
            }
        }];
        [aryMut addObject:ani];
    }];
    
    self.aryShow = aryMut;
    if (![self.searchBar.text isEqualToString:@""]) {
        //搜索到的词条cell不显示收藏按钮
        [self.tableView reloadData];
    }
}

#pragma mark - tableView 的delegate  -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.aryShow) {
        return self.aryShow.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"city"];
    POIAnnotation *poi = (POIAnnotation *)self.aryShow[indexPath.row];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"city"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.textColor = GLOBAL_CONTENTCOLOR;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        
        
        UIButton *buttCollect = [[UIButton alloc] init];
        float width = GLOBAL_H(60);
        float height = GLOBAL_V(30);
        float x = self.view.width - GLOBAL_H(10) - width;
        float y = (ROW_HEIGHT - height)/2;
        buttCollect.frame = CGRectMake(x , y, width, height);
        buttCollect.tag = 99;
//        UIImage *imageCel =[UIImage imageNamed:@"imgs_search_collect"];
//        UIImage *imageUnCel =[UIImage imageNamed:@"imgs_search_nocollect"];
//        [buttCollect setBackgroundImage:imageCel forState:UIControlStateNormal];
//        [buttCollect setBackgroundImage:imageUnCel forState:UIControlStateDisabled];
        buttCollect.layer.borderColor = GLOBAL_THEMECOLOR.CGColor;
        buttCollect.layer.cornerRadius = GLOBAL_V(height / 2.0);
        [buttCollect setTitle:@"收藏" forState:UIControlStateNormal];
        [buttCollect setTitle:@"已收藏" forState:UIControlStateDisabled];
        buttCollect.titleLabel.font = [UIFont systemFontOfSize:14];
        [buttCollect setTitleColor:GLOBAL_THEMECOLOR forState:UIControlStateNormal];
        [buttCollect setTitleColor:GLOBAL_CONTENTCOLOR forState:UIControlStateDisabled];
        buttCollect.contentMode = UIViewContentModeScaleToFill;
        [buttCollect addTarget:self action:@selector(sendCollectRequest:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:buttCollect];
        
    }
    cell.userInteractionEnabled = YES;
    switch (self.uiState) {
        case SearchTVCStateDefault|SearchTVCStateLoged:{
            UIImage *imageV = [UIImage imageNamed:@"imgs_menu_address"];
            cell.imageView.image = imageV;
            break;
        }
        case SearchTVCStateEditing:{
            UIImage *imageV;
            if (poi.hasCollected) {
                if (poi.selectedToRemove) {
                    imageV = [UIImage imageNamed:@"imgs_search_collectmark"];
                    [cell setSelected:YES];
                }else{
                    imageV = [UIImage imageNamed:@"imgs_search_nocollectmark"];
                    [cell setSelected:NO];
                }
                cell.imageView.image = imageV;
            } else {
                UIImage *imageV = [UIImage imageNamed:@"imgs_menu_address"];
                cell.imageView.image = imageV;
                cell.userInteractionEnabled = NO;
            }
            break;
            
        }
        default:
            break;
    }
    
    cell.textLabel.text = poi.title;
    cell.detailTextLabel.text = poi.subtitle;
    cell.textLabel.height = 25;
    cell.imageView.frame = CGRectMake(0, 0, 40, 40);
    //    判断是否展示收藏按钮,搜索框出现的不展示,搜索历史展示
    UIButton * buttcollect = [cell.contentView viewWithTag:99];
    switch (self.uiState) {
        case SearchTVCStateDefault:{
            buttcollect.hidden = YES;
            break;
        }
        default:{
            buttcollect.hidden = NO;
            //判断是否已收藏
            BOOL hasCollect = poi.hasCollected;
            if (hasCollect) {
                buttcollect.enabled = NO;
            }else{
                buttcollect.enabled = YES;
            }
            
            break;
        }
    }
     buttcollect.layer.borderWidth = buttcollect.enabled == YES ? 1.0 : 0.0;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ROW_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    
    NSString *location= [[NSUserDefaults standardUserDefaults] objectForKey:@"userLoca"];
    
    UIView *headerView;
    //通过uiState属性 判断头视图样式 刷新tableview
    switch (self.uiState) {
        case SearchTVCStateDefault:{
            headerView = [[NSBundle mainBundle] loadNibNamed:@"SearchTVC" owner:nil options:nil][0];
            UILabel *localLab = [headerView viewWithTag:10];
            localLab.text = location;
            break;
        }
        case SearchTVCStateLoged :{
            [self judgeShowEditorBtn];
            headerView = [[NSBundle mainBundle] loadNibNamed:@"SearchTVC" owner:nil options:nil][1];
            UILabel *localLab = [headerView viewWithTag:10];
            localLab.text = location;
            UIButton *editorBtn = [headerView viewWithTag:11];
            [editorBtn addTarget:self action:@selector(clickEditorBtn:) forControlEvents:UIControlEventTouchUpInside];
            UIView *lineView = [headerView viewWithTag:12];
            if (self.showEditorBtn) {
                lineView.hidden = NO;
                editorBtn.hidden = NO;
            }else{
                lineView.hidden = YES;
                editorBtn.hidden = YES;
            }
            break;
        }
        case SearchTVCStateEditing:{
            headerView = [[NSBundle mainBundle] loadNibNamed:@"SearchTVC" owner:nil options:nil][2];
            UIButton *btnSelAll = [headerView viewWithTag:12];
            [btnSelAll addTarget:self action:@selector(clickSelectAllBtn:) forControlEvents:UIControlEventTouchUpInside];
            UIButton *btnSelRem = [headerView viewWithTag:11];
            [btnSelRem addTarget:self action:@selector(clickSelectRemoveBtn:) forControlEvents:UIControlEventTouchUpInside];
            self.removeBtn = btnSelRem;
            UIButton *btnSelCan = [headerView viewWithTag:10];
            [btnSelCan addTarget:self action:@selector(clickSelectCancleBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (self.removeAry.count == 0) {
                self.removeBtn.enabled = NO;
            }else{
                self.removeBtn.enabled = YES;
            }

            break;
        }
        default:
            break;
    }
    return headerView;
    
}

- (void)clickSelectAllBtn:(UIButton *)sender{
    static BOOL selectAll = NO;
    [self.aryShow enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        POIAnnotation *poi = obj;
        poi.selectedToRemove = !selectAll;
        if (poi.selectedToRemove) {
            [self.removeAry addObject:poi];
        }else{
            [self.removeAry removeObject:poi];
        }
        
    }];
    selectAll = !selectAll;
    [self.tableView reloadData];
}

- (void)clickSelectRemoveBtn:(UIButton *)sender{
    
    [self.removeAry enumerateObjectsUsingBlock:^(POIAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [NetWorks cleanSearchHistoryWithSearchKey:obj.title Successed:^(id success) {
            obj.selectedToRemove = NO;
            obj.hasCollected = NO;
            //刷新数据源
            [self.netAry removeObject:obj];
            [self.getAry removeObject:obj];
            
            __block BOOL noCollected = YES;
            [self.aryShow enumerateObjectsUsingBlock:^(POIAnnotation*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.hasCollected) {
                    noCollected = NO;
                    
                }
            }];
            
            if (self.netAry.count == 0 || noCollected ) {
                self.uiState = SearchTVCStateLoged;
            }
            [self showRemindView:SearchTVCRemindViewDeleteSuccessed];
            
            if (idx == self.removeAry.count - 1) {
                
                [self.removeAry removeAllObjects];
            }
            
            [self.tableView reloadData];
        }];
    }];
}

- (void)clickSelectCancleBtn:(UIButton *)sender {
    self.uiState = SearchTVCStateLoged;
    [self.aryShow enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        POIAnnotation *poi = obj;
        poi.selectedToRemove = NO;
    }];
    [self.tableView reloadData];
}

-(void)clickEditorBtn:(UIButton *)sender{
    self.uiState = SearchTVCStateEditing;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (self.uiState) {
        case SearchTVCStateDefault:
            return 44;
            break;
        case SearchTVCStateEditing:
            return 94;
            break;
        case SearchTVCStateLoged:
            return 94;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    if (self.aryShow.count > 0) {
        UIButton *deleBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width/4, 0/8, self.view.width/2, 50/4*3)];
        [deleBtn setTitle:@"清空搜索记录" forState:UIControlStateNormal];
        [deleBtn setTitleColor:GLOBAL_ASSISTCOLOR forState:UIControlStateNormal];
        [deleBtn setBackgroundColor:[UIColor whiteColor]];
        deleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [deleBtn addTarget:self action:@selector(deleteSearchHistory) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:deleBtn];
    } else {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width/4, 0/8, self.view.width/2, 50/4*3)];
        label.textColor = GLOBAL_CONTENTCOLOR;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        
        if (!GLOBAL_TOKEN) {
            label.text = @"暂无历史记录";
        } else {
            label.text = _noHistoryStr;
        }
    }
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row%2==0) {
        return YES;
    }else{
        return NO;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    POIAnnotation *poi =  self.aryShow[indexPath.row];
    
    cell.selected = NO;
    switch (self.uiState) {
        case SearchTVCStateEditing:{
            if (poi.selectedToRemove) {
                UIImage *imageV = [UIImage imageNamed:@"imgs_search_nocollectmark"];
                cell.imageView.image = imageV;
                poi.selectedToRemove= NO;
                //将poi移出removeAry
                [self.removeAry removeObject:poi];
                if (self.removeAry.count == 0) {
                    self.removeBtn.enabled = NO;
                }
            }else{
                UIImage *imageV = [UIImage imageNamed:@"imgs_search_collectmark"];
                cell.imageView.image = imageV;
                poi.selectedToRemove = YES;
                if (self.removeAry.count ==0) {
                    self.removeBtn.enabled = YES;
                }
                //将poi放入removeAry中
                [self.removeAry addObject:poi];
            }
            break;
        }
        default:{
            POIAnnotation *poi =  self.aryShow[indexPath.row];
            NSDictionary *dicInfo = @{
                                      @"location":poi
                                      };
            if (![self isExistHistoryWithAnnotation:poi]) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [self addCityToOfCityAry:poi];
                });
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMap" object:self userInfo:dicInfo];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
}

#pragma mark -   - 点击收藏按钮
- (void)sendCollectRequest:(UIButton *)sender{
    UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    POIAnnotation *poi = self.aryShow[index.row];
    
    //发送请求
    [NetWorks addSearchHistoryWithSearchKey:poi.title searchAddress:poi.subtitle successBlock:^(id response) {
        poi.hasCollected = YES;
        
        [self removeCityPoi:poi];
        [self showRemindView:SearchTVCRemindViewAddSuccessed];
        
        [self.tableView reloadData];
        
    } topNumBlockFaild:^(id response) {
        [self showRemindView:SearchTVCRemindViewTopNummber];
    }];
}

#pragma mark -   - 清空搜索记录押金 网络请求
- (void)deleteSearchHistory {
    [HHProgressHUD showHUDInView:self.navigationController.view animated:YES withText:@"清空搜索记录成功"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"aryOfCity"];
    self.aryShow = nil;
    [self.tableView reloadData];
    
    [_model.listArray enumerateObjectsUsingBlock:^(SearchHistoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *key = obj.searchKey;
        
         [NetWorks cleanSearchHistoryWithSearchKey:key Successed:^(id success) {
         }];
    }];
    
    [self.getAry removeAllObjects];
}

- (void)deleteINetworkSearchHistoryWithKey:(POIAnnotation *)key {
    }

#pragma mark -   - 获取搜索记录押金 网络请求
- (void)getSearchHistory {
    NSMutableArray *aryMut = [NSMutableArray array];
    NSArray *ary = [[NSUserDefaults standardUserDefaults] objectForKey:@"aryOfCity"];
    
    [ary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 200) {
            
            return ;
        }
        
        POIAnnotation *poi = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
        [aryMut addObject:poi];
    }];
    [self.localAry addObjectsFromArray:aryMut];
    [self.getAry addObjectsFromArray:aryMut];
    self.aryShow = self.getAry;
    [self.tableView reloadData];
    
    if (GLOBAL_TOKEN) {
        if (self.refreshView) {
            return;
        }
        _noHistoryStr = nil;
        [NetWorks getSearchHistoryListFinished:^(id response, NSError *error) {
            if(error.code == -1001) {
                if (!self.outTimeView) {
                    OutTimeView *outTimerView = [[OutTimeView alloc] initWithFrame:self.view.bounds];
                    self.outTimeView = outTimerView;
                    outTimerView.delegate = self;
                    [self.view addSubview:outTimerView];
                }
                return;
            }
            [self.outTimeView removeFromSuperview];
            [self getNetworkHistoryWithResponse:response];
        }];
    }
}

- (void)getNetworkHistoryWithResponse:(id)response {
    SearchHistoryModel *model = [SearchHistoryModel new];
    [model modelWIthJSON:response];
    _model = model;
    NSArray *sortArray = [model.listArray OrderedDescending];
    
    if(model.listArray.count == 0 ) {
        _noHistoryStr = @"暂无历史记录";
        [self.tableView reloadData];
        return;
    }
   
    [sortArray enumerateObjectsUsingBlock:^(SearchHistoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *address = obj.searchKey;
        AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc] init];
        request.address = address;
        
        [self.search AMapGeocodeSearch:request];
    }];
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response {
    NSArray *placemarks = response.geocodes;
    if (!placemarks || placemarks.count == 0) {
        
            if (self.aryShow.count  < 1) {
                _noHistoryStr = @"暂无历史记录";
            }
        [self.tableView reloadData];
        
        return;
    }
    
    AMapGeocode *placemark = placemarks.lastObject;
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(placemark.location.latitude, placemark.location.longitude);
    NSString *subTitle = [NSString stringWithFormat:@"%@%@%@",placemark.city,placemark.district,placemark.township];
    POIAnnotation *annotation = [[POIAnnotation alloc] initWithCoordinate:coordinate andTitle:request.address subTitle:subTitle];

    annotation.hasCollected = YES;
    
    [self.netAry addObject:annotation];
    [self.getAry insertObject:annotation atIndex:0];
    [self.tableView reloadData];
    
    if (self.aryShow.count <1) {
        _noHistoryStr = @"暂无历史记录";
        
    }
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}
#pragma mark - 判断是否存在历史记录  -
#pragma mark - 判断是否存在历史记录  -
- (BOOL)isExistHistoryWithAnnotation:(POIAnnotation *)annotation; {
    for (POIAnnotation *poi in self.getAry) {
        if ([annotation isEqual:poi]) {
            return YES;
        }
    }
    return NO;
};

#pragma mark - 网络超时连接刷新  -

- (void)outTimeRefresh {
    [self getSearchHistory];
}

- (void)addCityToOfCityAry:(POIAnnotation *)poi {
    NSMutableArray *mutData = [NSMutableArray array];
    if (poi.hasCollected) {
        return;
    }
    [self.localAry enumerateObjectsUsingBlock:^(POIAnnotation*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.title isEqualToString:poi.title]) {
            [self.localAry exchangeObjectAtIndex:idx withObjectAtIndex:0];
            return ;
        }
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
        [mutData addObject:data];
    }];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:poi];
    [mutData insertObject:data atIndex:0];
    NSArray *aryO = [NSArray arrayWithArray:mutData];
    [[NSUserDefaults standardUserDefaults] setObject:aryO forKey:@"aryOfCity"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeCityPoi:(POIAnnotation *)poi{
    if ([self.searchBar.text isEqualToString:@""]) {
        //历史记录 点击了收藏 将poi从本地数组移入网络数组
        [self.localAry removeObject:poi];
        //持久化
        NSMutableArray *aryMut = [NSMutableArray array];
        [self.localAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
            [aryMut addObject:data];
        }];
        NSArray *aryO = [NSArray arrayWithArray:aryMut];
        [[NSUserDefaults standardUserDefaults] setObject:aryO forKey:@"aryOfCity"];
        
        [self.netAry insertObject:poi atIndex:0];

    }else{
    
    //搜索记录
    [self.netAry insertObject:poi atIndex:0 ];
    [self.getAry insertObject:poi atIndex:0];
        
    }
    
}
-(void)judgeShowEditorBtn{
    self.showEditorBtn = NO;
    [self.aryShow enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        POIAnnotation *poi = obj;
        if (poi.hasCollected) {
            self.showEditorBtn = YES;
        }
    }];
    
}
- (void)showRemindView:(SearchTVCRemindView )remindViewType {
    
    if (self.remindImgView) {
        [self.remindImgView removeFromSuperview];
    }
    
    NSString *imageNmae;
    switch (remindViewType) {
        case SearchTVCRemindViewTopNummber:
            imageNmae = @"searchTVCRemindViewTopNummber";
            break;
            
        case SearchTVCRemindViewAddSuccessed:
            imageNmae = @"searchTVCRemindViewAddSuccessed";
            break;
        case SearchTVCRemindViewDeleteSuccessed:
            imageNmae = @"searchTVCRemindViewDeleteSuccessed";
            break;
       
    }
    UIImage *image = [UIImage imageNamed:imageNmae];
    [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0.9*image.size.height,0)resizingMode:UIImageResizingModeTile];
    float height = 40;
    UIImageView *imView = [[UIImageView alloc] initWithImage:image];
    imView .frame = CGRectMake(0, 64-height, GLOBAL_KEYWINDOW.width, height);
    [self.navigationController.view insertSubview:imView belowSubview:self.navigationController.navigationBar];
    self.remindImgView = imView;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
         imView.y = 64;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            imView.y = 64-height;
        } completion:^(BOOL finished) {
            [imView removeFromSuperview];
        }];
    }];
    
}

-(NSMutableArray *)getAry{
    if (_getAry == nil) {
        _getAry = [NSMutableArray array];
    }
    return _getAry;
}

-(NSMutableArray *)removeAry{
    if (_removeAry == nil) {
        _removeAry = [NSMutableArray array];
    }
    return _removeAry;
}

-(NSMutableArray *)netAry{
    if (_netAry == nil) {
        _netAry = [NSMutableArray array];
    }
    return _netAry;
}

-(NSMutableArray *)localAry{
    if (_localAry == nil) {
        _localAry = [NSMutableArray array];
    }
    return _localAry;
}

- (RefreshView *)refreshView {
    return [GLOBAL_KEYWINDOW viewWithTag:100];
}

@end
