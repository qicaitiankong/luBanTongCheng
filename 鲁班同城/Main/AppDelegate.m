//
//  AppDelegate.m
//  鲁班同城
//
//  Created by Mac on 2018/6/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "AppDelegate.h"
//vc
#import "FirstPageViewController.h"
#import "OrderTakingViewController.h"
#import "VideoCenterViewController.h"
#import "SkillShowViewController.h"
#import "MyInfoViewController.h"
#import "WxQQLoginViewController.h"

//category
#import "AppDelegate+tabbar.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    self.window.rootViewController = loginVC;
//    [self.window makeKeyAndVisible];
    
    [self customNaviBar];
    [self setupViewControllers];
    [self displayVC];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//
- (void)displayVC{
     self.window.rootViewController=self.tabBarController;
}

//set vc
-(void)setupViewControllers{
    [SVProgressHUD setMaximumDismissTimeInterval:3];
    FirstPageViewController *firstVC=[[FirstPageViewController alloc]init];
    UINavigationController *firstNavi=[[UINavigationController alloc]initWithRootViewController:firstVC];
    
    OrderTakingViewController *orderTakingVC = [[OrderTakingViewController alloc] init];
    UINavigationController *orderNavi=[[UINavigationController alloc]initWithRootViewController:orderTakingVC];
    
    VideoCenterViewController *videoCenterVC = [[VideoCenterViewController alloc] init];
    UINavigationController *videoCenterNavi=[[UINavigationController alloc]initWithRootViewController:videoCenterVC];
    
    SkillShowViewController *skillVC = [[SkillShowViewController alloc] init];
    UINavigationController *skillNavi=[[UINavigationController alloc]initWithRootViewController:skillVC];
    
    MyInfoViewController *myInfoVC = [[MyInfoViewController alloc] init];
    UINavigationController *myInfoNavi=[[UINavigationController alloc]initWithRootViewController:myInfoVC];
    self.tabBarController = [[RDVTabBarController alloc] init];
    NSArray *navArr = @[firstNavi,orderNavi,videoCenterNavi,skillNavi,myInfoNavi];
    [self.tabBarController setViewControllers:navArr];//,guessHappyNavi
    [self.tabBarController tabBar].backgroundView.backgroundColor=[UIColor whiteColor];
    self.tabBarController.selectedIndex=0;
    [self customizeTabBarForController:self.tabBarController];
    
    //点击中间大按钮的处理
    WS(weakSelf);
    self.tabBarController.clickBigButtBlock = ^{
        UINavigationController *nav = navArr[weakSelf.tabBarController.selectedIndex];
        weakSelf.currentSelectedNav = nav;
        WxQQLoginViewController *loginVC = [[WxQQLoginViewController alloc] init];
        loginVC.isWx = YES;
        [weakSelf.currentSelectedNav pushViewController:loginVC animated:YES];
    };
   
}




@end
