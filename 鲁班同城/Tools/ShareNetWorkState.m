//
//  ShareNetWorkState.m
//  Liankeji
//
//  Created by 李自豪 on 16/11/29.
//  Copyright © 2016年 haichuanhuiwulianxinxi. All rights reserved.
//

#import "ShareNetWorkState.h"
#import "Reachability.h"
#import <UIImage+MultiFormat.h>

@interface ShareNetWorkState (){
}
@end

ShareNetWorkState *ShareGetNetState = nil;
AFHTTPSessionManager *manager = nil;
dispatch_queue_t serialQueue = nil;
// NSLock *myLock = nil;
//NSLock *mySecondLock = nil;


@implementation ShareNetWorkState
+(ShareNetWorkState*)ShareNetState{
    
    if(ShareGetNetState == nil){
        ShareGetNetState = [[ShareNetWorkState alloc]init];
        manager = [AFHTTPSessionManager manager];
        serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
        //[[SDImageCache sharedImageCache] setShouldDecompressImages:NO];[[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:NO];
        //[[SDWebImageManager sharedManager].imageCache setMaxCacheSize:1024 * 30];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",@"application/xhtml+xml",@"application/xml", nil];
    }
    return ShareGetNetState;
}
//
+(BOOL)getNetState{
    __block BOOL haveNet = NO;
    Reachability *retch = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    //short flag = 0;
    switch (retch.currentReachabilityStatus) {
        case 0:
            //flag = 0;
            haveNet = NO;
            NSLog(@"0");
            break;
        case 1:
            haveNet = YES;
            NSLog(@"1");
            
            break;
        case 2:
            haveNet = YES;
            NSLog(@"2");
            
            break;
        default:
            NSLog(@"网络监听出现其他错误");
            break;
    }
    return haveNet;
}
-(BOOL)getNetState{
    __block BOOL haveNet = NO;
    Reachability *retch = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    //short flag = 0;
    switch (retch.currentReachabilityStatus) {
        case 0:
            //flag = 0;
            haveNet = NO;
            NSLog(@"0");
            break;
        case 1:
            haveNet = YES;
            NSLog(@"1");
            
            break;
        case 2:
            haveNet = YES;
            NSLog(@"2");
            
            break;
        default:
            NSLog(@"网络监听出现其他错误");
            break;
    }
    return haveNet;
}

-( NSInteger)AFNetWorkingGetNetState:(SEL)notReachableHandler unknownStateHandler:(SEL)unknownStateHandler WifeHandler:(SEL)
wifeHandler wanHandler:(SEL)wwanHandler target:(id)target
{
    __block NSInteger num = 0;
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%@",[NSThread currentThread]);
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                num = 0;
                NSLog(@"没网");
                [target performSelectorOnMainThread:notReachableHandler withObject:nil waitUntilDone:NO];
                break;
            case AFNetworkReachabilityStatusUnknown:
                num = -1;
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                num = 1;
                NSLog(@"%li WIFE",num);
                // [target performSelector:wifeHandler withObject:nil];
                [target performSelectorOnMainThread:wifeHandler withObject:nil waitUntilDone:NO];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"宽带");
                num = 2;
                break;
            default:
                break;
        }
    }];
    NSLog(@"网络:%li",num);
    return num;
}
-(void)AfnetworkingStopNetWatch{
    [[AFNetworkReachabilityManager sharedManager]stopMonitoring];
    //停止监听网络
}
- (void)getDataWithUrl:(NSString*)url parameters:(NSDictionary*)parameterDict sucess:(Success)success failuer:(Failure)failure{
    [manager GET:url parameters:parameterDict progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // NSLog(@"2000当前线程%@",[NSThread currentThread]);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)postDataWithUrl:(NSString*)url parameters:(NSDictionary*)parameterDict sucess:(Success)success failuer:(Failure)failure{
    [manager POST:url parameters:parameterDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
//
- (void)getPictureFromSession:(NSString *)urlStr success:(Success)successInfoamtion failure:(Failure)failureInfomation{
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *quest = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:quest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      //  NSLog(@"session thread :%@",[NSThread currentThread].name);
        if(error == nil){
            if(data != nil){
                successInfoamtion(data);
            }
        }else{
            failureInfomation(error);
        }
    }];
    [task resume];
}

//异步顺序下载(针对于多条请求，并要求数据有序返回)
- (void)asynSerialDownload:(NSArray*)UrlArr downloadCompleteHandler:(SEL)downloadCompleteHandler target:(id)target modelIndex:(NSInteger)index{
    NSArray *urlsArr = UrlArr;
    if([self getNetState]){
        //
        for (int i = 0; i < urlsArr.count; i ++) {

                dispatch_async(serialQueue, ^{
                    // [NSThread currentThread].name = @"lili";
                    //NSLog(@"current thresd:%@",[NSThread currentThread]);
                        NSURL *url = [NSURL URLWithString:urlsArr[i]];
                        NSData *data = [NSData dataWithContentsOfURL:url];
                                                       if(target && data){
                                    [target performSelectorOnMainThread:downloadCompleteHandler withObject:@{@"modelIndex":[NSNumber numberWithInteger:index],@"imageData":data} waitUntilDone:YES];
                                }
                            });
        }
        //
    }else{
        [SVProgressHUD showErrorWithStatus:@"检查网络"];
    }
    
}



- (void)asynSerialDownloadMethd02:(NSString*)UrlStr downloadCompleteHandler:(SEL)downloadCompleteHandler target:(id)target modelIndex:(NSInteger)index{
    
    if([self getNetState]){
        dispatch_async(serialQueue, ^{
            // [NSThread currentThread].name = @"lili";
            //NSLog(@"current thresd:%@",[NSThread currentThread]);
            
            NSURL *url = [NSURL URLWithString:UrlStr];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                // NSLog(@"session thresd:%@",[NSThread currentThread]);
                if(error){
                    NSLog(@"错误提示err=%@",error);
                }else{
                    //NSLog(@"!!!!下载的语音为:%@",data);
                    if(target && data){
                        [target performSelectorOnMainThread:downloadCompleteHandler withObject:@{@"modelIndex":[NSNumber numberWithInteger:index],@"imageData":data} waitUntilDone:YES];
                    }
                }
            }];
            [task resume];
            
        });
    }else{
        [SVProgressHUD showErrorWithStatus:@"检查网络"];
    }
    
}


