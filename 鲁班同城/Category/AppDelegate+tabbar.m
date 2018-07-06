//
//  AppDelegate+tabbar.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "AppDelegate+tabbar.h"
#import "RDVTabBarItem.h"

@implementation AppDelegate (tabbar)

-(void)customizeTabBarForController:(RDVTabBarController *)tabBarController{
   UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
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

@end
