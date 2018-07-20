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


//#define kSERVER_HTTP_DXE @"http://192.168.0.6:8511"
#define kSERVER_HTTP_DXE @"http://219.147.12.202:618"

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
/**
 *  融云账号获取测试token 正式需要通过服务器获取
 *
 *
 */




























@end
