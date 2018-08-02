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
    //图片控件高度，先最多显示3张，高度写死
    CGFloat pictureViewGroupHeight;
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
    pictureViewGroupHeight = IMAGE_VIEW_HEIGHT + 5 + 55;
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
    if ([lzhGetAccountInfo getAccount].identityFlag == 0){
                NSDictionary *praDict = @{@"userId":self.targetUserID};
                WS(weakSelf);
                 [weakSelf giveValueToView];
                [TDHttpTools getCapsualUserInfo:praDict success:^(id response) {
                    NSDictionary *dataDict = response[@"data"];
                    NSLog(@"零工用户信息:%@",dataDict);
                    if ([dataDict allKeys].count){
                        //写入plist
                        NSNumber *starNumber = [NSNumber getResultNumberBySeverStr:dataDict[@"score"]];
                        weakSelf.starCount = [starNumber integerValue];
                    
                        NSArray *techArr = dataDict[@"technologys"];
                        NSArray *jobArr = dataDict[@"professions"];
                        NSArray *videoArr = dataDict[@"technologysVideo"];
                        NSArray *picArr = dataDict[@"technologysPic"];
                        if (techArr.count){
                            [weakSelf.personalTechnologyArr addObjectsFromArray:techArr];
                        }
                        if (jobArr.count){
                            [weakSelf.personalJobArr addObjectsFromArray:jobArr];
                        }
                        if (videoArr.count){
                            [weakSelf.personalVideoArr addObjectsFromArray:videoArr];
                        }
                        if (picArr.count){
                            [weakSelf.personalPictureArr addObjectsFromArray:picArr];
                        }
                        //界面赋值
                        [self giveValueToView];
                    }
                } failure:^(NSError *error) {
                    
                }];
    }else if ([lzhGetAccountInfo getAccount].identityFlag == 1){//雇主
        
    }
}

- (void)giveValueToView{
    NSURL *imageUrl = [NSURL URLWithString:[lzhGetAccountInfo getAccount].PhotoUrl];
    [topPartView.userlogoImaView sd_setImageWithURL:imageUrl];
    topPartView.fenSiLabel.text =[NSString stringWithFormat:@"%ld粉丝",[lzhGetAccountInfo getAccount].fansCount];
    topPartView.concernLabel.text = [NSString stringWithFormat:@"%ld关注",[lzhGetAccountInfo getAccount].fousCount];
    topPartView.sexAndHomeLabel.text = [NSString stringWithFormat:@"%@ %@ %@",[lzhGetAccountInfo getAccount].sexStr,[GetLocationICitynfo getLocationInfo].provinceStr,[GetLocationICitynfo getLocationInfo].cityStr];
    [topPartView.starGroupView setYellowStar:self.starCount];
    //个人介绍
    [personalIntroduceView giveOwnValue:@"个人介绍个人介绍个人介绍个人介绍个人介绍个人介绍个人介绍个人介绍个人介绍个人介绍个人介绍个人介绍个人介绍个人介绍个人介绍"];
    //技术
    NSMutableArray *targetTechnologyArr = [self getTargetTechnologyArr:self.personalTechnologyArr];
    [personalTechnologyView giveOwnValue:targetTechnologyArr];
    personalTechnologyView.frame = CGRectMake(personalTechnologyView.x, personalIntroduceView.bottom + 15, personalTechnologyView.width, personalTechnologyView.height);
    
    //服务类型
    NSMutableArray *targetJobArr = [self getTargetTechnologyArr:self.personalJobArr];
    [serviceTypeView giveOwnValue:targetJobArr];
    serviceTypeView.frame = CGRectMake(serviceTypeView.x, personalTechnologyView.bottom + 15, serviceTypeView.width, serviceTypeView.height);
    //视屏
    [videoView givePictureArr:self.personalVideoArr];
    videoView.frame = CGRectMake(videoView.x, serviceTypeView.bottom + 15, videoView.width, pictureViewGroupHeight);
   //图片
    [pictureView givePictureArr:self.personalPictureArr];
    
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
