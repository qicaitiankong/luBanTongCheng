//
//  TelephoneNumberTools.m
//  鲁班同城
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "TelephoneNumberTools.h"

@implementation TelephoneNumberTools

+ (BOOL)isMobile:(NSString*)numberStr{
    BOOL suc = NO;
    if (numberStr.length){
        NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        suc = [regextestmobile evaluateWithObject:numberStr];
    }
    return suc;
}


@end
