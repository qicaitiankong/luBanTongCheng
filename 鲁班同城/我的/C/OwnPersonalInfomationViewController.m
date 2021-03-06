//
//  OwnPersonalInfomationViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalInfomationViewController.h"
#import "PersonalInfoNameViewController.h"
//view
#import "OwnPersonalInfomationTopPictureGoupView.h"
#import "ChageNamePop.h"
//m
#import "OwnPersonalInfoModel.h"
//cell
#import "OwnPersonalServiceTypeTableViewCell.h"
#import "OwnPersonalIntroduceTableViewCell.h"
#import "OwnPersonalPictureTableViewCell.h"


@interface OwnPersonalInfomationViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{
    UIScrollView *baseScrollView;
    OwnPersonalInfomationTopPictureGoupView *topPartView;
    MessageSoundView *soundView;
    ShareNetWorkState *ownWorkState;
}

@property (strong,nonatomic) OwnPersonalInfoModel *infoModel;

@property (strong,nonatomic) UITableView *tableView;

@end

@implementation OwnPersonalInfomationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //add refresh noti
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserInfo) name:PERSONAL_REFRESH_NOTI object:nil];
    
    [self initOwnObjects];
    //
    [self addTableView];
    [self getUserInfo];
    //
    
}

- (void)initOwnObjects{
    //模型必须创建，因为cell用该模型布局，如果无网络，该模型也不能为空
    self.infoModel = [[OwnPersonalInfoModel alloc]init];
    ownWorkState = [ShareNetWorkState ShareNetState];
}
//语音播放
- (void)playSoundIfHaveSound{
    NSLog(@"点击了播放语音");
    //将下载的与语音转换为wav
    if(nil == self.infoModel.nameSoundData){
        NSLog(@"下载语音");
        [ownWorkState asynSerialDownloadMethd02:self.infoModel.nameSoundUrlStr downloadCompleteHandler:@selector(playIntroDuceSound:) target:self modelIndex:0];
    }else{
        NSLog(@"播放语音");
        [soundView giveTimeToSoundViewAndPlay:[NSString stringWithFormat:@"%ld",self.infoModel.nameSoundTime] wavData:self.infoModel.nameSoundData];
    }
}

- (void)playIntroDuceSound:(NSDictionary*)dict{
    //int mainIndex = [dict[@"modelIndex"] intValue];
    NSData *amrSoundData = [dict[@"imageData"] copy];
    self.infoModel.nameSoundAmrData = amrSoundData;
    self.infoModel.nameSoundData = [self.infoModel getWavData:self.infoModel.nameSoundAmrData];
    [soundView giveTimeToSoundViewAndPlay:[NSString stringWithFormat:@"%ld",self.infoModel.nameSoundTime] wavData:self.infoModel.nameSoundData];
    
}

