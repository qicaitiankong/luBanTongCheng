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

//切换用户身份
+(void)exchangeUserIdentity:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;



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

//零工抢单
+(void)CasualScramebleTakeOrder:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//零工确认接单
+(void)CasualSureTakeOrder:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//零工取消接单
+(void)casualCancelTakeOrder:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//零工修改个人信息
+ (void)capsualChangeOwnInfo:(NSDictionary*)paraDict traileUrlStr:(NSString*)traileUrlStr imageFlagNameArr:(NSArray*)imageNameArr picDataArr:(NSArray*)targetPictureDataArr soundNameData:(NSData*)nameData soundExperienceData:(NSData*)experienceData
                videoDataArr:(NSArray*)targetVideoDataArr success:(void (^)(id response))uploadSuccess failure:(void (^)(NSError *error))upLoadfailure;

//我抢过的派单
+(void)casualTookTicked:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
//我被雇佣的派单
+(void)getmyHiredTicked:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;





//雇主接口

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

//排行榜
+(void)getRankList:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;




///统一使用
//雇佣记录
+(void)getGuYongRecordList:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//我的关注
+(void)getMyConcernList:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//我的粉丝
+(void)getMyFans:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//反馈消息
+(void)backWardInfo:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//添加关注
+(void)AddConcernAction:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//取消关注
+(void)CancelConcernAction:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
//

//上传单张图片 traileUrlStr;尾部url路径 imageFlagName:接口图片字段名
+ (void)uploadFile:(NSDictionary*)paraDict traileUrlStr:(NSString*)traileUrlStr imageFlagName:(NSString*)imageName imageDataArr:(NSArray*)targetDataArr success:(void (^)(id response))uploadSuccess failure:(void (^)(NSError *error))upLoadfailure;


//

//获取单张图片信息
+(void)getSinglePicture:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//获取多张图片信息
+(void)getSeveralPicture:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;


//获取单个音频信息
+(void)getSingleAudio:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//
//获取多个音频信息
+(void)getSeveralAudio:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;



@end
