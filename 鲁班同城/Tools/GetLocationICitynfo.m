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

+ (GetLocationICitynfo*)getLocationInfo{
    GetLocationICitynfo *locationInfo = [[GetLocationICitynfo alloc]init];
    if (locationInfo){
        //NSDictionary *locationDict = @{@"country":country,@"provice":proviceStr,@"city":locationCity,@"area":area,@"street":street,@"detailStreet":name};
        NSDictionary *locationDict = [NSDictionary dictionaryWithContentsOfFile:kLocationAccountInfoPath];
        if (locationDict && [locationDict allKeys].count){
            locationInfo.countryStr = [locationDict[@"country"] copy];
            
            locationInfo.provinceStr = [locationDict[@"provice"] copy];
            locationInfo.cityStr = [locationDict[@"city"] copy];
            locationInfo.areaStr = [locationDict[@"area"] copy];
            locationInfo.streetStr = [locationDict[@"street"] copy];
            locationInfo.detailStreetStr = [locationDict[@"detailStreet"] copy];
        }
    }
    return locationInfo;
}


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
     __block NSString *country = @"";
    __block NSString *locationCity = @"";
     __block NSString *proviceStr = @"";
    __block NSString *area = @"";
    __block NSString *street = @"";
    __block NSString *subStreet = @"";
    __block NSString *name = @"";
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place  in placemarks){
             NSLog(@"locality,%@",place.locality);              // 市
           
            if (!locationCity) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                
                locationCity = [place.administrativeArea copy];
            }else{
                 locationCity = [place.locality copy];
            }
            
            if (place.country){
                country = [place.country copy];
            }
            
            if (place.administrativeArea){
                proviceStr = [place.administrativeArea copy];
            }
            if (place.subLocality){
                area = [place.subLocality copy];
            }
            if (place.thoroughfare){
                street = [place.thoroughfare copy];
            }
            if (subStreet){
                subStreet = [place.subThoroughfare copy];
            }
            if (place.name){
                name = [place.name copy];
            }
            NSDictionary *locationDict = @{@"country":country,@"provice":proviceStr,@"city":locationCity,@"area":area,@"street":street,@"detailStreet":name};
            BOOL suc = [locationDict writeToFile:kLocationAccountInfoPath atomically:YES];
            if (suc){
                NSLog(@"定位信息写入plist成功");
            }else{
                 NSLog(@"定位信息写入plist失败");
            }
        }
        if (weakSelf.getLocationInfoBlock){
            weakSelf.getLocationInfoBlock();
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
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSString *country = @"";
        NSString *locationCity = @"";
        NSString *proviceStr = @"";
        NSString *area = @"";
        NSString *street = @"";
        NSString *subStreet = @"";
        NSString *name = @"";
        for (CLPlacemark *place  in placemarks){
            if (!locationCity) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                
                locationCity = [place.administrativeArea copy];
            }else{
                locationCity = [place.locality copy];
            }
            //
            if (place.country){
                country = [place.country copy];
            }
            
            if (place.administrativeArea){
               proviceStr = [place.administrativeArea copy];
            }
            if (place.subLocality){
                area = [place.subLocality copy];
            }
            if (place.thoroughfare){
               street = [place.thoroughfare copy];
            }
            if (subStreet){
                subStreet = [place.subThoroughfare copy];
            }
            if (place.name){
                name = [place.name copy];
            }
            NSLog(@"name=%@",name);
        }
        NSDictionary *locationDict = @{@"country":country,@"provice":proviceStr,@"city":locationCity,@"area":area,@"street":name,@"detailStreet":name};
        BOOL suc = [locationDict writeToFile:kLocationAccountInfoPath atomically:YES];
        if (suc){
            NSLog(@"定位信息写入plist成功");
        }else{
            NSLog(@"定位信息写入plist失败");
        }
        if (weakSelf.getLocationInfoBlock){
            weakSelf.getLocationInfoBlock();
        }
    }];

}



@end
