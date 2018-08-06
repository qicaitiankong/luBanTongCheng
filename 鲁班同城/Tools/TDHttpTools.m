//
//  TDHttpTools.m
//  TD
//
//  Created by 霸枪001 on 2017/3/24.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import "TDHttpTools.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

#define kSERVER_HTTP_DXE @"http://192.168.0.112"

@implementation TDHttpTools

/**
 *  返回json格式
 *
 *  @param methodType <#methodType description#>
 *  @param urlString  <#urlString description#>
 *  @param params     <#params description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+(void)requestWithMethodType:(RequestMethodType)methodType Url:(NSString *)urlString params:(id)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    [SVProgressHUD showWithStatus:@""];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",@"application/xhtml+xml",@"application/xml", nil];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    //id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    
                    [SVProgressHUD dismiss];
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    [SVProgressHUD dismiss];
                    failure(error);
                }
            }];
        }
            break;
        case RequestMethodTypePost:
        {
            [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    //id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    
                    [SVProgressHUD dismiss];
                    success(responseObject);
                    
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    [SVProgressHUD dismiss];
                    failure(error);
                    
                }
            }];
        }
            break;
            
        default:
            break;
    }
}
/**
 *  返回json格式     manager.requestSerializer 请求方式不一样    需要上传数组
 *
 *  @param methodType <#methodType description#>
 *  @param urlString  <#urlString description#>
 *  @param params     <#params description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+(void)anotherRequestWithMethodType:(RequestMethodType)methodType Url:(NSString *)urlString params:(id)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    [SVProgressHUD showWithStatus:@""];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",@"application/xhtml+xml",@"application/xml", nil];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    //id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    
                    [SVProgressHUD dismiss];
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    [SVProgressHUD dismiss];
                    failure(error);
                }
            }];
        }
            break;
        case RequestMethodTypePost:
        {
            [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    //id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    
                    [SVProgressHUD dismiss];
                    success(responseObject);
                    
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    [SVProgressHUD dismiss];
                    failure(error);
                    
                }
            }];
        }
            break;
            
        default:
            break;
    }
}
/**
 *  xml格式
 *
 *  @param methodType <#methodType description#>
 *  @param urlString  <#urlString description#>
 *  @param params     <#params description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+(void)requestXmlWithMethodType:(RequestMethodType)methodType Url:(NSString *)urlString params:(id)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    // 设置超时时间
    [manage.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manage.requestSerializer.timeoutInterval = 10.f;
    [manage.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manage.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            [manage GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case RequestMethodTypePost:
        {
            [manage POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
            
        default:
            break;
    }
}



+(void)loginWXWithText:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/user/loginW",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

//切换用户身份
+(void)exchangeUserIdentity:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/user/changeUserType",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
                [SVProgressHUD showInfoWithStatus:@"获取信息失败"];
                failure(nil);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
    
}

//获取零工用户信息
+(void)getCapsualUserInfo:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/user/userInfo",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
                [SVProgressHUD showInfoWithStatus:@"获取信息失败"];
                failure(nil);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
    
}


//工作职业列表
+(void)getJobList:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/basic/getProfessionList",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
    
}

//获取技能列表
+(void)getTechnologyList:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/basic/getTechnologyList",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
    
}
//接单大厅
+(void)getReceiveOrderList:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/order/publishOrderList",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
                [SVProgressHUD showInfoWithStatus:@"获取信息失败"];
                failure(nil);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
    
}




//零工接单详情
+(void)getCasualTakeOrderDetail:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/order/orderInfoWorker",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
                [SVProgressHUD showInfoWithStatus:@"获取信息失败"];
                failure(nil);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
    
}

//零工抢单
+(void)CasualScramebleTakeOrder:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/order/receiveOrder",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
                [SVProgressHUD showInfoWithStatus:dict[@"msg"]];
                failure(nil);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
}

//零工确认接单
+(void)CasualSureTakeOrder:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/order/acceptOrder",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
                [SVProgressHUD showInfoWithStatus:dict[@"msg"]];
                failure(nil);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
}

//
//零工取消接单
+(void)casualCancelTakeOrder:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/order/cancelHired",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
                [SVProgressHUD showInfoWithStatus:dict[@"msg"]];
                failure(nil);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
}
//零工修改个人信息
+(void)casualChangeOwnInfo:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/user/updateWorkerInfo",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
                [SVProgressHUD showInfoWithStatus:dict[@"msg"]];
                failure(nil);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
}






///////
//雇主接口


//雇佣
+(void)EmplyeerEmploy:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/order/hireOrder",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
                [SVProgressHUD showInfoWithStatus:@"获取信息失败"];
                failure(nil);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
}
//雇主评价
+(void)EmplyeerComment:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/order/comment",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
                [SVProgressHUD showInfoWithStatus:@"获取信息失败"];
                failure(nil);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
}

//派单大厅列表
+(void)getLauchOrderList:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/order/myPublishOrders",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
                [SVProgressHUD showInfoWithStatus:@"获取信息失败"];
                failure(nil);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
    
}

//雇主派单详情
+(void)getEmployerLauchPieDetail:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/order/orderInfoHirer",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
                [SVProgressHUD showInfoWithStatus:@"获取信息失败"];
                failure(nil);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
}
//派单
+(void)launchOder:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/order/publishOrder",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//我的
+(void)getEmployerMyPage:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/user/hireMy",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
                [SVProgressHUD showInfoWithStatus:@"获取信息失败"];
                failure(nil);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
            [SVProgressHUD showErrorWithStatus:errorCode];
        }
    }];
    
}


@end
