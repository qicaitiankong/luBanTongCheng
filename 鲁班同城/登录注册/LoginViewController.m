//
//  LoginViewController.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "LoginViewController.h"
#import "OwnTextField.h"
#import "AppDelegate.h"
#import "MobileCode.h"
#import "RegisterButtonStyleView.h"
#import "LoginOtherTipView.h"
#import "LoginThirdGroupView.h"
#import "CustomeStyleCornerButt.h"
//vc
#import "WxQQLoginViewController.h"
#import "PersonalInfoNameViewController.h"
//share sdk smsdk
#import <SMS_SDK/SMSSDK.h>


@interface LoginViewController (){
    OwnTextField *mobileTextField;
    OwnTextField *codeTextField;
    UIButton *codeButt;
    LoginThirdGroupView *otherLoginView;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addViews];
    //
    [self adjustInstallWx];
    //
    NSLog(@"SCREEN_HEIGHT%lf",SCREEN_HEIGHT);
}

- (void)adjustInstallWx{
     if(NO == [ShareSDK isClientInstalled:SSDKPlatformTypeWechat]){
         otherLoginView.wxButt.hidden = YES;
         [otherLoginView updateOwnContsaintsWhenNoWeXin];
     }else{
     }
}

- (void)addViews{
    UIButton *cancelButt = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButt.backgroundColor = [UIColor whiteColor];
    [cancelButt setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [cancelButt addTarget:self action:@selector(cancelHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButt];
    //
    UIImageView *topLogoImageView = [[UIImageView alloc] init];
    topLogoImageView.backgroundColor = [UIColor whiteColor];
    [topLogoImageView setImage:[UIImage imageNamed:@"loginLogo"]];
    [self.view addSubview:topLogoImageView];
    //
    UIColor *textColor = [UIColor colorWithRed:153.003/255.0 green:153.003/255.0 blue:153.003/255.0 alpha:1];
    mobileTextField = [[OwnTextField alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    mobileTextField.backgroundColor = [UIColor whiteColor];
    mobileTextField.myTextField.placeholder = @"请输入手机号";
    mobileTextField.myTextField.font = [UIFont getPingFangSCMedium:15];
    mobileTextField.myTextField.textColor = textColor;
    [mobileTextField.myTextField setValue:[UIFont getPingFangSCMedium:15] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:mobileTextField];
    //
    UIView *mobileLineView = [[UIView alloc] init];
    mobileLineView.backgroundColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [self.view addSubview:mobileLineView];
    //
    codeTextField = [[OwnTextField alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    codeTextField.backgroundColor = [UIColor whiteColor];
    codeTextField.myTextField.font = [UIFont getPingFangSCMedium:15];
    [codeTextField.myTextField setValue:[UIFont getPingFangSCMedium:15] forKeyPath:@"_placeholderLabel.font"];
    codeTextField.myTextField.textColor = textColor;
    codeTextField.myTextField.placeholder = @"请输入验证码";
    [self.view addSubview:codeTextField];
    //
    UIView *codeLineView = [[UIView alloc] init];
    codeLineView.backgroundColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [self.view addSubview:codeLineView];
    //
    codeButt = [UIButton buttonWithType:UIButtonTypeCustom];
    codeButt.backgroundColor = [UIColor colorWithHexString:@"#78CAC5"];
    codeButt.layer.cornerRadius = SCREEN_WIDTH * 0.213 / 4 / 2;
    [codeButt setTitle:@"获取验证码" forState:UIControlStateNormal];
    codeButt.titleLabel.font = [UIFont getPingFangSCMedium:9];
    [codeButt addTarget:self action:@selector(codeButtHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeButt];
    //
    CustomeStyleCornerButt *loginButtView = [[CustomeStyleCornerButt alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.72, SCREEN_HEIGHT * 0.06) backColor:[UIColor colorWithHexString:@"#78CAC5"] cornerRadius:0 title:@"登录" titleColor:[UIColor colorWithHexString:@"#FFFEFE"] font: [UIFont getPingFangSCMedium:16]];
    WS(weakSelf);
    loginButtView.clickButtBlock = ^{
        [weakSelf loginHandler];
    };
    [self.view addSubview:loginButtView];
    //
    UILabel *registerLabel = [[UILabel alloc] init];
    UIFont *registerLabelFont = [UIFont getPingFangSCMedium:11];
    registerLabel.font = registerLabelFont;
    registerLabel.text = @"没有账号？";
    CGFloat registerLabelHeight = 12;
    CGFloat registerLabelWidth = [LzhReturnLabelHeight getLabelWidth:registerLabel.text font:registerLabelFont targetHeight:registerLabelHeight];
    registerLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.view addSubview:registerLabel];
    //
     CGFloat registerTipViewWidth = [LzhReturnLabelHeight getLabelWidth:@"立刻注册" font:registerLabelFont targetHeight:registerLabelHeight];
    RegisterButtonStyleView *registerTipView = [[RegisterButtonStyleView alloc] initWithFrame:CGRectMake(0, 0, registerTipViewWidth, registerLabelHeight + 1)];
    [self.view addSubview:registerTipView];
    registerTipView.clickButtBlock = ^{
        [weakSelf registerHandler];
    };
    //
    CGFloat tipViewWidth = [LzhReturnLabelHeight getLabelWidth:@"你还可以选择以下方式登录" font:[UIFont getPingFangSCMedium:10] targetHeight:10];
    LoginOtherTipView *tipView = [[LoginOtherTipView alloc] initWithFrame:CGRectMake(0, 0, tipViewWidth + 100, 10)];
    [self.view addSubview:tipView];
    //
     otherLoginView = [[LoginThirdGroupView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.40, SCREEN_HEIGHT * 0.052)];
    [otherLoginView.wxButt addTarget:self action:@selector(wxHandler) forControlEvents:UIControlEventTouchUpInside];
    [otherLoginView.qqButt addTarget:self action:@selector(qqHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:otherLoginView];
    
    //
    //constrain
    cancelButt.sd_layout
    .leftSpaceToView(self.view, SCREEN_WIDTH * 0.866)
    .topSpaceToView(self.view, SCREEN_HEIGHT * 0.061)
    .widthIs(SCREEN_HEIGHT * 0.029)
    .heightEqualToWidth();
    
    topLogoImageView.sd_layout
    .topSpaceToView(cancelButt, SCREEN_HEIGHT * 0.022)
    .widthIs(SCREEN_HEIGHT * 0.241)
    .heightEqualToWidth()
    .centerXEqualToView(self.view);
    
    mobileTextField.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(topLogoImageView, 12)
    .widthIs(SCREEN_WIDTH * 0.682)
    .heightIs(SCREEN_HEIGHT * 0.074);
    
    mobileLineView.sd_layout
    .leftEqualToView(mobileTextField)
    .topSpaceToView(mobileTextField, 1)
    .widthIs(SCREEN_WIDTH * 0.682)
    .heightIs(1);
    
    codeTextField.sd_layout
    .leftEqualToView(mobileTextField)
    .topSpaceToView(mobileTextField, 12)
    .widthIs(SCREEN_WIDTH * 0.4)
    .heightIs(SCREEN_HEIGHT * 0.074);
    
    codeLineView.sd_layout
    .leftEqualToView(codeTextField)
    .topSpaceToView(codeTextField, 1)
    .widthIs(SCREEN_WIDTH * 0.682)
    .heightIs(1);
    
    codeButt.sd_layout
    .leftSpaceToView(codeTextField, SCREEN_WIDTH * 0.069)
    .widthIs(SCREEN_WIDTH * 0.213)
    .heightIs(SCREEN_WIDTH * 0.213 / 4)
    .centerYEqualToView(codeTextField);
    
    loginButtView.sd_layout
    .widthIs(self.view.width * 0.72)
    .heightIs(SCREEN_HEIGHT * 0.06)
    .centerXEqualToView(self.view)
    .topSpaceToView(codeLineView, SCREEN_HEIGHT * 0.112);
    
    registerLabel.sd_layout
    .leftSpaceToView(self.view, self.view.width * 0.373)
    .topSpaceToView(loginButtView, SCREEN_HEIGHT * 0.029)
    .widthIs(registerLabelWidth)
    .heightIs(registerLabelHeight);
    
    registerTipView.sd_layout
    .leftSpaceToView(registerLabel, 3)
    .widthIs(registerTipViewWidth)
    .topEqualToView(registerLabel)
    .heightIs(13);
    
    tipView.sd_layout
    .topSpaceToView(registerLabel, SCREEN_HEIGHT * 0.089)
    .heightIs(SCREEN_HEIGHT * 0.014)
    .widthIs(tipViewWidth + 100)
    .centerXEqualToView(self.view);
    
    otherLoginView.sd_layout
    .topSpaceToView(tipView, SCREEN_HEIGHT * 0.029)
    .heightIs(SCREEN_HEIGHT * 0.052)
    .widthIs(SCREEN_WIDTH * 0.533)
    .centerXEqualToView(self.view);
    [otherLoginView updateOwnContsaints];
    
}

- (void)cancelHandler{
    NSLog(@"cancel button");
    //没有安装微信本业就会作为登录首页
    if(NO == [ShareSDK isClientInstalled:SSDKPlatformTypeWechat]){
        NSDictionary *makeDict = @{@"id":[NSNumber numberWithInt:1],@"userType":[NSNumber numberWithInteger:2]};
        [[lzhGetAccountInfo getAccount] writeToAccount:makeDict];
        AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [app setupViewControllersForEmployment];
        
    }else{//安装了微信本页不是默认登录首页
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)codeButtHandler{
    if (NO == [TelephoneNumberTools isMobile:mobileTextField.myTextField.text]){
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号码"];
        return;
    }
    [MobileCode withButtonState:codeButt totalTime:60];
    //获取验证码
    //
    [SMSSDK getVerificationCodeByMethod:0 phoneNumber:mobileTextField.myTextField.text zone:@"+86" template:nil result:^(NSError *error) {
        if (error)
        {
            if(error.code == NSURLErrorNotConnectedToInternet)
            {
               
            }
            else if(error.code == 300255)
            {
                
            }
            else if(error.code == 300462)
            {
                
            }
            else
            {
                
            }
             [SVProgressHUD showErrorWithStatus:@"短信获取失败，请重新获取"];
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:@"短信获取成功"];
        }
    }];
    
}

//
- (void)judgeYanZhengMa{
    if(codeTextField.myTextField.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    //判断是否验证成功
    
    [SMSSDK  commitVerificationCode:codeTextField.myTextField.text
     
     //传获取到的区号
     
                        phoneNumber:mobileTextField.myTextField.text
     
                               zone:@"86"
     
                             result:^(NSError *error)
     
     {
         
         
         
         if (!error)
             
         {
             
             NSLog(@"验证成功");
             
             
             
             
         }
         
         else
             
         {
             
             
             NSLog(@"验证失败");
             
         }
         
     }];

}






//

- (void)loginHandler{
    [self judgeYanZhengMa];
}

- (void)registerHandler{
    NSLog(@"点击注册");
    PersonalInfoNameViewController *inputInfoVC = [[PersonalInfoNameViewController alloc] init];
    [self.navigationController pushViewController:inputInfoVC animated:YES];
    
}

- (void)wxHandler{
    if (self.wxOrQQBackBlock){
        self.wxOrQQBackBlock(YES);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)qqHandler{
    NSLog(@"点击qq登录");
    if (self.wxOrQQBackBlock){
        self.wxOrQQBackBlock(NO);
    }
     [self.navigationController popViewControllerAnimated:YES];
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
