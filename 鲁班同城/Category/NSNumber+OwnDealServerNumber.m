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
//
+ (NSNumber*)getResultBoolNumberBySeverStr:(NSNumber*)targetNumber{
    NSNumber *resultNum = targetNumber;
    if ([resultNum isKindOfClass:[NSNull class]]){
        resultNum = [NSNumber numberWithBool:NO];
    }else{
        resultNum = targetNumber;
    }
    return resultNum;
}

+ (NSString*)getMinutesFormat:(NSInteger)time{
    NSInteger miniute = 0;
    NSInteger seconds = 0;
    if (time % 60){
        miniute = time / 60;
        seconds = time - miniute * 60;
    }else{
        seconds = time;
    }
    NSDictionary *resultDict = @{@"minute":[NSNumber numberWithInteger:miniute],@"second":[NSNumber numberWithInteger:seconds]};
    return [NSString stringWithFormat:@"%02ld:%02ld",miniute,seconds];
}


@end
