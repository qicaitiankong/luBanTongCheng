//
//  TDHttpTools.h
//  TD
//
//  Created by 霸枪001 on 2017/3/24.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger , RequestMethodType) {
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2
};
@interface TDHttpTools : NSObject

/**
 *  json格式
 *
 *  @param methodTypr <#methodTypr description#>
 *  @param urlString  <#urlString description#>
 *  @param params     <#params description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+(void)requestWithMethodType:(RequestMethodType)methodTypr Url:(NSString *)urlString params:(id)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;


/**
 *  XML格式
 *
 *  @param methodType <#methodType description#>
 *  @param urlString  <#urlString description#>
 *  @param params     <#params description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+(void)requestXmlWithMethodType:(RequestMethodType)methodType Url:(NSString *)urlString params:(id)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;


+(void)loginWXWithText:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
//
//获取零工用户信息
+(void)getCapsualUserInfo:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//派单
+(void)launchOder:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;


//工作职业列表
+(void)getJobList:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//获取技能列表
+(void)getTechnologyList:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//接单大厅
+(void)getReceiveOrderList:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;


//零工接单详情
+(void)getCasualTakeOrderDetail:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//零工接单
+(void)CasualTakeOrder:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;





//
//雇佣
+(void)EmplyeerEmploy:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//雇主评价
+(void)EmplyeerComment:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//雇主派单详情
+(void)getEmployerLauchPieDetail:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//派单大厅列表
+(void)getLauchOrderList:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//我的
+(void)getEmployerMyPage:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;


@end
