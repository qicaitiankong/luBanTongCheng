//
//  appCommonAttributes.h
//  Liankeji
//
//  Created by 李自豪 on 16/12/17.
//  Copyright © 2016年 haichuanhuiwulianxinxi. All rights reserved.
//

#ifndef appCommonAttributes_h
#define appCommonAttributes_h

#import "CustomeLzhLabel.h"
//tools class
#import "LzhReturnLabelHeight.h"
#import "UIColor+Hex.h"
#import "UIViewExt.h"
#import "RDVTabBarController.h"
#import "UIFont+CustomerFonts.h"
#import "ImageAndLabelView.h"
#import "OwnTextField.h"
#import "NavTools.h"
#import "UILabel+ChangeCustomeLineSpace.h"
#import "AppDelegate+tabbar.h"
#import "AppDelegate.h"
#import "lzhGetAccountInfo.h"
#import "CustomeStyleCornerButt.h"
#import "TDHttpTools.h"
#import "UIViewController+XuanFuButtDIsplayAndHidden.h"
#import "GetLocationICitynfo.h"
#import "ShareNetWorkState.h"
#import "TelephoneNumberTools.h"
#import "NSString+OwnDealNullStr.h"
#import "NSNumber+OwnDealServerNumber.h"
#import "NSArray+OwnArrCopy.h"
#import "UIImage+OwnCalculateImageSize.h"
#import "UIView+ShowNullTipImageView.h"
#import "LuZhiYuYinPop.h"
#import "BoFangYuYinOwnPop.h"
#import "ShareHomePath.h"
#import "RecordAndPlaySound.h"
#import "NSDictionary+DealNullServiceDict.h"

//third party class
#import <SVProgressHUD.h>
#import <SDWebImageDownloader.h>
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDAutoLayout.h>
#import <AFNetworking.h>
#import <MJRefresh.h>
#import "AudioConverter.h"
#import "PDKeyChain.h"


//sharesdk
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>


//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
//#import "WeiboSDK.h"
//解决xocde打印日志不全
#ifdef DEBUG

#define NSLog( s, ... ) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String] );

#else

#define NSLog( s, ... )

#endif
//
#define NSEaseLocalizedString(key, comment) [[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"EaseUIResource" withExtension:@"bundle"]] localizedStringForKey:(key) value:@"" table:nil]

//自定义颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
//导航栏标题颜色
//#define NAVIGATION_TITLE_COLOR RGBA(201,201,201,1);
//
#define K_THEM_COLOR RGBA(51, 170, 157, 1);

#define LIGHR_GRAY_COLOR_LZH RGBA(200,200,200,1);
//没有图片是的背景色
#define IMAGEVIEW_DEFAULT_COLOR RGBA(245,245,245,1);
//主题绿
#define SPECIAL_BLUE_COLOR     [UIColor colorWithHexString:@"#78CAC5"];
//弹窗背景透明度
#define POP_VIEW_ALPHA 0.65;

//
#define RED_COLOR RGBA(255,0,0,1);
#define ORANGE_COLOR RGBA(255,165,0,1);
#define YELLOW_COLOR RGBA(255,255,0,1);
#define GREEN_COLOR RGBA(0,255,0,1);
#define CYAN_COLOR RGBA(0,127,255,1);
#define BLUE_COLOR RGBA(0,0,255,1);
#define PURPER_COLOR RGBA(139,0,255,1);
#define BLACK_COLOR RGBA(76,76,76,1);


#define kAccountPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/AccountInfo.plist"]

#define kLocationAccountInfoPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LocationInfo.plist"]

//屏幕高度、宽度
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

//九宫格单个图片高度
#define IMAGE_VIEW_HEIGHT (SCREEN_WIDTH - 30 - 5 * 2) / 3
//下一步或完成按钮宽高度
#define NEXT_BUTT_WIDTH SCREEN_WIDTH * 0.874

#define NEXT_BUTT_HEIGHT SCREEN_WIDTH * 0.12

#define  FU_iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)

#define  StatusBarAndNavigationBarHeight  (FU_iPhoneX ? 88.f : 64.f)
//导航栏
#define NAVIGATION_HEIGHT 44
//电池栏高度
#define STATUSBAR_HEIGHT (FU_iPhoneX ? 44.f : 20.f)

#define TAB_BAR_HEIGHT (FU_iPhoneX ? 83.f : 49.f)

#define CENTER_VIEW_HEIGHT  SCREEN_HEIGHT - StatusBarAndNavigationBarHeight - TAB_BAR_HEIGHT
//接单大厅分组控件高度
#define TAKE_ORDER_SEGUMENT_HEIGHT 40
//接单大厅搜索view高度
#define TAKE_ORDER_SEARCH_VIEW_HEIGHT SCREEN_HEIGHT * 0.06
//搜索输入空字符串后台需要传的格式字符串
#define SEARCH_NULL_FLAG_STR @"!#$%&*123qwe"

//主窗口
#define APP_MAIN_WINDOW [UIApplication sharedApplication].windows[0]
//设备ID
#define  VENDER_IDENTIFIER [[UIDevice currentDevice].identifierForVendor UUIDString]
//身份切换存到本地的key值
#define  IDENTITY_KEY_STRING @"identityFlag"
//身份切换跟新界面通知
#define  USER_TYPE_UPDATE_NOTIFICATION_NAME @"updateUserTypeInfoNoti"
// 获取系统版本号
#define SysVer [[[UIDevice currentDevice] systemVersion] floatValue]
// 改写为弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//noti name

//我的资料页面刷新界面通知
#define PERSONAL_REFRESH_NOTI @"refreshPersonalInfoNoti"

//微信app id app screet

#define WX_APP_ID @"wx02306e615972be35"

#define WX_APP_SCRET @"3ddea37af9e6e25fca5a43c69198ce3d"



#endif /* appCommonAttributes_h */
