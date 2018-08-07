//
//  NSArray+OwnArrCopy.h
//  鲁班同城
//
//  Created by apple on 2018/8/7.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (OwnArrCopy)
//数组拷贝
+ (NSMutableArray*)getOwnCopyArr:(NSArray*)tagetArr;

@end
