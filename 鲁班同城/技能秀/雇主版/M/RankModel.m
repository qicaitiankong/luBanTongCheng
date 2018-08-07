//
//  RankModel.m
//  鲁班同城
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "RankModel.h"

@implementation RankModel

+ (RankModel*)setModelFromDict:(NSDictionary*)dict{
    RankModel *model = [[RankModel alloc]init];
    if (model){
        
//        "number": 1,                //排名
//        "headImg": "afewef",        //头像路径
//        "userId": 3,                //用户id
//        "userName": "李四",         //用户姓名
        model.userIdNum = dict[@"userId"];
        
        NSNumber *rankNum = [NSNumber getResultNumberBySeverStr:dict[@"number"]];
        model.rankStr = [NSString stringWithFormat:@"No.%ld",[rankNum integerValue]];
        model.imageUrlStr = [NSString getResultStrBySeverStr:dict[@"headImg"]];
        model.nickName = [NSString getResultStrBySeverStr:dict[@"userName"]];
        
        NSArray *technologyArr = dict[@"technologys"];
        model.jobStr = [technologyArr componentsJoinedByString:@" "];
        
    }
    return model;
}

@end
