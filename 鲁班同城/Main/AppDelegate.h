//
//  AppDelegate.h
//  鲁班同城
//
//  Created by Mac on 2018/6/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDVTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) RDVTabBarController *tabBarController;

- (void)displayVC;

@end

