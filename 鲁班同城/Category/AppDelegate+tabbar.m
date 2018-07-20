//
//  AppDelegate+tabbar.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "AppDelegate+tabbar.h"
#import "RDVTabBarItem.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation AppDelegate (tabbar)

//tabbar零工状态
-(void)customizeTabBarForCapsualLabourController:(RDVTabBarController *)tabBarController{

    UITableView.appearance.estimatedRowHeight = 0;
    UITableView.appearance.estimatedSectionFooterHeight = 0;
    UITableView.appearance.estimatedSectionHeaderHeight = 0;
    if (FU_iPhoneX) {
        [tabBarController.tabBar setHeight:83];
    }else{
        [tabBarController.tabBar setHeight:49];
    }
    //UIImage *finishedImage = [UIImage imageWithData:nil];
    //UIImage *unfinishedImage = [UIImage imageWithData:nil];
    NSArray *tabBarItemImages = @[@"home", @"order",@"xiangji",@"play", @"user"];
    NSArray *tabBarItemTitles = @[@"首页", @"接单大厅",@"",@"技能秀",@"我的"];
    UIColor *themColor = K_THEM_COLOR;
    NSDictionary *unSelectedTitle=@{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                    NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#97a9b8"]};
    NSDictionary *selectedTitle=@{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                  NSForegroundColorAttributeName: themColor};
    
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        //[item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@Selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        item.unselectedTitleAttributes=unSelectedTitle;
        item.selectedTitleAttributes=selectedTitle;
        
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        
        
        index++;
    }
}

//tabbar雇主状态
- (void)changeToEmployerState:(RDVTabBarController*)tabbarController{
//
    UITableView.appearance.estimatedRowHeight = 0;
    UITableView.appearance.estimatedSectionFooterHeight = 0;
    UITableView.appearance.estimatedSectionHeaderHeight = 0;
    if (FU_iPhoneX) {
        [tabbarController.tabBar setHeight:83];
    }else{
        [tabbarController.tabBar setHeight:49];
    }
    
    NSLog(@"切换雇主身份");
    NSArray *tabBarItemImages = @[@"home", @"myOrder",@"xiangji",@"rank", @"user"];
    
    NSArray *tabBarItemSelectedImages = @[@"homeSelected", @"myOrderSelected",@"xiangjiSelected",@"rankSelected", @"userSelected"];
    
    NSArray *tabBarItemTitles = @[@"首页", @"我的派单",@"",@"排行榜",@"我的"];
    UIColor *themColor = K_THEM_COLOR;
    NSDictionary *unSelectedTitle=@{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                    NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#97a9b8"]};
    NSDictionary *selectedTitle=@{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                  NSForegroundColorAttributeName: themColor};
    
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[tabbarController tabBar] items]) {
        
        //[item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        
        UIImage *selectedimage = [UIImage imageNamed:tabBarItemSelectedImages[index]];
        UIImage *unselectedimage = [UIImage imageNamed:tabBarItemImages[index]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        item.unselectedTitleAttributes=unSelectedTitle;
        item.selectedTitleAttributes=selectedTitle;
        
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        
        index++;
    }
}
//
-(void)customNaviBar{
    
    NSDictionary *textAttributes = @{
                                     
                                     NSFontAttributeName : [UIFont getPingFangSCMedium:17],
                                     
                                     NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#666666"]
                                     
                                     };
    
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    
    //返回按钮的箭头颜色
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHexString:@"#666666"]];
    UIColor *themColor = [UIColor whiteColor];
    //导航栏的背景色
    [[UINavigationBar appearance] setBarTintColor:themColor];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    //调整返回按钮当中文字的位置.（我们只要返回按钮的那个图片，但是不要上面的文字，移走文字就好了）
    //UIBarButtonItem *item = [UIBarButtonItem appearance];
    //[item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -(kStatusBarHeight+44)) forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, 0) forBarMetrics:UIBarMetricsDefault];
    
    //去掉下边的线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //状态条白色字体
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
//
- (void)initGaoDe{
    [AMapServices sharedServices].apiKey = @"3b98623eb868072d0d1e4876e856dbf0";
}


//
- (void)initRongYun{
    //{"code":200,"userId":"LZH-6D74CBD6-1D81-45E0-B329-690CA31AF49C","token":"PJrRrTh7nJRacL4o7SQE/QM84eptEeqQzvusjPmPcfElJvmCHflfoWLZ1q3BgGC6ahrnZHonjVoP2hSgMq+NbYazBdx0YwsPAW7KWxohEwKiAvFCDkNRwn7rRy0aGC7aif7C2ig+f17XMeHQIddGPQ=="}
    //{"code":200,"userId":"TEST02-6D74CBD6-1D81-45E0-B329-690CA31AF49C","token":"JCqeQpylqZ47hXTWf8cC/Otu/eT0O8rTRLcmVsGdOnJ1lRZnIYipDWO7+ZUzBB6/ZHNqaqc9oltOwE1sJejcYpZq7SKhtI/YviUjSWld5f5N/cg+lbKuf0Sy202nnGQX4hT27O4K/vbFkfWZkKGV++n6XrSSgIDI"}
    //
    NSString *lzhDeviceStr = @"6D74CBD6-1D81-45E0-B329-690CA31AF49C";
    
    NSString *lzhToken01 = @"PJrRrTh7nJRacL4o7SQE/QM84eptEeqQzvusjPmPcfElJvmCHflfoWLZ1q3BgGC6ahrnZHonjVoP2hSgMq+NbYazBdx0YwsPAW7KWxohEwKiAvFCDkNRwn7rRy0aGC7aif7C2ig+f17XMeHQIddGPQ==";
    NSString *lzhToken02 = @"JCqeQpylqZ47hXTWf8cC/Otu/eT0O8rTRLcmVsGdOnJ1lRZnIYipDWO7+ZUzBB6/ZHNqaqc9oltOwE1sJejcYpZq7SKhtI/YviUjSWld5f5N/cg+lbKuf0Sy202nnGQX4hT27O4K/vbFkfWZkKGV++n6XrSSgIDI";
    NSString *deviceID = VENDER_IDENTIFIER;
    NSString *useToken = nil;
    if([deviceID isEqualToString:lzhDeviceStr]){
        useToken = lzhToken01;
        //TEST02-6D74CBD6-1D81-45E0-B329-690CA31AF49C
    }else{
        useToken = lzhToken02;
        //LZH-6D74CBD6-1D81-45E0-B329-690CA31AF49C
    }
    //此方法的回调并非为原调用线程，您如果需要进行UI操作，请注意切换到主线程。
    [[RCIM sharedRCIM]initWithAppKey:@"m7ua80gbmj2em"];
    //xiaminxiamin
    [[RCIM sharedRCIM] connectWithToken:useToken success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        dispatch_async(dispatch_get_main_queue(), ^{
           
        });
    } error:^(RCConnectErrorCode status) {
         NSLog(@"登陆的错误码为:%d", status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        //在tokenIncorrectBlock的情况下，您需要请求您的服务器重新获取token并建立连接，但是注意避免无限循环，以免影响App用户体验。
        NSLog(@"token错误");
    }];
}


@end
