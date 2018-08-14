//
//  LuZhiYuYinPop.h
//  鲁班同城
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LuZhiYuYinPopView.h"

@interface LuZhiYuYinPop : NSObject

+ (void)showPopView:(void (^)(void))canceledBlock completeBlock:(void (^)(void))completeBlock;


+ (void)dismissPopView;


@end
