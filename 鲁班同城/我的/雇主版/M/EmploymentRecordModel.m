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
//        "workerName": "李四",       //被雇佣的零工姓名
//        -"technologys": [           //派单的技能要求（仅名称）
//                         "技能1",
//                         "技能2",
//                         "技能3"
//                         ],
//        "createTime": "2018-07-26",     //发起派单的时间
//        "address": "详细地址",          //派单时填写的详细地址（不包含省、市、区）
//        "state": 5
        model.topNameStr = [NSString getResultStrBySeverStr:dict[@"workerName"]];
        model.companyNameStr = @"公司名称";
        NSNumber *stateNum = dict[@"state"] ;
        model.stateStr = [NSString getStateStrByStateID:[stateNum integerValue]];
        model.timeStr = [NSString getResultStrBySeverStr:dict[@"createTime"]];
        model.addressStr = [NSString getResultStrBySeverStr:dict[@"address"]];
        
        model.addressHeight =  [LzhReturnLabelHeight getLabelHeight:model.addressStr font:[UIFont getPingFangSCMedium:14] width:SCREEN_WIDTH - 20];
    }
    return model;
}

@end
