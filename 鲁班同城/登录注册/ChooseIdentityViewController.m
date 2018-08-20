//
//  ChooseIdentityViewController.m
//  鲁班同城
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ChooseIdentityViewController.h"
#import "WxQQLoginViewController.h"
#import "LoginViewController.h"
#import "chooseIdentityGroupButtView.h"


@interface ChooseIdentityViewController ()

@property (strong,nonatomic) chooseIdentityGroupButtView *groupButtView;

@end

@implementation ChooseIdentityViewController

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
    //说明用户不想登录，开放进入app浏览
    //后期还需处理，用户非登录状态处理界面显示，此处一下只为了跳转通过随便写了一个userid
    NSDictionary *makeDict = @{@"id":[NSNumber numberWithInt:1],@"userType":[NSNumber numberWithInteger:2]};
    [[lzhGetAccountInfo getAccount] writeToAccount:makeDict];
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app setupViewControllersForEmployment];
}

- (void)nextHandler{
    if ([ShareSDK isClientInstalled:SSDKPlatformTypeWechat]){
        WxQQLoginViewController *weiXinVC = [[WxQQLoginViewController alloc]init];
        weiXinVC.isWx = YES;
        weiXinVC.selectedUserType = self.groupButtView.selectedUserType;
        weiXinVC.selectedUserType = self.groupButtView.selectedUserType;
        [self.navigationController pushViewController:weiXinVC animated:YES];
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
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
    //UIColor *textColor = [UIColor colorWithRed:153.003/255.0 green:153.003/255.0 blue:153.003/255.0 alpha:1];
    //
    self.groupButtView = [[chooseIdentityGroupButtView alloc]initWithFrame:CGRectMake(0, topLogoImageView.bottom + 30, SCREEN_WIDTH * 0.72, SCREEN_HEIGHT * 0.187)];
    
    [self.view addSubview:self.groupButtView];
    
    CustomeStyleCornerButt *loginButtView = [[CustomeStyleCornerButt alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.72, SCREEN_HEIGHT * 0.06) backColor:[UIColor colorWithHexString:@"#78CAC5"] cornerRadius:0 title:@"确定" titleColor:[UIColor colorWithHexString:@"#FFFEFE"] font: [UIFont getPingFangSCMedium:16]];
    WS(weakSelf);
    loginButtView.clickButtBlock = ^{
        [weakSelf nextHandler];
    };
    [self.view addSubview:loginButtView];
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
    //
    self.groupButtView.sd_layout
    .topSpaceToView(topLogoImageView, 30)
    .widthIs(SCREEN_WIDTH * 0.72)
    .heightIs(SCREEN_HEIGHT * 0.187)
    .centerXEqualToView(self.view);
    
    
    loginButtView.sd_layout
    .widthIs(self.view.width * 0.72)
    .heightIs(SCREEN_HEIGHT * 0.06)
    .centerXEqualToView(self.view)
    .topSpaceToView(self.groupButtView, 40);

    
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
