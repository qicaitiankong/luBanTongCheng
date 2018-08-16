//
//  NSString+OwnDealNullStr.m
//  鲁班同城
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "NSString+OwnDealNullStr.h"
#import<CommonCrypto/CommonDigest.h>


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


+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

+ (NSString*)getMd5JiaMi:(NSString*)input{
    const char *cStr = [input UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        
        [output appendFormat:@"%02x", digest[i]];
    
    
    
    return  output;
}




@end
