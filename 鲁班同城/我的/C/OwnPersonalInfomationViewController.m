//
//  OwnPersonalInfomationViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalInfomationViewController.h"
#import "OwnPersonalInfomationTopPictureGoupView.h"
#import "OwnPersonalInfomationPersonalIntroduceGoupView.h"
#import "OwnPersonalInfomationPersonalTechnologyGoupView.h"
#import "OwnPersonalInfomationPersonalServiceTypeGoupView.h"
#import "OwnPersonalInfomationPersonalVideoGoupView.h"

@interface OwnPersonalInfomationViewController (){
    UIScrollView *baseScrollView;
    OwnPersonalInfomationTopPictureGoupView *topPartView;
    OwnPersonalInfomationPersonalIntroduceGoupView *personalIntroduceView;
    OwnPersonalInfomationPersonalTechnologyGoupView *personalTechnologyView;
    OwnPersonalInfomationPersonalServiceTypeGoupView *serviceTypeView;
    OwnPersonalInfomationPersonalVideoGoupView *videoView;
    OwnPersonalInfomationPersonalVideoGoupView *pictureView;
}

@end

@implementation OwnPersonalInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addViews];
}

- (void)addViews{
    //
    baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    baseScrollView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
    [self.view addSubview:baseScrollView];
    //
    topPartView = [[OwnPersonalInfomationTopPictureGoupView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    [topPartView.userlogoImaView setImage:[UIImage imageNamed:@"test07.jpg"]];
    topPartView.fenSiLabel.text = @"888粉丝";
    topPartView.concernLabel.text = @"23333关注";
    topPartView.sexAndHomeLabel.text = @"男   山东 青岛市";
    [topPartView.starGroupView setYellowStar:5];
    WS(weakSelf);
    topPartView.navReturnButt.clickButtBlock = ^{
        [weakSelf.rdv_tabBarController setTabBarHidden:NO];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    };
    [baseScrollView addSubview:topPartView];
    //
    personalIntroduceView = [[OwnPersonalInfomationPersonalIntroduceGoupView alloc]initWithFrame:CGRectMake(0, topPartView.bottom + 15, baseScrollView.width, 20)];
    personalIntroduceView.topTipLabel.text = @"个人介绍";
    [baseScrollView addSubview:personalIntroduceView];
    //
    personalTechnologyView = [[OwnPersonalInfomationPersonalTechnologyGoupView alloc]initWithFrame:CGRectMake(0, personalIntroduceView.bottom + 15, baseScrollView.width, 20)];
    personalTechnologyView.topTipLabel.text = @"个人技能";
    [baseScrollView addSubview:personalTechnologyView];
    //
    serviceTypeView = [[OwnPersonalInfomationPersonalServiceTypeGoupView alloc]initWithFrame:CGRectMake(0, personalTechnologyView.bottom + 15, baseScrollView.width, 20)];
    serviceTypeView.topTipLabel.text = @"服务类型";
    [baseScrollView addSubview:serviceTypeView];
    //
    videoView = [[OwnPersonalInfomationPersonalVideoGoupView alloc]initWithFrame:CGRectMake(0, serviceTypeView.bottom + 15, baseScrollView.width, 20)];
    videoView.topTipLabel.text = @"技能-视频秀";
    [baseScrollView addSubview:videoView];
    //
    pictureView = [[OwnPersonalInfomationPersonalVideoGoupView alloc]initWithFrame:CGRectMake(0, videoView.bottom + 15, baseScrollView.width, 20)];
    pictureView.topTipLabel.text = @"技能-图片秀";
    [baseScrollView addSubview:pictureView];
    //
    [baseScrollView setContentSize:CGSizeMake(baseScrollView.width, pictureView.bottom + 20)];
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
