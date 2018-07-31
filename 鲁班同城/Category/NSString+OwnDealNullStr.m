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



@end
