//
//  NSDictionary+DealNullServiceDict.m
//  鲁班同城
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "NSDictionary+DealNullServiceDict.h"

@implementation NSDictionary (DealNullServiceDict)

//处理后台返回为空类
+ (NSDictionary*)getResultDictBySeverDict:(NSDictionary*)targetDict{
    NSDictionary *dealDict =  nil;
    if ([targetDict isKindOfClass:[NSNull class]]){
        dealDict = @{};
    }else{
        dealDict = [targetDict copy];
    }
    return dealDict;
}
@end
