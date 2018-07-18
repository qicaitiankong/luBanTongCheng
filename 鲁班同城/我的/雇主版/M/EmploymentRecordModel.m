//
//  EmploymentRecordModel.m
//  鲁班同城
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "EmploymentRecordModel.h"

@implementation EmploymentRecordModel

+ (EmploymentRecordModel*)setModelFromDict:(NSDictionary*)dict{
    EmploymentRecordModel *model = [[EmploymentRecordModel alloc]init];
    if (model){
        model.topNameStr = @"零工";
        model.companyNameStr = @"公司名字";
        model.stateStr = @"已完成";
        model.timeStr = @"7.9 上周日 22.28";
        model.addressStr = @"青岛市李沧区万年泉路青岛市李沧区万年泉路青岛市李沧区万年泉路";
    }
    return model;
}

@end