- (void)NSOperationQueueDownload:(NSArray*)UrlArr downloadCompleteHandler:(SEL)downloadCompleteHandler target:(id)target modelIndex:(NSInteger)index{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSOperation *lastOpration = nil;
    NSMutableArray *OperationArr = [NSMutableArray array];
    for(NSInteger i = 0; i <UrlArr.count; i ++){
        __block NSData *data = nil;
        NSOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
            NSURL *url=[NSURL URLWithString:UrlArr[i]];
            
            data = [NSData dataWithContentsOfURL:url];
            
//            if(target && data){
//                [target performSelectorOnMainThread:downloadCompleteHandler withObject:@{@"modelIndex":[NSNumber numberWithInteger:index],@"imageData":data} waitUntilDone:YES];
//            }
//            NSLog(@"---op1----%@",[NSThread currentThread]);
            
        }];
        [op1 setCompletionBlock:^{
            if(target && data){
                [target performSelectorOnMainThread:downloadCompleteHandler withObject:@{@"modelIndex":[NSNumber numberWithInteger:index],@"imageData":data} waitUntilDone:YES];
            }

        }];
        if(lastOpration && lastOpration != op1){
            [op1 addDependency:lastOpration];
        }
        [OperationArr addObject:op1];
        lastOpration = op1;
    }
    [queue addOperations:OperationArr waitUntilFinished:NO];

}
//sdweb下载图片
- (void)sdwebImageDownload:(NSArray*)UrlArr downloadCompleteHandler:(SEL)downloadCompleteHandler target:(id)target modelIndex:(NSInteger)index{
     NSArray *UrlArr2 = UrlArr;
    for(int k = 0; k < UrlArr2.count; k ++){
        
        dispatch_async(serialQueue, ^{
            
            NSString *imageUrl = UrlArr2[k];
//            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                if(finished && image){
//                    // NSLog(@">>>>>>>>>下载完成index：%d",k);
//
//                    NSDictionary *dict = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithInteger:index],[NSNumber numberWithInt:k],imageURL] forKeys:@[@"modelIndex",@"imageIndex",@"imageData"]];
//
//                    [target performSelectorOnMainThread:downloadCompleteHandler withObject:dict waitUntilDone:NO];
//
//                }else{
//
//                }
//            }];
        });
       
    }
   
    
}
- (void)sdwebImageSingleDownload:(NSString*)UrlStr downloadCompleteHandler:(SEL)downloadCompleteHandler target:(id)target modelIndex:(NSInteger)index{
   
    NSString *imageUrl = UrlStr;
//    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        if(finished && image){
//            // NSLog(@">>>>>>>>>下载完成index：%d",k);
//
//            NSDictionary *dict = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithInteger:index],[NSNumber numberWithInteger:index],image] forKeys:@[@"modelIndex",@"imageIndex",@"imageData"]];
//
//            [target performSelectorOnMainThread:downloadCompleteHandler withObject:dict waitUntilDone:NO];
//
//        }else{
//
//        }
//    }];
}

@end
