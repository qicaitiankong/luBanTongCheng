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
        model.rankStr = @"No.1";
        model.userImage = [UIImage imageNamed:@"test01"];
        model.nickName = @"昵称昵称";
        model.jobStr = @"木匠  电工";
        
    }
    return model;
}

@end
