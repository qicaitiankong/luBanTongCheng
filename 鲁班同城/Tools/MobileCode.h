//
//  MobileCode.h
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobileCode : NSObject
/** 显示倒计时 */
+ (void)withButtonState:(UIButton*)l_timeButton totalTime:(int)times;

@end
