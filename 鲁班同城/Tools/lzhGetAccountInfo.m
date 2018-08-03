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
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:kAccountPath];
        selfClass.infoDict = dict;
      
        if ([dict allKeys].count) {
           
            if ([[dict allKeys] containsObject:@"userType"]){
                 NSNumber *userType = dict[@"userType"];
                //后台是用1：零工 2：雇主
                //我本地：0:零工， 1:雇主
                if ([userType integerValue] == 2){
                    selfClass.identityFlag = 1;
                }else if ([userType integerValue] == 1){
                    selfClass.identityFlag = 0;
                }
                //
            }else{//设置默认是零工还是雇主
                selfClass.identityFlag = 2;
            }
              NSLog(@" getAccount 时  dict:%@",dict);
            NSNumber *userID = nil;
            NSString *realName = @"";
            NSString *nickName = @"";
            NSString *mobile = @"";
            NSString *headImg = @"";
            NSString *gender = @"";
            NSNumber *fansNum = [NSNumber numberWithInteger:0];
            NSNumber *focusNum = [NSNumber numberWithInteger:0];
            NSNumber *ageNum = [NSNumber numberWithInteger:0];
            if ([[dict allKeys] containsObject:@"realName"]){
                realName = dict[@"realName"];
                selfClass.userName = [realName copy];
            }else{
            }
            if ([[dict allKeys] containsObject:@"nickName"]){
                nickName = dict[@"nickName"];
                selfClass.nickName = [nickName copy];

            }else{
            }
            if ([[dict allKeys] containsObject:@"mobile"]){
                mobile = dict[@"mobile"];
                selfClass.mobile = [mobile copy];

            }else{
            }
            if ([[dict allKeys] containsObject:@"headImg"]){
                headImg = dict[@"headImg"];
                selfClass.PhotoUrl = [headImg copy];
            }else{
            }
            if ([[dict allKeys] containsObject:@"gender"]){
                gender = dict[@"gender"];
                selfClass.sexStr = [gender copy];
            }else{
            }
            if ([[dict allKeys] containsObject:@"fansNum"]){
                fansNum = dict[@"fansNum"];
                selfClass.fansCount = [fansNum integerValue];
            }else{
            }
            if ([[dict allKeys] containsObject:@"focusNum"]){
                focusNum = dict[@"focusNum"];
                selfClass.fousCount = [focusNum integerValue];
            }else{
            }
            if ([[dict allKeys] containsObject:@"age"]){
                ageNum = dict[@"age"];
                selfClass.ageStr = [ageNum stringValue];

            }else{
            }
            if ([[dict allKeys] containsObject:@"userID"]){
                userID = dict[@"userID"];
                selfClass.userID = userID;
            }else{
            }
        }
        
    }
    return selfClass;
}


- (void)writeToAccount:(NSDictionary*)dict{
//    age = "<null>";
//    fansNum = 0;
//    focusNum = 0;
//    gender = "\U7537";
//    headImg = "<null>";
//    id = 8;
//    mobile = "<null>";
//    realName = "<null>";
//    realNamePath = "<null>";
//    state = 0;
//    userType = "\U96c7\U4e3b";
//    username = "<null>";
    NSNumber *userType = dict[@"userType"];
    NSNumber *userID = nil;
    NSString *realName = @"";
    NSString *nickName = @"";
    NSString *mobile = @"";
    NSString *headImg = @"";
    NSString *gender = @"";
    NSNumber *fansNum = [NSNumber numberWithInteger:0];
    NSNumber *focusNum = [NSNumber numberWithInteger:0];
    NSNumber *ageNum = [NSNumber numberWithInteger:0];
    //方便测试写死了，以后改成id获取
    if ([[dict allKeys] containsObject:@"id"]){//针对于登入保存
         userID = dict[@"id"];
    }else{
        userID = [lzhGetAccountInfo getAccount].userID;
    }
   
    if ([[dict allKeys] containsObject:@"realName"]){
        realName = [NSString getResultStrBySeverStr:dict[@"realName"]];
    }else{
    }
    if ([[dict allKeys] containsObject:@"nickName"]){
        nickName = [NSString getResultStrBySeverStr:dict[@"nickName"]];
    }else{
    }
    if ([[dict allKeys] containsObject:@"mobile"]){
        mobile = [NSString getResultStrBySeverStr:dict[@"mobile"]];
    }else{
    }
    if ([[dict allKeys] containsObject:@"headImg"]){
        headImg = [NSString getResultStrBySeverStr:dict[@"headImg"]];
    }else{
    }
    if ([[dict allKeys] containsObject:@"gender"]){
        gender = [NSString getResultStrBySeverStr:dict[@"gender"]];
    }else{
    }
    if ([[dict allKeys] containsObject:@"fansNum"]){
        fansNum = [NSNumber getResultNumberBySeverStr:dict[@"fansNum"]];
    }else{
    }
    if ([[dict allKeys] containsObject:@"focusNum"]){
        focusNum = [NSNumber getResultNumberBySeverStr:dict[@"focusNum"]];
    }else{
    }
    if ([[dict allKeys] containsObject:@"age"]){
        ageNum = [NSNumber getResultNumberBySeverStr:dict[@"age"]];
    }else{
    }
    NSDictionary *newDict = @{@"userType":userType,@"userID":userID,@"userName":realName,@"nickName":nickName,@"gender":gender,@"age":ageNum,@"headImg":headImg,@"mobile":mobile,@"focusNum":focusNum,@"fansNum":fansNum};
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
