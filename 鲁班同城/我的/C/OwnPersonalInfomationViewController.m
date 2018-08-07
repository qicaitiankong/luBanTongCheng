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
#import "PersonalInfoNameViewController.h"
#import "OwnPersonalInfoModel.h"


@interface OwnPersonalInfomationViewController (){
    UIScrollView *baseScrollView;
    OwnPersonalInfomationTopPictureGoupView *topPartView;
    OwnPersonalInfomationPersonalIntroduceGoupView *personalIntroduceView;
    OwnPersonalInfomationPersonalTechnologyGoupView *personalTechnologyView;
    OwnPersonalInfomationPersonalServiceTypeGoupView *serviceTypeView;
    OwnPersonalInfomationPersonalVideoGoupView *videoView;
    OwnPersonalInfomationPersonalVideoGoupView *pictureView;
    //图片控件高度，先最多显示3张，高度写死
    CGFloat pictureViewGroupHeight;
}

@property (strong,nonatomic) OwnPersonalInfoModel *infoModel;

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
    pictureViewGroupHeight = IMAGE_VIEW_HEIGHT + 5 + 55;
}
//添加关注
- (void)addConcernOrCancelConcel{
    
    NSInteger fouseFlag = self.infoModel.FoucedFlag;
    if (fouseFlag == 0){
        [TDHttpTools AddConcernAction:@{@"myUserId":[lzhGetAccountInfo getAccount].userID,@"userId":self.targetUserId} success:^(id response) {
            [self->topPartView setEditButtDisplayByValue:YES];
            self.infoModel.FoucedFlag = 1;
        } failure:^(NSError *error) {
             [SVProgressHUD showInfoWithStatus:@"添加关注失败"];
        }];
    }else if (fouseFlag == 1){
        [TDHttpTools CancelConcernAction:@{@"myUserId":[lzhGetAccountInfo getAccount].userID,@"userId":self.targetUserId} success:^(id response) {
            [self->topPartView setEditButtDisplayByValue:NO];
            self.infoModel.FoucedFlag = 0;
        } failure:^(NSError *error) {
             [SVProgressHUD showInfoWithStatus:@"取消关注失败"];
        }];
    }
}