//添加关注
- (void)addConcernOrCancelConcel{
    NSInteger fouseFlag = self.infoModel.FoucedFlag;
    if (fouseFlag == 0){
        [TDHttpTools AddConcernAction:@{@"hisId":self.targetUserId} success:^(id response) {
            [self->topPartView setEditButtDisplayByValue:YES];
            self.infoModel.FoucedFlag = 1;
        } failure:^(NSError *error) {
             [SVProgressHUD showInfoWithStatus:@"添加关注失败"];
        }];
    }else if (fouseFlag == 1){
        [TDHttpTools CancelConcernAction:@{@"hisId":self.targetUserId} success:^(id response) {
            [self->topPartView setEditButtDisplayByValue:NO];
            self.infoModel.FoucedFlag = 0;
        } failure:^(NSError *error) {
             [SVProgressHUD showInfoWithStatus:@"取消关注失败"];
        }];
    }
}
- (void)changeEmploymentName{
    NSLog(@"修改名字");
    [ChageNamePop showPopView:^(NSString *nameStr) {
        //点击了确定
        NSLog(@"修改名字确定=%@",nameStr);
    }];
}
//
- (void)addTableView{
    WS(weakSelf);
    //
    topPartView = [[OwnPersonalInfomationTopPictureGoupView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20) targetUseId:[self.targetUserId integerValue]];
    if([lzhGetAccountInfo getAccount].identityFlag){
        [topPartView displayForEmployment];
        topPartView.changeNameButt.clickButtBlock = ^{
            [weakSelf changeEmploymentName];
        };
    }else{
        topPartView.fenSiLabel.text = @"粉丝";
        topPartView.concernLabel.text = @"关注";
        topPartView.sexAndHomeLabel.text = @"";
        [topPartView.starGroupView setYellowStar:0];
    }
    topPartView.navReturnButt.clickButtBlock = ^{
        [weakSelf.rdv_tabBarController setTabBarHidden:NO];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    };
    topPartView.editButt.clickButtBlock = ^{
        if([lzhGetAccountInfo getAccount].identityFlag == 0){
            //自己的资料
            if ([self.targetUserId integerValue] == [[lzhGetAccountInfo getAccount].userID integerValue]){
                PersonalInfoNameViewController *nameEditVC = [[PersonalInfoNameViewController alloc]init];
                nameEditVC.orinalInfoModel = weakSelf.infoModel;
                [weakSelf.navigationController pushViewController:nameEditVC animated:YES];
            }else{//他人的资料显示关注
                [weakSelf addConcernOrCancelConcel];
            }
        }else{
            NSLog(@"雇主查看历史派单");
        }
    };

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.tableHeaderView = topPartView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger section = 0;
    if([lzhGetAccountInfo getAccount].identityFlag){
        section = 1;
    }else{
        section = 3;
    }
    return section;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            if([lzhGetAccountInfo getAccount].identityFlag){
                rows = 2;
            }else{
                rows = 1;
            }
            break;
        case 1:
            rows = 2;
            break;
        case 2:
            rows  = 2;
            break;
        default:
            break;
    }
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *parentCell = nil;
    if([lzhGetAccountInfo getAccount].identityFlag){
        static NSString *picFlagCell = @"picCell";
        OwnPersonalPictureTableViewCell *picCell = [tableView dequeueReusableCellWithIdentifier:picFlagCell];
        if (nil == picCell){
            picCell = [[OwnPersonalPictureTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:picFlagCell];
        }
        picCell.path = indexPath;
        //
        picCell.model = self.infoModel;
        //
        parentCell = picCell;
    }else{
        switch (indexPath.section) {
            case 0:{
                static NSString *introCellFlag = @"introCell";
                OwnPersonalIntroduceTableViewCell *introCell = [tableView dequeueReusableCellWithIdentifier:introCellFlag];
                if (nil == introCell){
                    WS(weakSelf);
                    introCell = [[OwnPersonalIntroduceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:introCellFlag];
                    soundView = introCell.soundView; introCell.soundView.clickSoundViewBlock = ^{
                        [weakSelf playSoundIfHaveSound];
                    };
                }
                introCell.model = self.infoModel;
                parentCell = introCell;
            }
                break;
            case 1:
            {
                static NSString *secondFlagCell = @"cell";
                OwnPersonalServiceTypeTableViewCell *technologyCell = [tableView dequeueReusableCellWithIdentifier:secondFlagCell];
                if (nil == technologyCell){
                    technologyCell = [[OwnPersonalServiceTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                }
                technologyCell.path = indexPath;
                technologyCell.model = self.infoModel;
                parentCell = technologyCell;
            }
                break;
            case 2:{
                static NSString *picFlagCell = @"picCell";
                OwnPersonalPictureTableViewCell *picCell = [tableView dequeueReusableCellWithIdentifier:picFlagCell];
                if (nil == picCell){
                    picCell = [[OwnPersonalPictureTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:picFlagCell];
                }
                picCell.path = indexPath;
                //
                picCell.model = self.infoModel;
                //
                parentCell = picCell;
            }
                break;
            default:
                break;
        }
    }
    
    return parentCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 0;
    if([lzhGetAccountInfo getAccount].identityFlag){
            cellHeight = [tableView cellHeightForIndexPath:indexPath model:self.infoModel keyPath:@"model" cellClass:[OwnPersonalPictureTableViewCell class] contentViewWidth:SCREEN_WIDTH];
    }else{
        switch (indexPath.section) {
            case 0:{
                cellHeight = [tableView cellHeightForIndexPath:indexPath model:self.infoModel keyPath:@"model" cellClass:[OwnPersonalIntroduceTableViewCell class] contentViewWidth:SCREEN_WIDTH];
            }
                break;
            case 1:{
                if (indexPath.row == 0){
                    cellHeight = [tableView cellHeightForIndexPath:indexPath model:self.infoModel keyPath:@"model" cellClass:[OwnPersonalServiceTypeTableViewCell class] contentViewWidth:SCREEN_WIDTH];
                }else if (indexPath.row == 1){
                    cellHeight = [tableView cellHeightForIndexPath:indexPath model:self.infoModel keyPath:@"model" cellClass:[OwnPersonalServiceTypeTableViewCell class] contentViewWidth:SCREEN_WIDTH];
                }
            }
                break;
            case 2:{
                cellHeight = [tableView cellHeightForIndexPath:indexPath model:self.infoModel keyPath:@"model" cellClass:[OwnPersonalPictureTableViewCell class] contentViewWidth:SCREEN_WIDTH];
            }
                break;
            default:
                break;
        }
    }
   
    
    return cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


//
- (void)getUserInfo{
    self.infoModel = [[OwnPersonalInfoModel alloc]init];
    if([lzhGetAccountInfo getAccount].identityFlag == 0){
        //零工
        NSDictionary *praDict =nil;
        if ([self.targetUserId integerValue] == [[lzhGetAccountInfo getAccount].userID integerValue]){//自己信息
            praDict = @{};
        }else{//其他零工信息
            praDict = @{@"hisId":self.targetUserId};
        }
        NSLog(@"\n\n!!!!!!!!!praDict=%@\n\n",praDict);
                [TDHttpTools getCapsualUserInfo:praDict success:^(id response) {
                    NSDictionary *dataDict = response[@"data"];
                    NSLog(@"零工用户信息:%@",dataDict);
                    //显示编辑按钮
                    self->topPartView.editButt.hidden = NO;
                    //
                    if ([dataDict allKeys].count){
                        self.infoModel = [OwnPersonalInfoModel setModelFromDict:dataDict];
                        
                        //界面赋值
                        [self.tableView reloadData];
                    }
                } failure:^(NSError *error) {
                    //
                }];
    }else{//雇主
        topPartView.employmentNameLabel.text = @"我是雇主名字";
    }
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
