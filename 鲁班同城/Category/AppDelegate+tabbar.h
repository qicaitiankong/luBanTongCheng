//
//  AppDelegate+tabbar.h
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMLib/RongIMLib.h>
#import <RongIMKit/RongIMKit.h>

@interface AppDelegate (tabbar)

-(void)customNaviBar;

- (void)changeToEmployerState:(RDVTabBarController*)tabbarController;

//tabbar零工状态
-(void)customizeTabBarForCapsualLabourController:(RDVTabBarController *)tabBarController;

//
- (void)initRongYun;

@end
