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


//将一个字典数组，重新拿出其中某个键的值组成一个新数组
+ (NSMutableArray*)getTargetArr:(NSArray*)orinalArr keyStr:(NSString*)key;



@end
