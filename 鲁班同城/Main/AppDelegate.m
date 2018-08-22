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
#import "LoginViewController.h"
#import "RankViewController.h"
#import "VideoCenterViewController.h"
#import "ChooseIdentityViewController.h"

//category
#import "AppDelegate+tabbar.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //sharesdk
    [self registerShareSdk];
    //融云
    [self initRongYun];
    //高德
    [self initGaoDe];
    //导航栏样式设置
    [self customNaviBar];
    //保持登录
    [self JudgeKeepLogin];
    //
    NSLog(@"设备序列号%@",VENDER_IDENTIFIER);
    return YES;
}

//保持登录
- (void)JudgeKeepLogin{
    NSString *opratToken = [PDKeyChain keyChainLoad];
    NSLog(@"opratToken %@",opratToken);
    if ([opratToken isKindOfClass:[NSString class]]){
        NSLog(@"是字符串");
    }else{
         NSLog(@"不是字符串");
    }
    if ([opratToken isKindOfClass:[NSString class]]){//登录状态
        NSLog(@"登录状态");
        if ([lzhGetAccountInfo getAccount].identityFlag){
            [self setupViewControllersForEmployment];
        }else{
            [self setupViewControllersForCasualLabour];
        }
    }else{//非登录状态
        NSLog(@"非登录状态");
        [self displayLoginPageByIsInstalledWX];
    }
}

//显示登录页(微信授权隐藏处理)
- (void)displayLoginPageByIsInstalledWX{
    ChooseIdentityViewController *chooseIdentityVC = [[ChooseIdentityViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:chooseIdentityVC];
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];
    
    
//    if(NO == [ShareSDK isClientInstalled:SSDKPlatformTypeWechat]){
//        NSLog(@"你没有安装微信");
//        LoginViewController *loginVC = [[LoginViewController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
//    self.window.rootViewController=nav;
//        [self.window makeKeyAndVisible];
//    }else{
//        WxQQLoginViewController *loginVC = [[WxQQLoginViewController alloc]init];
//        loginVC.isWx = YES;
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
//        self.window.rootViewController=nav;
//        [self.window makeKeyAndVisible];
//    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
   
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}


- (void)applicationWillTerminate:(UIApplication *)application {
   
}

//融云
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

//融云end

//
- (void)displayVC{
     self.window.rootViewController=self.tabBarController;
    [self.window makeKeyAndVisible];
}

//零工状态
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
    self.navArr = @[firstNavi,orderNavi,videoCenterNavi,skillNavi,myInfoNavi];
    [self.tabBarController setViewControllers:self.navArr];//,guessHappyNavi
    [self.tabBarController tabBar].backgroundView.backgroundColor=[UIColor whiteColor];
    self.tabBarController.selectedIndex=0;
    [self customizeTabBarForCapsualLabourController:self.tabBarController];
    //点击中间大按钮的处理
    WS(weakSelf);
    self.tabBarController.clickBigButtBlock = ^{
        //显示拍摄视屏界面，若果没登录，则显示登录界面
        if([lzhGetAccountInfo getAccount].infoDict.allKeys.count == 0){
            [weakSelf displayLoginPageByIsInstalledWX];
        }else{
            UINavigationController *nav = [NavTools currentNavgation:weakSelf.tabBarController];
            if(nav){
                VideoCenterViewController *videoVC = [[VideoCenterViewController alloc]init];
                [nav pushViewController:videoVC animated:YES];
            }
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
            VideoCenterViewController *videoVC = [[VideoCenterViewController alloc]init];
            [nav pushViewController:videoVC animated:YES];
        }
    };
    [self displayVC];
}




@end