- (void)addViews{
    //
    baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    baseScrollView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
    baseScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:baseScrollView];
    //
    topPartView = [[OwnPersonalInfomationTopPictureGoupView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20) targetUseId:[self.targetUserId integerValue]];
    
    topPartView.fenSiLabel.text = @"粉丝";
    topPartView.concernLabel.text = @"关注";
    topPartView.sexAndHomeLabel.text = @"";
    [topPartView.starGroupView setYellowStar:0];
    WS(weakSelf);
    topPartView.navReturnButt.clickButtBlock = ^{
        [weakSelf.rdv_tabBarController setTabBarHidden:NO];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    };
    topPartView.editButt.clickButtBlock = ^{
        //自己的资料
        if ([self.targetUserId integerValue] == -1){
            PersonalInfoNameViewController *nameEditVC = [[PersonalInfoNameViewController alloc]init];
            nameEditVC.orinalInfoModel = weakSelf.infoModel;
            [weakSelf.navigationController pushViewController:nameEditVC animated:YES];
        }else{//他人的资料显示关注
            [weakSelf addConcernOrCancelConcel];
        }
    };
    [baseScrollView addSubview:topPartView];
    //
    personalIntroduceView = [[OwnPersonalInfomationPersonalIntroduceGoupView alloc]initWithFrame:CGRectMake(0, topPartView.bottom + 15, baseScrollView.width, 20)];
    personalIntroduceView.topTipLabel.text = @"个人介绍";
    [baseScrollView addSubview:personalIntroduceView];
    //
    personalTechnologyView = [[OwnPersonalInfomationPersonalTechnologyGoupView alloc]initWithFrame:CGRectMake(0, personalIntroduceView.bottom + 15, baseScrollView.width, 50)];
    personalTechnologyView.topTipLabel.text = @"个人技能";
    [baseScrollView addSubview:personalTechnologyView];
    //
    serviceTypeView = [[OwnPersonalInfomationPersonalServiceTypeGoupView alloc]initWithFrame:CGRectMake(0, personalTechnologyView.bottom + 15, baseScrollView.width, 50)];
    serviceTypeView.topTipLabel.text = @"服务类型";
    [baseScrollView addSubview:serviceTypeView];
    //
    videoView = [[OwnPersonalInfomationPersonalVideoGoupView alloc]initWithFrame:CGRectMake(0, serviceTypeView.bottom + 15, baseScrollView.width, 55)];
    videoView.topTipLabel.text = @"技能-视频秀";
    [baseScrollView addSubview:videoView];
    //
    pictureView = [[OwnPersonalInfomationPersonalVideoGoupView alloc]initWithFrame:CGRectMake(0, videoView.bottom + 15, baseScrollView.width, 55)];
    pictureView.topTipLabel.text = @"技能-图片秀";
    [baseScrollView addSubview:pictureView];
    //
    [baseScrollView setContentSize:CGSizeMake(baseScrollView.width, pictureView.bottom + 20)];
}
//
- (void)getUserInfo{
    //零工
        NSDictionary *praDict =nil;
        if ([self.targetUserId integerValue] == [[lzhGetAccountInfo getAccount].userID integerValue]){//自己信息
            praDict = @{@"myUserId":[lzhGetAccountInfo getAccount].userID};
        }else{//其他零工信息
            praDict = @{@"userId":self.targetUserId,@"myUserId":[lzhGetAccountInfo getAccount].userID};
        }
                WS(weakSelf);
                 [weakSelf giveValueToView];
                [TDHttpTools getCapsualUserInfo:praDict success:^(id response) {
                    NSDictionary *dataDict = response[@"data"];
                    NSLog(@"零工用户信息:%@",dataDict);
//                    address = "\U94f6\U5ea7\U534e\U5e9c";
//                    age = 30;
//                    area = "\U674e\U6ca7\U533a";
//                    city = "\U9752\U5c9b\U5e02";
//                    fansNum = 0;
//                    focusNum = 0;
//                    gender = "\U7537";
//                    headImg = trefreds;
//                    hireNum = 2;
//                    id = 16;
//                    isFocused = 2;
//                    mobile = 17096177665;
                    if ([dataDict allKeys].count){
                        self.infoModel = [OwnPersonalInfoModel setModelFromDict:dataDict];
                       
                        //界面赋值
                        [self giveValueToView];
                    }
                } failure:^(NSError *error) {
                    
                }];
}

