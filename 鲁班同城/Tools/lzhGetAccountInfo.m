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
        selfClass.infoDict = dic;
        NSLog(@" getAccount 时  dict:%@",dic);
        if ([dic allKeys].count) {
           
            if ([[dic allKeys] containsObject:@"userType"]){
                 NSString *userType = [dic[@"userType"] copy];
                if ([userType isEqualToString:@"雇主"]){
                    selfClass.identityFlag = 1;
                }else if ([userType isEqualToString:@"零工"]){
                    selfClass.identityFlag = 0;
                }
            }else{
                selfClass.identityFlag = 0;
            }
            //
            if ([selfClass.nickName isKindOfClass:[NSNull class]]){
                selfClass.nickName = @"昵称1";

            }else{
                selfClass.nickName = [dic[@"username"] copy];

            }
            
            
            
            
        }
        
    }
    return selfClass;
}


- (void)writeToAccount:(NSDictionary*)dict{
     NSDictionary *newDict = @{@"userType":dict[@"userType"]};
    BOOL suc = [newDict writeToFile:kAccountPath atomically:YES];
   
    if (suc){
        NSLog(@"身份信息已更改写入本地成功");
        [SVProgressHUD showSuccessWithStatus:@"身份信息已更改写入本地成功"];
    }else{
        [SVProgressHUD showErrorWithStatus:@"身份信息已更改写入本地失败"];
        NSLog(@"身份信息更改写入本地失败");
    }
}




@end
