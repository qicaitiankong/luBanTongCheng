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

+ (void)hiddenNav:(UINavigationController*)nav;

+ (void)displayNav:(UINavigationController*)nav;

+ (void)hiddenTabbar:(RDVTabBarController*)tab;

+ (void)displayTabbar:(RDVTabBarController*)tab;



@end
