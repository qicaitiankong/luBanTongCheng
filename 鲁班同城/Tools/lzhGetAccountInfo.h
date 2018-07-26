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

@property(nonatomic,strong)NSString *PhotoUrl;

@property(nonatomic,strong)NSString *nickName;

@property(nonatomic,strong)NSString *userName;

@property (strong,nonnull)  NSString *ageStr;


+ (lzhGetAccountInfo *)getAccount;

- (void)writeToAccount:(NSDictionary*)dict;


@end
