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
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)firstLoginHandler{
    NSLog(@"firstLoginHandler");
    [SVProgressHUD show];
    
    
    if(self.isWx){
        [ShareSDK getUserInfo:SSDKPlatformTypeWechat
               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
         {
             if (state == SSDKResponseStateSuccess)
             {
                 
                 NSLog(@"uid=%@",user.uid);
                 NSLog(@"user.credential..rawData=%@",user.credential.rawData);
                 NSLog(@"token=%@",user.credential.token);
                 NSLog(@"nickname=%@",user.nickname);
                 [SVProgressHUD dismiss];
                 if (user.credential == nil){
                     NSLog(@"\n\n！！！！！！！！微信登录尚未授权\n\n");
                     [SVProgressHUD showErrorWithStatus:@"微信登录失败，请重试"];
                 }else{
                     NSLog(@"\n\n！！！！！！微信登录已经授权\n\n");
                      [self wxLoginRequest:user];
                 }
                 
                
             }
             else
             {
                 [SVProgressHUD dismiss];
                 NSLog(@"%@",error);
                 [SVProgressHUD showErrorWithStatus:@"微信登录失败，请重试"];
             }
             
         }];
        
    }
}

- (void)wxLoginRequest:(SSDKUser *)weixinInfo{
    NSString *sexStr = @"";
    if (weixinInfo.gender == 0){
        sexStr = @"男";
    }else if (weixinInfo.gender == 1){
        sexStr = @"女";
    }

   
    //
    NSString *openIDStr = [weixinInfo.credential.rawData[@"openid"] copy];
    if ([openIDStr isKindOfClass:[NSNumber class]]){
        NSLog(@"openid是数字");
    }else{
         NSLog(@"openid不是数字");
    }
    
    
    
    NSString *unionIDStr = [weixinInfo.credential.rawData[@"unionid"] copy];
    
     NSLog(@"!!!!!! openID:%@ unionID:%@ selected tyoe %ld",openIDStr,unionIDStr,self.selectedUserType);
    
    NSDictionary *paraDict = @{@"openId":openIDStr,@"unionID":unionIDStr,@"username":weixinInfo.nickname,@"gender":sexStr,@"headImg":weixinInfo.icon,@"province":@"",@"city":@"",@"area":@"",@"userType":[NSNumber numberWithInteger:self.selectedUserType]};
    //NSDictionary *paraDict = @{@"openId":openIDStr,@"unionID":@"4346789",@"username":weixinInfo.nickname,@"headImg":weixinInfo.icon,@"userType":[NSNumber numberWithInteger:self.selectedUserType]};
    NSLog(@"!!!!!!!!!!! paradict:%@",paraDict);
    
    [TDHttpTools loginWXWithText:paraDict success:^(id response) {
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
        int status = [dict[@"status"] intValue];
        NSLog(@" 微信登录后台返回 dict:%@",dict);
        NSDictionary *dataDict = dict[@"data"];
        if (status == 0){
            NSLog(@"userType:%@",dataDict[@"userType"]);
//            -"data": {              //返回结果。若status为1，则为null
//                "id": 2,                //用户id
//                "username": null,       //用户名（昵称）
//                "realName": null,       //真实姓名，文字
//                "realNamePath": null,   //真实姓名语音路径
//                "gender": "男",         //性别
//                "age": null,            //年龄
//                "headImg": null,        //头像路径
//                "mobile": null,         //电话
//                "userType": 1,          //身份。1：零工。2：雇主
//                "focusNum": null,       //关注人数
//                "fansNum": null,        //粉丝人数
//                "state": 0              //状态。0：正常。
//                "isFirst": true         //是不是第一次登录（即注册），false：不是。true：是
//                "token": "N3ii1IpaUMqsdpV2",        //用户的token
//                "userCode": "FKfaKd"                //用户编码
//            },
            //在此保存用户信息
            [[lzhGetAccountInfo getAccount] writeToAccount:dataDict];
            //
            NSString *operatorToken = [dataDict[@"token"] copy];
            [PDKeyChain keyChainSave:operatorToken];
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
        [SVProgressHUD dismiss];
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
