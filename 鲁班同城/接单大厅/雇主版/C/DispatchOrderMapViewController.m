//
//  DispatchOrderMapViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/20.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "DispatchOrderMapViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "GeocodeAnnotation.h"
#import "POIAnnotation.h"

//
#import "LaunchPiesViewController.h"
#import "searchHeaderView.h"

@interface DispatchOrderMapViewController ()<MAMapViewDelegate,AMapSearchDelegate>{
    //当前用户的真实定位位置
    CLLocation *location;
    //搜索框
    searchHeaderView *searchView;
    //搜素搜返回信息
    AMapSearchAPI *searchAPI;
    //进来地图缩放等级
    double zoomLevel;
}

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;

@property (nonatomic, strong) NSMutableArray *annotations;

@property (strong,nonatomic) UIImage *dispatchOrderImage;

@property(nonatomic,strong) CLLocationManager*locationManager;

@property (nonatomic, strong) UIButton *gpsButton;

@end

@implementation DispatchOrderMapViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools hiddenNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [NavTools hiddenNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    //
    [self initOwnObjects];
    //
    [self addSearchView];
    //
    [self addMapView];
    //
    [self addDisttributeOrderButt];
    //
    [self addLocationButt];
}

- (void)initOwnObjects{
    zoomLevel = 14;
    self.annotations = [[NSMutableArray alloc]init];
    self.dispatchOrderImage = [UIImage imageNamed:@"dispatchOnMap"];
    searchAPI = [[AMapSearchAPI alloc]init];
    searchAPI.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    location =  self.mapView.userLocation.location;
    //NSLog(@"定位位置：location.altitude%lf,location.coordinate%lf",location.coordinate.latitude,location.coordinate.longitude);
    if (self.annotations.count == 0){
        [self addAnnotations:location.coordinate];
        //[self.mapView showAnnotations:self.annotations animated:YES];
        [self.mapView setZoomLevel:zoomLevel];
    }
}
//logic
- (void)searchTextField:(NSString*)targetStr{
     AMapPOIKeywordsSearchRequest *searchPoi = [[AMapPOIKeywordsSearchRequest alloc]init];
    searchPoi.keywords = targetStr;
    //    request.keywords            = @"北京大学";
    //    request.city                = @"北京";
    //    request.types               = @"高等院校";
    //    request.requireExtension    = YES;
    //
    //    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    //    request.cityLimit           = YES;
    searchPoi.requireSubPOIs      = YES;
    
    [searchAPI AMapPOIKeywordsSearch:searchPoi];
}
//poi 搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{

    if (response.pois.count == 0)
    {
        return;
    }

    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];

    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
    }];
    /* 如果只有一个结果，设置其为中心点. */
    if (poiAnnotations.count == 1)
    {
        [self.mapView setCenterCoordinate:[poiAnnotations[0] coordinate]];
    }
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else
    {
        [self.mapView showAnnotations:poiAnnotations animated:NO];
    }
    if (poiAnnotations.count){
        [self addAnnotations:[poiAnnotations[0] coordinate]];
        [self.mapView setZoomLevel:zoomLevel];
    }else{
        NSLog(@"没有找到");
    }
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    //搜索出错
    NSLog(@"Error: %@ - error.code= %ld", error, error.code);
}

//用户位置图标设置
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.image = [UIImage imageNamed:@"userPosition"];
        pre.fillColor = RGBA(44, 101, 236, 0.6);
        pre.strokeColor = [UIColor whiteColor];
        pre.lineWidth = 3;
        [self.mapView updateUserLocationRepresentation:pre];
        view.calloutOffset = CGPointMake(0, 0);
        view.canShowCallout = NO;
        self.userLocationAnnotationView = view;
    }
}
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!updatingLocation && self.userLocationAnnotationView != nil)
    {
        [UIView animateWithDuration:0.1 animations:^{
            double degree = userLocation.heading.trueHeading;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
        }];
    }
}

