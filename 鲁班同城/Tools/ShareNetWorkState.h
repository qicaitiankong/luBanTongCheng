//
//  ShareNetWorkState.h
//  Liankeji
//
//  Created by 李自豪 on 16/11/29.
//  Copyright © 2016年 haichuanhuiwulianxinxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>

typedef void(^Success)(id reponseObject);//成功回调
typedef void(^Failure)(NSError *err);//错误回调



@interface ShareNetWorkState : NSObject

+(ShareNetWorkState*)ShareNetState;
//网络监听
+(BOOL)getNetState;

-(NSInteger)AFNetWorkingGetNetState:(SEL)notReachableHandler unknownStateHandler:(SEL)unknownStateHandler WifeHandler:(SEL)wifeHandler wanHandler:(SEL)wwanHandler target:(id)target;

-(void)AfnetworkingStopNetWatch;


//get 请求
- (void)getDataWithUrl:(NSString*)url parameters:(NSDictionary*)parameterDict sucess:(Success)success failuer:(Failure)failure;
//post 请求
- (void)postDataWithUrl:(NSString*)url parameters:(NSDictionary*)parameterDict sucess:(Success)success failuer:(Failure)failure;
//针对多条URL且要求返回有序
//针对多条URL且要求返回有序
- (void)asynSerialDownload:(NSArray*)UrlArr downloadCompleteHandler:(SEL)downloadCompleteHandler target:(id)target modelIndex:(NSInteger)index;
//针对单个url
- (void)getPictureFromSession:(NSString *)urlStr success:(Success)successInfoamtion failure:(Failure)failureInfomation;

- (void)asynSerialDownloadMethd02:(NSString*)UrlStr downloadCompleteHandler:(SEL)downloadCompleteHandler target:(id)target modelIndex:(NSInteger)index;
//
- (void)NSOperationQueueDownload:(NSArray*)UrlArr downloadCompleteHandler:(SEL)downloadCompleteHandler target:(id)target modelIndex:(NSInteger)index;

- (void)sdwebImageDownload:(NSArray*)UrlArr downloadCompleteHandler:(SEL)downloadCompleteHandler target:(id)target modelIndex:(NSInteger)index;
//
- (void)sdwebImageSingleDownload:(NSString*)UrlStr downloadCompleteHandler:(SEL)downloadCompleteHandler target:(id)target modelIndex:(NSInteger)index;

////餐厅评价异步顺序下载(针对于多条请求，并要求数据有序返回)
//- (void)NewresturantCommentAsynDownload:(NSArray*)UrlArr downloadCompleteHandler:(SEL)downloadCompleteHandler target:(id)target model:(commentLzhModel*)model;
////我的评价下载图片
//- (void)NewMyCommentAsynDownload:(NSArray*)UrlArr downloadCompleteHandler:(SEL)downloadCompleteHandler target:(id)target model:(myLzhCommentModel*)model;
@end
