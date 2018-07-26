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
    [self.rdv_tabBarController setTabBarHidden:NO];
}

- (void)firstLoginHandler{
    NSLog(@"firstLoginHandler");
    [TDHttpTools loginWXWithText:@{@"weixinCode":@"1234567"} success:^(id response) {
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
        int status = [dict[@"status"] intValue];
        NSLog(@" test dict:%@",dict);
        NSDictionary *dataDict = dict[@"data"];
        if (status == 0){
             NSLog(@"userType:%@",dataDict[@"userType"]);
            //在此保存用户信息
            [[lzhGetAccountInfo getAccount] writeToAccount:dataDict];
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_TYPE_UPDATE_NOTIFICATION_NAME object:nil userInfo:nil];
            //通知跟新界面
            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
            [self.navigationController popViewControllerAnimated:YES];
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
