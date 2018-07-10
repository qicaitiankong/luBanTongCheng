//
//  CompanyCruitDetailModel.m
//  鲁班同城
//
//  Created by apple on 2018/7/10.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CompanyCruitDetailModel.h"

@implementation CompanyCruitDetailModel

+ (CompanyCruitDetailModel*)setModelFromDict:(NSDictionary*)dict{
    CompanyCruitDetailModel *model = [[CompanyCruitDetailModel alloc]init];
    if (dict){
        
    }else{
        model.jobNameStr = @"我要找修空调的师傅1名";
        model.detailContentStr = @"这里显示详情。这里显示详情这里显示详情这里显示详情这里显示详情这里显示详情这里显示详情这里显示详情。";
    }
    return model;
}

@end
