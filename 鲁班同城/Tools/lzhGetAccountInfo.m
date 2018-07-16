//
//  lzhGetAccountInfo.m
//  易彩票
//
//  Created by corill002 on 2017/11/22.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import "lzhGetAccountInfo.h"

@implementation lzhGetAccountInfo

+ (lzhGetAccountInfo *)getAccount{
    
    lzhGetAccountInfo *selfClass = [[lzhGetAccountInfo alloc]init];
    
    if (selfClass){
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:kAccountPath];
        
        if ([dic allKeys].count) {
            NSString *keyStr = IDENTITY_KEY_STRING;
            selfClass.identityFlag = [dic[keyStr] integerValue];
        }

    }
    return selfClass;
}


- (void)writeToAccount:(NSDictionary*)dict{
    BOOL suc = [dict writeToFile:kAccountPath atomically:YES];
    if (suc){
        [SVProgressHUD showSuccessWithStatus:@"身份信息已更改写入本地成功"];
    }else{
        [SVProgressHUD showErrorWithStatus:@"身份信息已更改写入本地失败"];
    }
}




@end
