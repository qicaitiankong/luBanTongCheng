//
//  NSNumber+OwnDealServerNumber.h
//  鲁班同城
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (OwnDealServerNumber)
//处理后台int数据可能为空的情况
+ (NSNumber*)getResultNumberBySeverStr:(NSNumber*)targetNumber;

//处理后台bool数据可能为空的情况
+ (NSNumber*)getResultBoolNumberBySeverStr:(NSNumber*)targetNumber;

@end
