//
//  NSString+OwnDealNullStr.m
//  鲁班同城
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "NSString+OwnDealNullStr.h"

@implementation NSString (OwnDealNullStr)

+ (NSString*)getResultStrBySeverStr:(NSString*)targetStr{
    NSString *dealStr = targetStr;
    if ([targetStr isKindOfClass:[NSNull class]]){
        dealStr = @"";
    }else if (dealStr.length){
        dealStr = [targetStr copy];
    }else{
        dealStr = @"";
    }
    return dealStr;
}

+(BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}

+(NSString*)getStateStrByStateID:(NSInteger)stateId{
    NSString *stateStr = @"";
    switch (stateId) {
        case 0:
            stateStr = @"派单中";
            break;
        case 1:
            stateStr = @"接单人满";
            break;
        case 2:
            stateStr = @"已付款";
            break;
        case 3:
            stateStr = @"已雇佣";
            break;
        case 4:
            stateStr = @"已退款";
            break;
        case 5:
            stateStr = @"确认接单";
            break;
        case 6:
            stateStr = @"已完成";
            break;
        case 7:
            stateStr = @"已取消";
            break;
        default:
            break;
    }
    return stateStr;
}



@end
