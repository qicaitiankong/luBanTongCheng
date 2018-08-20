//
//  NavTools.h
//  鲁班同城
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerImageButt.h"

@interface NavTools : NSObject

+ (CustomerImageButt *)getOwnNavStyleWhiteReturnButt;

+ (CustomerImageButt *)getOwnNavStyleGrayReturnButt;

+ (void)hiddenNav:(UINavigationController*)nav;

+ (void)displayNav:(UINavigationController*)nav;

+ (void)hiddenTabbar:(RDVTabBarController*)tab;

+ (void)displayTabbar:(RDVTabBarController*)tab;

+ (UINavigationController*)currentNavgation:(RDVTabBarController*)tabbarControler;
//判断是否是登录状态
+ (BOOL)judgeIsLogin;


@end
