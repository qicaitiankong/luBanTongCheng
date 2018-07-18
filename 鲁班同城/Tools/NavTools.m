//
//  NavTools.m
//  鲁班同城
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "NavTools.h"

@implementation NavTools
//
+ (CustomerImageButt *)getOwnNavStyleWhiteReturnButt{
    CustomerImageButt *navReturnButt = [[CustomerImageButt alloc]initWithFrameForNavReturnButt:CGRectMake(0, STATUSBAR_HEIGHT + 10, 30, 20)];
    [navReturnButt.imageView setImage:[UIImage imageNamed:@"whiteReturn"]];
    return navReturnButt;
}

+ (CustomerImageButt *)getOwnNavStyleGrayReturnButt{
    CustomerImageButt *navReturnButt = [[CustomerImageButt alloc]initWithFrameForNavReturnButt:CGRectMake(0, STATUSBAR_HEIGHT + 10, 30, 20)];
    [navReturnButt.imageView setImage:[UIImage imageNamed:@"grayNavReturn@2x.png"]];
    return navReturnButt;
}

+ (void)hiddenNav:(UINavigationController*)nav{
    if (nav.navigationBarHidden == NO){
        nav.navigationBarHidden = YES;
    }
}

+ (void)displayNav:(UINavigationController*)nav{
    if (nav.navigationBarHidden){
        nav.navigationBarHidden = NO;
    }
}

+ (void)hiddenTabbar:(RDVTabBarController*)tab{
    if (NO == tab.tabBarHidden){
        [tab setTabBarHidden:YES];
    }
}

+ (void)displayTabbar:(RDVTabBarController*)tab{
    if (tab.tabBarHidden){
        [tab setTabBarHidden:NO];
    }
}

+ (UINavigationController*)currentNavgation:(RDVTabBarController*)tabbarControler{
    UINavigationController *nav = nil;
    AppDelegate *appDele = (AppDelegate*)[UIApplication sharedApplication].delegate;
    nav = appDele.navArr[tabbarControler.selectedIndex];
    return nav;
}


@end