- (void)giveValueToView{
    NSURL *imageUrl = [NSURL URLWithString:[self.infoModel.userPictureUrlStr copy]];
    [topPartView.userlogoImaView sd_setImageWithURL:imageUrl];
    topPartView.fenSiLabel.text =[NSString stringWithFormat:@"%ld粉丝",[self.infoModel.fansNum integerValue]];
    topPartView.concernLabel.text = [NSString stringWithFormat:@"%ld关注",[self.infoModel.focusNum integerValue]];
    topPartView.sexAndHomeLabel.text = [NSString stringWithFormat:@"%@ %@",[self.infoModel.sexStr copy],[self.infoModel.addressStr copy]];
    [topPartView.starGroupView setYellowStar:[self.infoModel.starCountNumber integerValue]];
    if (self.infoModel.FoucedFlag == 0){
        [topPartView setEditButtDisplayByValue:NO];
    }else if (self.infoModel.FoucedFlag == 1){
         [topPartView setEditButtDisplayByValue:YES];
    }
    //个人介绍
    [personalIntroduceView giveOwnValue:[self.infoModel.introduceStr copy]];
    //技术
    NSMutableArray *targetTechnologyArr = [self getTargetTechnologyArr:[self.infoModel.technologyArr copy]];
    [personalTechnologyView giveOwnValue:targetTechnologyArr];
    personalTechnologyView.frame = CGRectMake(personalTechnologyView.x, personalIntroduceView.bottom + 15, personalTechnologyView.width, personalTechnologyView.height);
    
    //服务类型
    NSMutableArray *targetJobArr = [self getTargetTechnologyArr:[self.infoModel.jobArr copy]];
    [serviceTypeView giveOwnValue:targetJobArr];
    serviceTypeView.frame = CGRectMake(serviceTypeView.x, personalTechnologyView.bottom + 15, serviceTypeView.width, serviceTypeView.height);
    //视屏
    [videoView givePictureArr:[NSArray getOwnCopyArr:self.infoModel.videoUrlStrArr]];
    videoView.frame = CGRectMake(videoView.x, serviceTypeView.bottom + 15, videoView.width, pictureViewGroupHeight);
   //图片
    [pictureView givePictureArr:[NSArray getOwnCopyArr:self.infoModel.pictureUrlStrArr]];
    pictureView.frame = CGRectMake(pictureView.x, videoView.bottom + 15, pictureView.width, pictureViewGroupHeight);
    //
    UIView *botView = pictureView;
     [baseScrollView setContentSize:CGSizeMake(baseScrollView.width, botView.bottom + 10)];
    //没图片没视屏
//    if (self.personalPictureArr.count == 0 && self.personalVideoArr.count == 0){
//        NSLog(@"没图片没视屏");
//        botView = serviceTypeView;
//        videoView.hidden =YES;
//        pictureView.hidden = YES;
//         [baseScrollView setContentSize:CGSizeMake(baseScrollView.width, botView.bottom + 10)];
//    //有图片没视频
//    }else if (self.personalPictureArr.count != 0){
//         NSLog(@"有图片没视频");
//        videoView.hidden = YES;
//        pictureView.frame = CGRectMake(0, serviceTypeView.bottom + 15, baseScrollView.width, pictureViewGroupHeight);
//        [baseScrollView setContentSize:CGSizeMake(baseScrollView.width, serviceTypeView.bottom + 15 + pictureViewGroupHeight +10)];
//    }else if(self.personalVideoArr.count != 0){   //有视屏没图片
//         NSLog(@"有视屏没图片");
//        pictureView.hidden = YES;
//        [baseScrollView setContentSize:CGSizeMake(baseScrollView.width, serviceTypeView.bottom + 15 + pictureViewGroupHeight +10)];
//    }else{
//        //有图片有视屏
//        NSLog(@"有图片有视屏");
//
//    }
    
}
//将获取的技术，工作等数组数据解析为需要的字符串数组
- (NSMutableArray*)getTargetTechnologyArr:(NSArray*)originArr{
    NSMutableArray *localTechnologyArr = [[NSMutableArray alloc]init];
    for (NSDictionary *localDict in originArr){
        [localTechnologyArr addObject:localDict[@"name"]];
    }
    return localTechnologyArr;
}


//- (void)makeDictToWritePlist:(NSDictionary*)dict{
//    //
//    NSString *userName =  [NSString getResultStrBySeverStr:dict[@"username"]];
//    NSString *realName = [NSString getResultStrBySeverStr: dict[@"realName"]];
//    NSString *gender = [NSString getResultStrBySeverStr: dict[@"gender"]];
//    NSString *headImg = [NSString getResultStrBySeverStr: dict[@"headImg"]];
//    NSString *mobile = [NSString getResultStrBySeverStr: dict[@"mobile"]];
//    NSString *userType = [NSString getResultStrBySeverStr: dict[@"userType"]];
//    NSNumber *age = [NSNumber getResultNumberBySeverStr: dict[@"age"]];
//    NSNumber *focusNum = [NSNumber getResultNumberBySeverStr:dict[@"focusNum"]];
//    NSNumber *fansNum = [NSNumber getResultNumberBySeverStr:dict[@"fansNum"]];
//    NSNumber *userID = [NSNumber getResultNumberBySeverStr:dict[@"id"]];
//    //
//    NSDictionary *makeDict = @{@"userName":userName,@"realName":realName,@"gender":gender,@"age":age,@"headImg":headImg,@"mobile":mobile,@"userType":userType,@"userId":userID,@"focusNum":focusNum,@"fansNum":fansNum};
//    [[lzhGetAccountInfo getAccount] writeToAccount:makeDict];
//}



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
