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

@end
