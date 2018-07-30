//
//  NSNumber+OwnDealServerNumber.m
//  鲁班同城
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "NSNumber+OwnDealServerNumber.h"

@implementation NSNumber (OwnDealServerNumber)

+ (NSNumber*)getResultNumberBySeverStr:(NSNumber*)targetNumber{
    NSNumber *resultNum = targetNumber;
    if ([resultNum isKindOfClass:[NSNull class]]){
        resultNum = [NSNumber numberWithInteger:0];
    }else{
        resultNum = targetNumber;
    }
    return resultNum;
}

@end
