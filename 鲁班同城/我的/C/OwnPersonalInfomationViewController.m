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
//
@property (strong,nonatomic) NSMutableArray *personalTechnologyArr;
//
@property (strong,nonatomic) NSMutableArray *personalJobArr;
//
@property (strong,nonatomic) NSMutableArray *personalVideoArr;
//
@property (strong,nonatomic) NSMutableArray *personalPictureArr;

@property (assign,nonatomic) NSInteger starCount;

@end

@implementation OwnPersonalInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initOwnObjects];
    [self addViews];
    //
    [self getUserInfo];
}

- (void)initOwnObjects{
    self.personalTechnologyArr = [[NSMutableArray alloc]init];
    self.personalJobArr = [[NSMutableArray alloc]init];
    self.personalVideoArr = [[NSMutableArray alloc]init];
    self.personalPictureArr = [[NSMutableArray alloc]init];
}

- (void)addViews{
    //
    baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    baseScrollView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
    baseScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:baseScrollView];
    //
    topPartView = [[OwnPersonalInfomationTopPictureGoupView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20) vcKind:self.vcKind];
    
    topPartView.fenSiLabel.text = @"粉丝";
    topPartView.concernLabel.text = @"关注";
    topPartView.sexAndHomeLabel.text = @"";
    [topPartView.starGroupView setYellowStar:0];
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
//
- (void)getUserInfo{
    NSDictionary *praDict = @{@"userId":[lzhGetAccountInfo getAccount].userID};
    WS(weakSelf);
    [TDHttpTools getUserInfo:praDict success:^(id response) {
        NSDictionary *dataDict = response[@"data"];
        if ([dataDict allKeys].count){
            //写入plist
            [weakSelf makeDictToWritePlist:dataDict];
            NSNumber *starNumber = [NSNumber getResultNumberBySeverStr:dataDict[@"score"]];
            weakSelf.starCount = [starNumber integerValue];
            

            //
//            NSArray *techArr = dataDict[@"technologys"];
//            NSArray *jobArr = dataDict[@"professions"];
//            NSArray *videoArr = dataDict[@"technologysVideo"];
//            NSArray *picArr = dataDict[@"technologysPic"];
//            if (techArr.count){
//                [weakSelf.personalTechnologyArr addObjectsFromArray:techArr];
//            }
//            if (jobArr.count){
//                [weakSelf.personalJobArr addObjectsFromArray:jobArr];
//            }
//            if (videoArr.count){
//                [weakSelf.personalVideoArr addObjectsFromArray:videoArr];
//            }
//            if (picArr.count){
//                [weakSelf.personalPictureArr addObjectsFromArray:picArr];
//            }
            //界面赋值
             [weakSelf giveValueToView];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)giveValueToView{
    NSURL *imageUrl = [NSURL URLWithString:[lzhGetAccountInfo getAccount].PhotoUrl];
    [topPartView.userlogoImaView sd_setImageWithURL:imageUrl];
    topPartView.fenSiLabel.text =[NSString stringWithFormat:@"%ld粉丝",[lzhGetAccountInfo getAccount].fansCount];
    topPartView.concernLabel.text = [NSString stringWithFormat:@"%ld关注",[lzhGetAccountInfo getAccount].fousCount];
    topPartView.sexAndHomeLabel.text = [NSString stringWithFormat:@"%@ %@ %@",[lzhGetAccountInfo getAccount].sexStr,[GetLocationICitynfo getLocationInfo].provinceStr,[GetLocationICitynfo getLocationInfo].cityStr];
    [topPartView.starGroupView setYellowStar:self.starCount];
}


- (void)makeDictToWritePlist:(NSDictionary*)dict{
    //
    NSString *userName = [dict[@"username"] copy];
    NSString *realName = [dict[@"realName"] copy];
    NSString *gender = [dict[@"gender"] copy];
    NSString *headImg = [dict[@"headImg"] copy];
    NSString *mobile = [dict[@"mobile"] copy];
    NSString *userType = [dict[@"userType"] copy];
    NSNumber *age = dict[@"age"];
    NSNumber *focusNum = dict[@"focusNum"];
    NSNumber *fansNum = dict[@"fansNum"];
    NSNumber *userID = dict[@"id"];
    //
    NSDictionary *makeDict = @{@"userName":userName,@"realName":realName,@"gender":gender,@"age":age,@"headImg":headImg,@"mobile":mobile,@"userType":userType,@"userId":userID,@"focusNum":focusNum,@"fansNum":fansNum};
    [[lzhGetAccountInfo getAccount] writeToAccount:makeDict];
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
