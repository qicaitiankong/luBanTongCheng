//
//  NSArray+OwnArrCopy.m
//  鲁班同城
//
//  Created by apple on 2018/8/7.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "NSArray+OwnArrCopy.h"

@implementation NSArray (OwnArrCopy)

+ (NSMutableArray*)getOwnCopyArr:(NSArray*)tagetArr{
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    if (tagetArr.count){
        for (id anyId in tagetArr){
            id anyOwnObject = [anyId copy];
            [resultArr addObject:anyOwnObject];
        }
    }
    return resultArr;
}

+ (NSMutableArray*)getTargetArr:(NSArray*)orinalArr keyStr:(NSString*)key{
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    if (orinalArr.count){
        for (NSDictionary *dict in orinalArr){
            [resultArr addObject:[dict[key]copy]];
        }
    }
    return resultArr;
}

//处理后台返回数组为空类
+ (NSMutableArray*)getResultArrBySeverArr:(NSArray*)targetArr{
    NSMutableArray *dealArr =  nil;
    if ([targetArr isKindOfClass:[NSNull class]]){
        dealArr = (NSMutableArray*)@[];
    }else{
        dealArr = (NSMutableArray*)targetArr;
    }
    return dealArr;
}





@end
