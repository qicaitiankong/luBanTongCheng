//
//  lzhGetAccountInfo.h
//  易彩票
//
//  Created by corill002 on 2017/11/22.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import <Foundation/Foundation.h>
//获取手机账号信息
@interface lzhGetAccountInfo : NSObject
//0:零工， 1：雇主
@property (assign,nonatomic) NSInteger identityFlag;

@property(nonatomic,copy)NSString *PhotoUrl;
@property(nonatomic,copy)NSString *CName;
@property(nonatomic,copy)NSString *UserMoney;
@property(nonatomic,copy)NSString *Certification;
@property(nonatomic,copy)NSString *IsPayPwd;
@property(nonatomic,copy)NSString *LoginName;

+ (lzhGetAccountInfo *)getAccount;

- (void)writeToAccount:(NSDictionary*)dict;


@end