//
- (void)addMapView{
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, searchView.bottom, self.view.width, SCREEN_HEIGHT - searchView.height - STATUSBAR_HEIGHT)];
    self.mapView.delegate = self;
    //self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mapView];
    self.mapView.showsScale = NO;
    self.mapView.showsCompass = NO;
    //添加大头针
    //self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = 2;
    [self addLocationButt];
    //
}

- (void)addDisttributeOrderButt{
    WS(weakSelf);
    CustomerImageButt *disttributeButt = [[CustomerImageButt alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.373, SCREEN_WIDTH * 0.373 * 0.39)];
    disttributeButt.center = CGPointMake(self.view.width / 2, SCREEN_HEIGHT / 2 - searchView.height - STATUSBAR_HEIGHT);
    //disttributeButt.backgroundColor = [UIColor whiteColor];
    [disttributeButt.imageView setImage:[UIImage imageNamed:@"dispatchOnMap"]];
    disttributeButt.clickButtBlock = ^{
        LaunchPiesViewController *launchVC = [[LaunchPiesViewController alloc]init];
        [weakSelf.navigationController pushViewController:launchVC animated:YES];
    };
    [self.view addSubview:disttributeButt];
}

//动态添加标记
- (void)addAnnotations:(CLLocationCoordinate2D)targetLocation{
    if (self.annotations.count){
        [self.mapView removeAnnotations:self.annotations];
        [self.annotations removeAllObjects];
    }
    double latitudeValue = targetLocation.latitude;
    double longitudeValue = targetLocation.longitude;
    //模拟随机位置标注经纬度
    NSInteger moniCount = 45;
    NSInteger perGroupCount = moniCount / 4;
    for (int i = 0; i < moniCount; i ++){
        double newLatitude = 0;
        double newLongitude = 0;
        
        int x = arc4random() % 80 + 4;
        double randomDoubleX = x / 3000.000;
        //
        int y = arc4random() % 80 + 4;
        double randomDoubleY = y / 3000.000;
        //
        if (i < perGroupCount){//右上方
            
                newLatitude = latitudeValue + randomDoubleX;
                newLongitude = longitudeValue + randomDoubleY;
        
        }else if ((i > perGroupCount ) && (i < perGroupCount * 2)){
            if (i / 2){//左下
                newLatitude = latitudeValue - randomDoubleX;
                newLongitude = longitudeValue - randomDoubleY;
            }else{//左
                newLatitude = latitudeValue;
                newLongitude = longitudeValue - randomDoubleY;
            }
        }else if ((i > perGroupCount * 2) && (i < perGroupCount * 3)){
            if (i / 2){//左上
                newLatitude = latitudeValue + randomDoubleX;
                newLongitude = longitudeValue - randomDoubleY;
            }else{//右
                newLatitude = latitudeValue;
                newLongitude = longitudeValue + randomDoubleY;
            }
            
        }else{//右下
            newLatitude = latitudeValue - randomDoubleX;
            newLongitude = longitudeValue + randomDoubleY;
        }
        CLLocationCoordinate2D coordinate = {newLatitude,newLongitude};
        MAPointAnnotation *pointAnotion = [[MAPointAnnotation alloc]init];
        pointAnotion.coordinate = coordinate;
        //NSLog(@"newLatitude=%lf,newLongitude=%lf",newLatitude,newLongitude);
        [self.annotations addObject:pointAnotion];
    }
    //
    [self.mapView addAnnotations:self.annotations];
    [self.mapView setCenterCoordinate:targetLocation];
    
}

/*!
 @brief 根据anntation生成对应的View
 @param mapView 地图View
 @param annotation 指定的标注
 @return 生成的标注View
 */
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        //NSLog(@"viewForAnnotation 执行了");
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout               = NO;
        //实现自定义图片必须关闭动画效果
        annotationView.animatesDrop                 = NO;
        annotationView.draggable                    = NO;
        [annotationView setImage:[UIImage imageNamed:@"work_person2"]];
        return annotationView;
    }
    NSLog(@"viewForAnnotation 没有执行");
    return nil;
}


