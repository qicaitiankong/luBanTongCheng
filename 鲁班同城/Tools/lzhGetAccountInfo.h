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
@property (strong,nonatomic) NSDictionary *infoDict;

//0:零工， 1：雇主
@property (assign,nonatomic) NSInteger identityFlag;

@property (assign,nonatomic) NSNumber *userID;
//userCode
@property (strong,nonatomic) NSString *userCode;


@property(nonatomic,strong)NSString *PhotoUrl;

@property(nonatomic,strong)NSString *nickName;

@property(nonatomic,strong)NSString *userName;

@property (strong,nonnull)  NSString *ageStr;

@property(nonatomic,strong)NSString *mobile;

@property(nonatomic,strong)NSString *sexStr;

@property (assign,nonatomic) NSInteger fansCount;

@property (assign,nonatomic) NSInteger fousCount;

+ (lzhGetAccountInfo *)getAccount;

- (void)writeToAccount:(NSDictionary*)dict;

//清除账户信息
+ (void)cleanAccountInfo;


@end
