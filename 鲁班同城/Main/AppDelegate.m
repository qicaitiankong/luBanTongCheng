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
#import "RankViewController.h"

//category
#import "AppDelegate+tabbar.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initRongYun];
    [self initGaoDe];
    [self customNaviBar];
    if ([lzhGetAccountInfo getAccount].identityFlag == 0){
        [self setupViewControllersForCasualLabour];
    }else{
        [self setupViewControllersForEmployment];
    }
    NSLog(@"设备序列号%@",VENDER_IDENTIFIER);
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
/**
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    //此处为了演示写了一个用户信息
    if ([@"LZH-6D74CBD6-1D81-45E0-B329-690CA31AF49C" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"LZH-6D74CBD6-1D81-45E0-B329-690CA31AF49C";
        user.name = @"LZH";
        //user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";

        return completion(user);
    }else if([@"TEST02-6D74CBD6-1D81-45E0-B329-690CA31AF49C" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"TEST02-6D74CBD6-1D81-45E0-B329-690CA31AF49C";
        user.name = @"TEST02";
        //user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        return completion(user);
    }
}

//

//
- (void)displayVC{
     self.window.rootViewController=self.tabBarController;
    [self.window makeKeyAndVisible];
}

//默认零工状态
-(void)setupViewControllersForCasualLabour{
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
    [self customizeTabBarForCapsualLabourController:self.tabBarController];
    //点击中间大按钮的处理
    WS(weakSelf);
    self.tabBarController.clickBigButtBlock = ^{
        UINavigationController *nav = [NavTools currentNavgation:weakSelf.tabBarController];
        if(nav){
            WxQQLoginViewController *loginVC = [[WxQQLoginViewController alloc] init];
            loginVC.isWx = YES;
            [nav pushViewController:loginVC animated:YES];
        }
    };
    //
    [self displayVC];
}

//雇主状态
-(void)setupViewControllersForEmployment{
    [SVProgressHUD setMaximumDismissTimeInterval:3];
    FirstPageViewController *firstVC=[[FirstPageViewController alloc]init];
    UINavigationController *firstNavi=[[UINavigationController alloc]initWithRootViewController:firstVC];
    
    OrderTakingViewController *orderTakingVC = [[OrderTakingViewController alloc] init];
    UINavigationController *orderNavi=[[UINavigationController alloc]initWithRootViewController:orderTakingVC];
    
    VideoCenterViewController *videoCenterVC = [[VideoCenterViewController alloc] init];
    UINavigationController *videoCenterNavi=[[UINavigationController alloc]initWithRootViewController:videoCenterVC];
    
    RankViewController *skillVC = [[RankViewController alloc] init];
    UINavigationController *skillNavi=[[UINavigationController alloc]initWithRootViewController:skillVC];
    
    MyInfoViewController *myInfoVC = [[MyInfoViewController alloc] init];
    UINavigationController *myInfoNavi=[[UINavigationController alloc]initWithRootViewController:myInfoVC];
    self.tabBarController = [[RDVTabBarController alloc] init];
    self.navArr = @[firstNavi,orderNavi,videoCenterNavi,skillNavi,myInfoNavi];
    [self.tabBarController setViewControllers:self.navArr];//,guessHappyNavi
    [self.tabBarController tabBar].backgroundView.backgroundColor=[UIColor whiteColor];
    self.tabBarController.selectedIndex= 0;
    [self changeToEmployerState:self.tabBarController];
    
    //点击中间大按钮的处理
    WS(weakSelf);
    self.tabBarController.clickBigButtBlock = ^{
        UINavigationController *nav = [NavTools currentNavgation:weakSelf.tabBarController];
        if(nav){
            WxQQLoginViewController *loginVC = [[WxQQLoginViewController alloc] init];
            loginVC.isWx = YES;
            [nav pushViewController:loginVC animated:YES];
        }
    };
    [self displayVC];
}




@end
