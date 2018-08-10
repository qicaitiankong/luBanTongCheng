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

+ (AFHTTPSessionManager*)getSessionManager{
    AFHTTPSessionManager *session= [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",@"application/xhtml+xml",@"application/xml", nil];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    return session;
}

//上传图片
+ (void)uploadFile:(NSDictionary*)paraDict traileUrlStr:(NSString*)traileUrlStr imageFlagName:(NSString*)imageName imageDataArr:(NSArray*)targetDataArr success:(void (^)(id response))uploadSuccess failure:(void (^)(NSError *error))upLoadfailure{
    AFHTTPSessionManager *session= [self getSessionManager];
     NSString *urlString=[NSString stringWithFormat:@"%@%@",kSERVER_HTTP_DXE,traileUrlStr];
    [session POST:urlString parameters:paraDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if(targetDataArr.count > 0){
            for (int m = 0; m < targetDataArr.count; m ++){
                NSData *imageData = targetDataArr[m];
                NSString *imageType = [UIImage contentTypeForImageData:imageData];
                NSString *imageAppendType = @"image/jpeg";
                if (imageType == nil){

                }else{
                    imageAppendType = [NSString stringWithFormat:@"image/%@",imageType];
                }
                if (imageData == nil){
                    NSLog(@"!!!!!!!!!图片为空");
                }
                //上传的参数(上传图片，以文件流的格式)
                
                [formData appendPartWithFileData:imageData
                 
                                            name:imageName
                 
                                        fileName:@"test1000.jpg"
                 
                                        mimeType:imageAppendType];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"%f",uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        uploadSuccess(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        upLoadfailure(error);
        NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
        [SVProgressHUD showErrorWithStatus:errorCode];
    }];

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
+ (void)capsualChangeOwnInfo:(NSDictionary*)paraDict traileUrlStr:(NSString*)traileUrlStr imageFlagNameArr:(NSArray*)imageNameArr picDataArr:(NSArray*)targetPictureDataArr
                     videoDataArr:(NSArray*)targetVideoDataArr success:(void (^)(id response))uploadSuccess failure:(void (^)(NSError *error))upLoadfailure{
    AFHTTPSessionManager *session= [self getSessionManager];
    NSString *urlString=[NSString stringWithFormat:@"%@%@",kSERVER_HTTP_DXE,traileUrlStr];
    [session POST:urlString parameters:paraDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if(targetPictureDataArr.count > 0){
            for (int m = 0; m < targetPictureDataArr.count; m ++){
                NSData *imageData = targetPictureDataArr[m];
                NSString *imageType = [UIImage contentTypeForImageData:imageData];
                NSString *imageAppendType = @"image/jpeg";
                if (imageType == nil){
                }else{
                    imageAppendType = [NSString stringWithFormat:@"image/%@",imageType];
                }
                if (imageData == nil){
                    NSLog(@"!!!!!!!!!图片为空");
                }
                //上传的参数(上传图片，以文件流的格式)
                [formData appendPartWithFileData:imageData
                 
                                            name:imageNameArr[0]
                 
                                        fileName:@"test1000.jpg"
                 
                                        mimeType:imageAppendType];
            }
        }
            //
//            if(targetVideoDataArr.count > 0){
//                for (int m = 0; m < targetVideoDataArr.count; m ++){
//                    NSData *imageData = targetVideoDataArr[m];
//                    NSString *imageType = [UIImage contentTypeForImageData:imageData];
//                    NSString *imageAppendType = @"image/jpeg";
//                    if (imageType == nil){
//                    }else{
//                        imageAppendType = [NSString stringWithFormat:@"image/%@",imageType];
//                    }
//                    if (imageData == nil){
//                        NSLog(@"!!!!!!!!!图片为空");
//                    }
//                    //上传的参数(上传图片，以文件流的格式)
//                    [formData appendPartWithFileData:imageData
//
//                                                name:imageNameArr[1]
//
//                                            fileName:@"test1001.jpg"
//
//                                            mimeType:imageType];
//                }
//
        //}
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"%f",uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        uploadSuccess(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        upLoadfailure(error);
        NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
        [SVProgressHUD showErrorWithStatus:errorCode];
    }];
    
}
//我抢过的派单
+(void)casualTookTicked:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/user/myReceiveOrder",kSERVER_HTTP_DXE];
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
//我被雇佣的派单
+(void)getmyHiredTicked:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/user/myHiredOrder",kSERVER_HTTP_DXE];
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
//排行榜
+(void)getRankList:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/user/ranking",kSERVER_HTTP_DXE];
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








///统一使用
//雇佣记录
+(void)getGuYongRecordList:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/user/hiredOrders",kSERVER_HTTP_DXE];
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

//我的关注
+(void)getMyConcernList:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/user/myFocus",kSERVER_HTTP_DXE];
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

//我的粉丝
+(void)getMyFans:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/user/myFanses",kSERVER_HTTP_DXE];
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


//添加关注
+(void)AddConcernAction:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/user/focus",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
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

//取消关注
+(void)CancelConcernAction:(NSDictionary*)paraDict success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = paraDict;
    NSString *urlString=[NSString stringWithFormat:@"%@/lubantc/api/user/cancelFocus",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            int status = [dict[@"status"] intValue];
            if (status == 0){
                success(dict);
            }else if (status == 1){
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
