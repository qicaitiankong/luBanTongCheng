//
//  OwnPersonalInfomationViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalInfomationViewController.h"
#import "OwnPersonalInfomationTopPictureGoupView.h"
#import "PersonalInfoNameViewController.h"
#import "OwnPersonalInfoModel.h"

//cell
#import "OwnPersonalServiceTypeTableViewCell.h"
#import "OwnPersonalIntroduceTableViewCell.h"
#import "OwnPersonalPictureTableViewCell.h"


@interface OwnPersonalInfomationViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIScrollView *baseScrollView;
    OwnPersonalInfomationTopPictureGoupView *topPartView;
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
}

- (void)initOwnObjects{
    //模型必须创建，因为cell用该模型布局，如果无网络，该模型也不能为空
    self.infoModel = [[OwnPersonalInfoModel alloc]init];
    
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
//修改界面版
//
- (void)addTableView{
    //
    topPartView = [[OwnPersonalInfomationTopPictureGoupView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20) targetUseId:[self.targetUserId integerValue]];
    
    topPartView.fenSiLabel.text = @"粉丝";
    topPartView.concernLabel.text = @"关注";
    topPartView.sexAndHomeLabel.text = @"";
    [topPartView.starGroupView setYellowStar:0];
    //topPartView.editButt.hidden = YES;
    WS(weakSelf);
    topPartView.navReturnButt.clickButtBlock = ^{
        [weakSelf.rdv_tabBarController setTabBarHidden:NO];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    };
    topPartView.editButt.clickButtBlock = ^{
        //自己的资料
        if ([self.targetUserId integerValue] == [[lzhGetAccountInfo getAccount].userID integerValue]){
            PersonalInfoNameViewController *nameEditVC = [[PersonalInfoNameViewController alloc]init];
            nameEditVC.orinalInfoModel = weakSelf.infoModel;
            [weakSelf.navigationController pushViewController:nameEditVC animated:YES];
        }else{//他人的资料显示关注
            [weakSelf addConcernOrCancelConcel];
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
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 1;
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
    
    switch (indexPath.section) {
        case 0:{
            static NSString *introCellFlag = @"introCell";
            OwnPersonalIntroduceTableViewCell *introCell = [tableView dequeueReusableCellWithIdentifier:introCellFlag];
            if (nil == introCell){
                introCell = [[OwnPersonalIntroduceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:introCellFlag];
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
            if(indexPath.row == 0){
                technologyCell.model = self.infoModel;
                technologyCell.topDisplayLabel.text = @"个人技能";
            }else{
                technologyCell.model = self.infoModel;
                technologyCell.topDisplayLabel.text = @"服务类型";
            }
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
    return parentCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 0;
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
    
    return cellHeight;
}
//
- (void)getUserInfo{
    self.infoModel = [[OwnPersonalInfoModel alloc]init];
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
                        
                        self.infoModel.pictureUrlStrArr = @[@"",@"",@"",@""];
                        //界面赋值
                        [self.tableView reloadData];
                        //
//                       [self getTechnologyPictureInfo];
                    }
                } failure:^(NSError *error) {
                    //
                }];
}

- (void)getTechnologyPictureInfo{
    [TDHttpTools getSeveralPicture:@{@"relatedId":self.targetUserId,@"application":[NSString getPictureAndVideoInfoServiceNeedFunctionStr:3],@"type":[NSString getPictureAndVideoServiceNeedTypeFlagStr:0]} success:^(id response) {
        NSInteger state = [response[@"status"] integerValue];
        if (state == 0){
            NSArray *dataArr = response[@"data"];
            NSLog(@"技能秀图片 dataArr:%@",dataArr);
            self.infoModel.pictureInfoArr = [[NSMutableArray alloc ] initWithArray:dataArr];
            self.infoModel.pictureUrlStrArr = [self.infoModel getTargetImageUrlStrArr:self.infoModel.pictureInfoArr];
            [self.tableView reloadData];
        }else{
        }
    } failure:^(NSError *error) {
        
    }];
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
