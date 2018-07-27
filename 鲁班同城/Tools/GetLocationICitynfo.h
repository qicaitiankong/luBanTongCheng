//
//  GetLocationICitynfo.h
//  鲁班同城
//
//  Created by apple on 2018/7/25.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetLocationICitynfo : NSObject

@property (strong,nonatomic) NSString *countryStr;

@property (strong,nonatomic) NSString *provinceStr;

@property (strong,nonatomic) NSString *cityStr;

@property (strong,nonatomic) NSString *areaStr;

@property (strong,nonatomic) NSString *streetStr;

@property (strong,nonatomic) NSString *detailStreetStr;

@property (copy,nonatomic) void (^getLocationInfoBlock)(void);

//定位用户位置
-(void)startLocation;

//获取定位信息
+ (GetLocationICitynfo*)getLocationInfo;


//通过CLLocation跟新用户选择的地点具体信息
- (void)getLocationInfoByUserLocaotion:(CLLocation*)location;




@end
