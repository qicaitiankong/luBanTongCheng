//
//  ChooseTechnologyLeftModel.m
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ChooseTechnologyLeftModel.h"

@implementation ChooseTechnologyLeftModel

+ (ChooseTechnologyLeftModel*)setModelFromDict:(NSDictionary*)modelDict{
    ChooseTechnologyLeftModel *localModel = [[ChooseTechnologyLeftModel alloc]init];
    localModel.title = [modelDict[@"name"] copy];
    localModel.idFlag = [modelDict[@"id"] integerValue];
    localModel.parentId = [modelDict[@"parentId"] integerValue];
    return localModel;
}


@end
