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
#import "CommonUtility.h"
//
#import "LaunchPiesViewController.h"
#import "searchHeaderView.h"

@interface DispatchOrderMapViewController ()<MAMapViewDelegate,AMapSearchDelegate>{
    CLLocation *location;
    searchHeaderView *searchView;
    AMapGeocodeSearchRequest *searchGeo;
    AMapSearchAPI *searchAPI;
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
    self.title = @"派单";
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
    [self addLocationButt];
}

- (void)initOwnObjects{
     self.dispatchOrderImage = [UIImage imageNamed:@"dispatchOnMap"];
    searchAPI = [[AMapSearchAPI alloc]init];
    searchGeo = [[AMapGeocodeSearchRequest alloc]init];
    searchAPI.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    MAMapView *mapView = self.mapView;
    location =  mapView.userLocation.location;
    NSLog(@"定位位置：location.altitude%lf,location.coordinate%lf",location.coordinate.latitude,location.coordinate.longitude);
    if (self.annotations.count == 0){
        [self addAnnotations:location.coordinate];
    }
}
//logic
- (void)searchTextField:(NSString*)targetStr{
    searchGeo.address = targetStr;
    [searchAPI AMapGeocodeSearch:searchGeo];
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0)
    {
        return;
    }
    //解析response获取地理信息
    NSMutableArray *annotations = [NSMutableArray array];
    
    [response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode *obj, NSUInteger idx, BOOL *stop) {
        GeocodeAnnotation *geocodeAnnotation = [[GeocodeAnnotation alloc] initWithGeocode:obj];
        [annotations addObject:geocodeAnnotation];
    }];
    
    if (annotations.count == 1)
    {
        [self.mapView setCenterCoordinate:[annotations[0] coordinate] animated:YES];
    }
    else
    {
        [self.mapView setVisibleMapRect:[CommonUtility minMapRectForAnnotations:annotations]
                               animated:YES];
    }
    [self addAnnotations:[annotations[0] coordinate]];
    
}
//logic end

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
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = 2;
    [self addLocationButt];
    //
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{

    for (int k = 0; k < views.count; k ++){
        MAAnnotationView *view = views[k];
        // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
        if ([view.annotation isKindOfClass:[MAUserLocation class]])
        {
            MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
            //pre.fillColor = SPECIAL_BLUE_COLOR;
            pre.strokeColor = SPECIAL_BLUE_COLOR;
            if (k == 0){
                 [pre setImage:self.dispatchOrderImage];
                //self.userLocationAnnotationView = view;

            }else{

            }
            pre.lineWidth = 3;
           
            //[self.mapView updateUserLocationRepresentation:pre];
            }
    }
}
//动态添加标记
- (void)addAnnotations:(CLLocationCoordinate2D)targetLocation{
    if (self.annotations){
        [self.mapView removeAnnotations:self.annotations];
        [self.annotations removeAllObjects];
    }
    self.annotations = [NSMutableArray array];
    double latitudeValue = targetLocation.latitude;
    double longitudeValue = targetLocation.longitude;
    //模拟随机位置标注经纬度
    NSInteger moniCount = 32;
    NSInteger perGroupCount = moniCount / 4;
    for (int i = 0; i < moniCount; i ++){
        double newLatitude = 0;
        double newLongitude = 0;
        
        int x = arc4random() % 10 + 4;
        double randomDoubleX = x / 3000.000;
        //
        int y = arc4random() % 10 + 1;
        double randomDoubleY = y / 3000.000;
        //
        if (i < perGroupCount){
            if (i == 0){
                newLatitude = latitudeValue;
                newLongitude = longitudeValue;
            }else{
                newLatitude = latitudeValue + randomDoubleX;
                newLongitude = longitudeValue + randomDoubleY;
            }
            
        }else if ((i > perGroupCount ) && (i < perGroupCount * 2)){
            if (i / 2){
                newLatitude = latitudeValue - randomDoubleX;
                newLongitude = longitudeValue - randomDoubleY;
            }else{
                newLatitude = latitudeValue;
                newLongitude = longitudeValue - randomDoubleY;
            }
        }else if (i > perGroupCount * 2 && i < perGroupCount * 3){
            if (i / 2){
                newLatitude = latitudeValue + randomDoubleX;
                newLongitude = longitudeValue - randomDoubleY;
            }else{
                newLatitude = latitudeValue;
                newLongitude = longitudeValue + randomDoubleY;
            }
            
        }else{
            newLatitude = latitudeValue - randomDoubleX;
            newLongitude = longitudeValue + randomDoubleY;
        }
        //
        MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
        CLLocationCoordinate2D coordinate = {newLatitude,newLongitude};
        //NSLog(@"newLatitude=%lf,newLongitude=%lf",newLatitude,newLongitude);
        a1.coordinate = coordinate;
        [self.annotations addObject:a1];
    }
    //
    [self.mapView addAnnotations:self.annotations];
    //[self.mapView setVisibleMapRect:[CommonUtility minMapRectForAnnotations:self.annotations]
                      //     animated:YES];
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
        
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout               = NO;
        annotationView.animatesDrop                 = NO;
        annotationView.draggable                    = YES;
        annotationView.image = [UIImage imageNamed:@"work_person"];
        return annotationView;
    }
    
    return nil;
}



/*!
 @brief 当选中一个annotation views时调用此接口
 @param mapView 地图View
 @param views 选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    NSLog(@"annotationView 点击");
    if([view.image isEqual:self.dispatchOrderImage]){
        LaunchPiesViewController *launchVC = [[LaunchPiesViewController alloc]init];
        [self.navigationController pushViewController:launchVC animated:YES];
    }
    
}

/**
 *  标注view的calloutview整体点击时调用此接口
 *
 *  @param mapView 地图的view
 *  @param view calloutView所属的annotationView
 */
- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view {
    
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
    }
}

/*!
 @brief 拖动annotation view时view的状态变化，ios3.2以后支持
 @param mapView 地图View
 @param view annotation view
 @param newState 新状态
 @param oldState 旧状态
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState {
    
}


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
