//
//  WxQQLoginViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WxQQLoginViewController.h"
#import "CustomeStyleCornerButt.h"
#import "LoginViewController.h"
@interface WxQQLoginViewController (){
    UIImageView *topLogoImageView;
    UILabel *tipLabel;
    CustomeStyleCornerButt *firstLoginView;
    CustomeStyleCornerButt *otherLoginView;
    UIButton *cancelButt;
    //
    CGFloat topImageW;
    CGFloat topimageH;
}

@end

@implementation WxQQLoginViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addViews];
}

- (void)cancelHandler{
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.rdv_tabBarController setTabBarHidden:NO];
    //说明用户不想登录，开放进入app浏览
    //后期还需处理，用户非登录状态处理界面显示，此处一下只为了跳转通过随便写了一个userid
    NSDictionary *makeDict = @{@"id":[NSNumber numberWithInt:1],@"userType":[NSNumber numberWithInteger:2]};
    [[lzhGetAccountInfo getAccount] writeToAccount:makeDict];
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app setupViewControllersForEmployment];
}

- (void)firstLoginHandler{
    NSLog(@"firstLoginHandler");
    if(self.isWx){
        [ShareSDK getUserInfo:SSDKPlatformTypeWechat
               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
         {
             if (state == SSDKResponseStateSuccess)
             {
                 
                 NSLog(@"uid=%@",user.uid);
                 NSLog(@"%@",user.credential);
                 NSLog(@"token=%@",user.credential.token);
                 NSLog(@"nickname=%@",user.nickname);
                 [self wxLoginRequest:user.credential.token];
                 //要根据后台接口判断该qq号是否已与手机号关联，没关联才会显示qq昵称名字，否则应显示手机账号信息
                 //
                 //             NSString *CName=[user.nickname copy];
                 //             NSString *icon = [user.icon copy];
                 //
             }
             else
             {
                 NSLog(@"%@",error);
                 [SVProgressHUD showErrorWithStatus:@"微信登录失败，请重试"];
             }
             
         }];
        
    }
}

