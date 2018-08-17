//
//  NSString+OwnDealNullStr.h
//  鲁班同城
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OwnDealNullStr)
//处理后台数据字符串可能为空
+ (NSString*)getResultStrBySeverStr:(NSString*)targetStr;
//一个字符串是否为整型
+(BOOL)isPureInt:(NSString*)string;
//根据状态获取派单状态描述
+(NSString*)getStateStrByStateID:(NSInteger)stateId;

//获取时间戳
+(NSString*)getCurrentTimes;
//获取时间戳毫秒
+(NSString *)getNowMMTimeTimes;
//
+ (NSString *) md5:(NSString *) input;
//
//获取图片和语音时后台需要上传的作用参数
+(NSString*)getPictureAndVideoInfoServiceNeedFunctionStr:(NSInteger)flagId;

//获取图片和语音时后台需要上传的区别类型参数
+(NSString*)getPictureAndVideoServiceNeedTypeFlagStr:(NSInteger)flagId;

@end
