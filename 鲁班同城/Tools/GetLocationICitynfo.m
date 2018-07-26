//
//  GetLocationICitynfo.m
//  鲁班同城
//
//  Created by apple on 2018/7/25.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "GetLocationICitynfo.h"
#import <MapKit/MapKit.h>


@interface GetLocationICitynfo ()<CLLocationManagerDelegate>{
    
}
@property (strong,nonatomic) CLLocationManager* locationManager;


@end


@implementation GetLocationICitynfo

//开始定位

-(void)startLocation{
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.locationManager.distanceFilter = 100.0f;
    
    if ([[[UIDevice currentDevice]systemVersion]doubleValue] >8.0){
        
        [self.locationManager requestWhenInUseAuthorization];
        
    }
    
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//
//        _locationManager.allowsBackgroundLocationUpdates =YES;
//
//    }
    
    [self.locationManager startUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *newLocation = locations[0];
    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
    NSLog(@"首页 旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
    [manager stopUpdatingLocation];
    //
    WS(weakSelf);
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    __block NSString *locationCity = @"城市";
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place  in placemarks){
             NSLog(@"locality,%@",place.locality);              // 市
            locationCity = [place.locality copy];
        }
        if (weakSelf.getLocationCityBlock){
            weakSelf.getLocationCityBlock(locationCity);
        }
    }];

}

//
- (void)getLocationInfoByUserLocaotion:(CLLocation*)location{
    CLLocation *newLocation = location;
    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
    NSLog(@"首页 旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
    //
    WS(weakSelf);
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    __block NSString *locationCity = @"城市";
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSString *locationCity = @"";
        for (CLPlacemark *place  in placemarks){
            NSLog(@"locality,%@",place.locality);              // 市
            locationCity = [place.locality copy];
        }
        if (weakSelf.getLocationCityDetailInfo){
            //weakSelf.getLocationCityDetailInfo(locationCity, locationCity, <#NSString *area#>)
        }
    }];

}



@end