- (void)wxLoginRequest:(NSString*)wexinCode{
    [TDHttpTools loginWXWithText:@{@"weixinCode":wexinCode} success:^(id response) {
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
        int status = [dict[@"status"] intValue];
        NSLog(@" test dict:%@",dict);
        NSDictionary *dataDict = dict[@"data"];
        if (status == 0){
            NSLog(@"userType:%@",dataDict[@"userType"]);
            // age = "<null>";
            //            fansNum = 0;
            //            focusNum = 0;
            //            gender = "\U7537";
            //            headImg = "<null>";
            //            id = 8;
            //            mobile = "<null>";
            //            realName = "<null>";
            //            realNamePath = "<null>";
            //            state = 0;
            //            userType = "\U96c7\U4e3b";
            //            username = "<null>";
            //在此保存用户信息
            [[lzhGetAccountInfo getAccount] writeToAccount:dataDict];
            
            
            //[[NSNotificationCenter defaultCenter] postNotificationName:USER_TYPE_UPDATE_NOTIFICATION_NAME object:nil userInfo:nil];
            //通知跟新界面
            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
            AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
            if ([lzhGetAccountInfo getAccount].identityFlag == 1){
                [app setupViewControllersForEmployment];
            }else{
                [app setupViewControllersForCasualLabour];
            }
            
        }else if (status == 1){
            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        NSString *errorCode = [NSString stringWithFormat:@"error code: %ld",error.code];
        [SVProgressHUD showErrorWithStatus:errorCode];
    }];
}





- (void)otherLoginHandler{
     NSLog(@"otherLoginHandler");
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    WS(weakSelf);
    loginVC.wxOrQQBackBlock = ^(BOOL isWx) {
        weakSelf.isWx = isWx;
        [weakSelf refreshViewDisplayByWxOrQQ];
    };
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)addViews{
    cancelButt = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButt.backgroundColor = [UIColor whiteColor];
    [cancelButt setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [cancelButt addTarget:self action:@selector(cancelHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButt];
    //
    topLogoImageView = [[UIImageView alloc] init];
    topLogoImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topLogoImageView];
    //
    tipLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:1];
   
    [self.view addSubview:tipLabel];
    
    if(self.isWx){
        [topLogoImageView setImage:[UIImage imageNamed:@"weixinLogin"]];
         tipLabel.text = @"微信授权登录";
        topImageW = SCREEN_WIDTH * 0.285;
        topimageH = topImageW / 1.4;
    }else{
        [topLogoImageView setImage:[UIImage imageNamed:@"QQ@3x.png"]];
        tipLabel.text = @"qq授权登录";
        topImageW = SCREEN_WIDTH * 0.229;
        topimageH = topImageW / 0.826;
    }
    //
     firstLoginView = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.72, 40) backColor:[UIColor colorWithHexString:@"#EF8733"] cornerRadius:0 title:@"一键登录" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:16]];
    WS(weakSelf);
    firstLoginView.clickButtBlock = ^{
        [weakSelf firstLoginHandler];
    };
    [self.view addSubview:firstLoginView];
    //
     otherLoginView = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.72, 40) backColor:[UIColor colorWithHexString:@"#74C7C2"] cornerRadius:0 title:@"其他方式登录" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:16]];
    otherLoginView.clickButtBlock = ^{
        [weakSelf otherLoginHandler];
    };
    [self.view addSubview:otherLoginView];
    
    //
    cancelButt.sd_layout
    .rightSpaceToView(self.view, 30)
    .topSpaceToView(self.view, 41)
    .widthIs(20)
    .heightEqualToWidth();
    
    topLogoImageView.sd_resetLayout
    .topSpaceToView(cancelButt, 15)
    .widthIs(topImageW)
    .heightIs(topimageH)
    .centerXEqualToView(self.view);
    
    tipLabel.sd_resetLayout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(topLogoImageView, 15)
    .heightIs(16);
    //
    firstLoginView.sd_resetLayout
    .topSpaceToView(tipLabel, SCREEN_HEIGHT * 0.3)
    .widthIs(SCREEN_WIDTH * 0.72)
    .heightIs(40)
    .centerXEqualToView(self.view);
    
    otherLoginView.sd_resetLayout
    .topSpaceToView(firstLoginView, 20)
    .widthIs(SCREEN_WIDTH * 0.72)
    .heightIs(40)
    .centerXEqualToView(self.view);
}

- (void)refreshViewDisplayByWxOrQQ{
    
    if(self.isWx){
        [topLogoImageView setImage:[UIImage imageNamed:@"weixinLogin"]];
        tipLabel.text = @"微信授权登录";
        topImageW = SCREEN_WIDTH * 0.285;
        topimageH = topImageW / 1.4;
    }else{
        [topLogoImageView setImage:[UIImage imageNamed:@"QQ@3x.png"]];
        tipLabel.text = @"qq授权登录";
        topImageW = SCREEN_WIDTH * 0.229;
        topimageH = topImageW / 0.826;
    }
    topLogoImageView.sd_resetLayout
    .topSpaceToView(cancelButt, 15)
    .widthIs(topImageW)
    .heightIs(topimageH)
    .centerXEqualToView(self.view);
    
    tipLabel.sd_resetLayout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(topLogoImageView, 15)
    .heightIs(16);
    //
    firstLoginView.sd_resetLayout
    .topSpaceToView(tipLabel, SCREEN_HEIGHT * 0.3)
    .widthIs(SCREEN_WIDTH * 0.72)
    .heightIs(40)
    .centerXEqualToView(self.view);
    
    otherLoginView.sd_resetLayout
    .topSpaceToView(firstLoginView, 20)
    .widthIs(SCREEN_WIDTH * 0.72)
    .heightIs(40)
    .centerXEqualToView(self.view);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
