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
#import "PersonalInfoNameViewController.h"

@interface WxQQLoginViewController ()

@end

@implementation WxQQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addViews];
}

- (void)cancelHandler{
    [self.rdv_tabBarController setTabBarHidden:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)firstLoginHandler{
    NSLog(@"firstLoginHandler");
    PersonalInfoNameViewController *nameInfoVC = [[PersonalInfoNameViewController alloc] init];
    [self.navigationController pushViewController:nameInfoVC animated:YES];
    
}

- (void)otherLoginHandler{
     NSLog(@"otherLoginHandler");
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
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
    [self.view addSubview:topLogoImageView];
    //
    UILabel *tipLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:1];
   
    [self.view addSubview:tipLabel];
    CGFloat topImageW = 0;
    CGFloat topimageH = 0;
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
    CustomeStyleCornerButt *firstLoginView = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.72, 40) backColor:[UIColor colorWithHexString:@"#EF8733"] cornerRadius:0 title:@"一键登录" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:16]];
    WS(weakSelf);
    firstLoginView.clickButtBlock = ^{
        [weakSelf firstLoginHandler];
    };
    [self.view addSubview:firstLoginView];
    //
    CustomeStyleCornerButt *otherLoginView = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.72, 40) backColor:[UIColor colorWithHexString:@"#74C7C2"] cornerRadius:0 title:@"其他方式登录" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:16]];
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
    
    topLogoImageView.sd_layout
    .topSpaceToView(cancelButt, 15)
    .widthIs(topImageW)
    .heightIs(topimageH)
    .centerXEqualToView(self.view);
    
    tipLabel.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(topLogoImageView, 15)
    .heightIs(16);
    //
    firstLoginView.sd_layout
    .topSpaceToView(tipLabel, SCREEN_HEIGHT * 0.3)
    .widthIs(SCREEN_WIDTH * 0.72)
    .heightIs(40)
    .centerXEqualToView(self.view);
    
    otherLoginView.sd_layout
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
