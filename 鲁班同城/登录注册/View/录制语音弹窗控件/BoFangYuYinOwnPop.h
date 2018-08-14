//
//  BoFangYuYinOwnPop.h
//  鲁班同城
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoFangYuYinOwnPop : NSObject

+ (void)showPopView:(NSInteger)yuYinTime deleteBlock:(void (^)(void))deleteBlock completeBlock:(void (^)(void))completeBlock;

+ (void)dismissPopView;


@end