/*!
 @brief 当选中一个annotation views时调用此接口
 @param mapView 地图View
 @param views 选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    NSLog(@"annotationView 点击");
}

/**
 *  标注view的calloutview整体点击时调用此接口
 *
 *  @param mapView 地图的view
 *  @param view calloutView所属的annotationView
 */
- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view {
    
}

-(void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
    if (wasUserAction){
        //平移式自动生成标注显示
        [self addAnnotations:self.mapView.centerCoordinate];
    }
}

-(void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction{
}
-(void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction{
}

- (void)addSearchView{
    WS(weakSelf);
    //
    searchView = [[searchHeaderView alloc]initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT, self.view.width, SCREEN_HEIGHT * 0.06)];
    searchView.navReturnButt.clickButtBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    searchView.searchView.placeholder = @"输入搜索内容";
    searchView.searchView.searchTextFieldBlock = ^(NSString *targetStr) {
        [weakSelf searchTextField:targetStr];
    };
    [self.view addSubview:searchView];
}


//放大缩小等
- (void)addLocationButt{
    UIView *zoomPannelView = [self makeZoomPannelView];
    zoomPannelView.center = CGPointMake(self.view.bounds.size.width -  CGRectGetMidX(zoomPannelView.bounds) - 10,
                                        self.view.bounds.size.height -  CGRectGetMidY(zoomPannelView.bounds) - 10);
    
    zoomPannelView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self.view addSubview:zoomPannelView];
    
    self.gpsButton = [self makeGPSButtonView];
    self.gpsButton.center = CGPointMake(SCREEN_WIDTH -  10  -  self.gpsButton.width / 2, 10 + self.gpsButton.height / 2 + NAVIGATION_HEIGHT + STATUSBAR_HEIGHT);
    [self.view addSubview:self.gpsButton];
    self.gpsButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
}
- (UIButton *)makeGPSButtonView {
    UIButton *gpsButt = [UIButton buttonWithType:UIButtonTypeCustom];
    gpsButt.frame = CGRectMake(0, 0, 40, 40);
    gpsButt.backgroundColor = [UIColor whiteColor];
    gpsButt.layer.cornerRadius = 4;
    
    [gpsButt setImage:[UIImage imageNamed:@"gpsStat1"] forState:UIControlStateNormal];
    [gpsButt addTarget:self action:@selector(gpsAction) forControlEvents:UIControlEventTouchUpInside];
    
    return gpsButt;
}

- (UIView *)makeZoomPannelView
{
    UIView *ret = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 53, 98)];
    
    UIButton *incBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 49)];
    [incBtn setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
    [incBtn sizeToFit];
    [incBtn addTarget:self action:@selector(zoomPlusAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *decBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 49, 53, 49)];
    [decBtn setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
    [decBtn sizeToFit];
    [decBtn addTarget:self action:@selector(zoomMinusAction) forControlEvents:UIControlEventTouchUpInside];
    [ret addSubview:incBtn];
    [ret addSubview:decBtn];
    return ret;
}

- (void)zoomPlusAction
{
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom + 1) animated:YES];
}

- (void)zoomMinusAction
{
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom - 1) animated:YES];
}

- (void)gpsAction {
    if(self.mapView.userLocation.updating && self.mapView.userLocation.location) {
        [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
        [self.gpsButton setSelected:YES];
        //重新生成标记
        [self addAnnotations:location.coordinate];
        [self.mapView setZoomLevel:zoomLevel];
    }
}
//地图视角居中显示
//-(void)centerMapViewSetting{
//    if(self.mapView.userLocation.updating && self.mapView.userLocation.location) {
//        [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
//    }
//}

/*!
 @brief 拖动annotation view时view的状态变化，ios3.2以后支持
 @param mapView 地图View
 @param view annotation view
 @param newState 新状态
 @param oldState 旧状态
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState {
    
}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
