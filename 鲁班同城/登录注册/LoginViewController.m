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

@interface LoginViewController (){
    OwnTextField *mobileTextField;
    OwnTextField *codeTextField;
    UIButton *codeButt;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addViews];
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
    mobileTextField.myTextField.font = [UIFont systemFontOfSize:15];
    mobileTextField.myTextField.textColor = textColor;
    [mobileTextField.myTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:mobileTextField];
    //
    UIView *mobileLineView = [[UIView alloc] init];
    mobileLineView.backgroundColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [self.view addSubview:mobileLineView];
    //
    codeTextField = [[OwnTextField alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    codeTextField.backgroundColor = [UIColor whiteColor];
    codeTextField.myTextField.font = [UIFont systemFontOfSize:15];
    [codeTextField.myTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
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
    codeButt.layer.cornerRadius = 10;
    [codeButt setTitle:@"获取验证码" forState:UIControlStateNormal];
    codeButt.titleLabel.font = [UIFont systemFontOfSize:9];
    [codeButt addTarget:self action:@selector(codeButtHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeButt];
    //
    UIButton *loginButt = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButt.backgroundColor = [UIColor colorWithHexString:@"#78CAC5"];
    [loginButt addTarget:self action:@selector(loginHandler) forControlEvents:UIControlEventTouchUpInside];
    [loginButt setTitle:@"登录" forState:UIControlStateNormal];
    loginButt.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    UIColor *buttTitleColor = [UIColor colorWithHexString:@"#FFFEFE"];
    [loginButt setTitleColor:buttTitleColor forState:UIControlStateNormal];
    loginButt.layer.cornerRadius = 20;
    [self.view addSubview:loginButt];
    //
    UILabel *registerLabel = [[UILabel alloc] init];
    UIFont *registerLabelFont = [UIFont systemFontOfSize:11];
    registerLabel.font = registerLabelFont;
    registerLabel.text = @"没有账号？";
    CGFloat registerLabelHeight = 12;
    CGFloat registerLabelWidth = [LzhReturnLabelHeight getLabelWidth:registerLabel.text font:registerLabelFont targetHeight:registerLabelHeight];
    registerLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.view addSubview:registerLabel];
    //
     CGFloat registerTipViewWidth = [LzhReturnLabelHeight getLabelWidth:@"立刻注册" font:registerLabelFont targetHeight:registerLabelHeight];
    RegisterButtonStyleView *registerTipView = [[RegisterButtonStyleView alloc] initWithFrame:CGRectMake(0, 0, registerLabelWidth, 12)];
    [self.view addSubview:registerTipView];
    WS(weakSelf);
    registerTipView.clickButtBlock = ^{
        [weakSelf registerHandler];
    };
    //
    CGFloat tipViewWidth = [LzhReturnLabelHeight getLabelWidth:@"你还可以选择以下方式登录" font:[UIFont systemFontOfSize:10] targetHeight:10];
    LoginOtherTipView *tipView = [[LoginOtherTipView alloc] initWithFrame:CGRectMake(0, 0, tipViewWidth + 100, 10)];
    [self.view addSubview:tipView];
    //
    LoginThirdGroupView *otherLoginView = [[LoginThirdGroupView alloc] initWithFrame:CGRectMake(0, 0, 150, 35)];
    [self.view addSubview:otherLoginView];
    //constrain
    cancelButt.sd_layout
    .leftSpaceToView(self.view, 325)
    .topSpaceToView(self.view, 41)
    .widthIs(20)
    .heightEqualToWidth();
    
    topLogoImageView.sd_layout
    .topSpaceToView(cancelButt, 15)
    .widthIs(161)
    .heightEqualToWidth()
    .centerXEqualToView(self.view);
    
    mobileTextField.sd_layout
    .leftSpaceToView(self.view, 63)
    .topSpaceToView(topLogoImageView, 12)
    .widthIs(150)
    .heightIs(50);
    
    mobileLineView.sd_layout
    .leftEqualToView(mobileTextField)
    .topSpaceToView(mobileTextField, 1)
    .widthIs(256)
    .heightIs(1);
    
    codeTextField.sd_layout
    .leftSpaceToView(self.view, 63)
    .topSpaceToView(mobileTextField, 12)
    .widthIs(150)
    .heightIs(50);
    
    codeLineView.sd_layout
    .leftEqualToView(codeTextField)
    .topSpaceToView(codeTextField, 1)
    .widthIs(256)
    .heightIs(1);
    
    codeButt.sd_layout
    .leftSpaceToView(codeTextField, 26)
    .widthIs(80)
    .heightIs(20)
    .centerYEqualToView(codeTextField);
    
    loginButt.sd_layout
    .widthIs(270)
    .heightIs(40)
    .centerXEqualToView(self.view)
    .topSpaceToView(codeLineView, 75);
    
    registerLabel.sd_layout
    .leftSpaceToView(self.view, 140)
    .topSpaceToView(loginButt, 20)
    .widthIs(registerLabelWidth)
    .heightIs(registerLabelHeight);
    
    registerTipView.sd_layout
    .leftSpaceToView(registerLabel, 3)
    .widthIs(registerTipViewWidth)
    .topEqualToView(registerLabel)
    .heightIs(13);
    
    tipView.sd_layout
    .topSpaceToView(registerLabel, 60)
    .heightIs(10)
    .widthIs(tipViewWidth + 100)
    .centerXEqualToView(self.view);
    
    otherLoginView.sd_layout
    .topSpaceToView(tipView, 20)
    .heightIs(35)
    .widthIs(150)
    .centerXEqualToView(self.view);
    
}

- (void)cancelHandler{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate displayVC];
}

- (void)codeButtHandler{
    [MobileCode withButtonState:codeButt totalTime:30];
}

- (void)loginHandler{
    
}
- (void)registerHandler{
    NSLog(@"点击注册");
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
