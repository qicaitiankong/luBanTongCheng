//
//  GetLocationICitynfo.h
//  鲁班同城
//
//  Created by apple on 2018/7/25.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetLocationICitynfo : NSObject

@property (copy,nonatomic) void (^getLocationCityBlock)(NSString *name);

-(void)startLocation;


@end
