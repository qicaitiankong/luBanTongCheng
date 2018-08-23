//
//  MyInfoViewController.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyInfoTableViewCell.h"
#import "MyInfoTableHeaderView.h"
#import "MyInfoTableFootView.h"
//vc
#import "OwnPersonalInfomationViewController.h"
#import "SettingViewController.h"
#import "MessageViewController.h"
#import "ConcernViewController.h"
#import "SearchViewController.h"
#import "EmploymentRecordViewController.h"

@interface MyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *cellTitleArr;
    NSMutableArray *cellImageArr;
    MyInfoTableHeaderView *headerView;
    MyInfoTableFootView *footerView;
    //修改头像时用到的
    NSMutableArray *selectedImageDataArr;
}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSDictionary *userInfoDict;

@end

@implementation MyInfoViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([lzhGetAccountInfo getAccount].identityFlag){
        [self hiddenXuanFuButt];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools hiddenNav:self.navigationController];
    [NavTools displayTabbar:self.rdv_tabBarController];
    if ([lzhGetAccountInfo getAccount].identityFlag){
        [self displayXuanFuButt];
    }else{
        [self hiddenXuanFuButt];
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad 用户状态：%ld",[lzhGetAccountInfo getAccount].identityFlag);
    self.view.backgroundColor = [UIColor whiteColor];
    [NavTools displayTabbar:self.rdv_tabBarController];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self initObject];
    [self addTableView:CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_WIDTH, CENTER_VIEW_HEIGHT + NAVIGATION_HEIGHT) style:UITableViewStylePlain];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserTypeNoti:) name:USER_TYPE_UPDATE_NOTIFICATION_NAME object:nil];
    //更换头像
    WS(weakSelf);
    self.selectedImageBlock = ^(NSData *pictureData, UIImage *selectedPicture) {
        __strong typeof(weakSelf) sself = weakSelf;
        [sself -> selectedImageDataArr addObject:pictureData];
        [weakSelf uploadUserPicture];
    };
    //
    [self getData];
    
}

//获取用户信息
- (void)getData{
    WS(weakSelf);
    if ([lzhGetAccountInfo getAccount].identityFlag){
        [TDHttpTools getEmployerMyPage:@{} success:^(id response) {
            
            self.userInfoDict = response;
            [self.tableView reloadData];
            //
            [weakSelf giveValue];
            //
        } failure:^(NSError *error) {
            
        }];
    }else{
        
    }
}

- (void)uploadUserPicture{
    [TDHttpTools uploadFile:@{} traileUrlStr:@"/lubantc/api/user/updateHeadImg" imageFlagName:@"headPic" imageDataArr:selectedImageDataArr success:^(id response) {
        NSDictionary *dict = response;
        NSLog(@"头像上传%@",dict);
        if ([dict[@"status"] integerValue] == 0){
            [SVProgressHUD showSuccessWithStatus:@"上传头像成功"];
            NSString *pictureUrlStr = [NSString getResultStrBySeverStr:dict[@"data"]];
            NSURL *picUrl = [NSURL URLWithString:pictureUrlStr];
            [self->headerView.userImageView sd_setImageWithURL:picUrl];
        }else{
            [SVProgressHUD showInfoWithStatus:@"上传头像失败"];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)giveValue{
    NSURL *picUrl = [NSURL URLWithString:self.userInfoDict[@"headImg"]];
    [headerView.userImageView sd_setImageWithURL:picUrl];
    headerView.userNameLabel.text = self.userInfoDict[@"userName"];
}

- (void)initObject{
     cellImageArr = [[NSMutableArray alloc] init];
    selectedImageDataArr = [[NSMutableArray alloc]init];
    if ([lzhGetAccountInfo getAccount].identityFlag == 0){
        cellTitleArr = @[@"消息",@"收藏",@"搜索",@"个人资料",@"设置"];
        for (int i = 0; i < cellTitleArr.count; i ++){
            NSString *imageStr = nil;
            if (i == 0){
                imageStr = @"set000";
            }else{
                imageStr = [NSString stringWithFormat:@"set0%d",i-1];
            }
            UIImage *image = [UIImage imageNamed:imageStr];
            [cellImageArr addObject:image];
        }
    }else{
        cellTitleArr = @[@"消息",@"雇佣记录",@"收藏",@"搜索",@"个人资料",@"设置"];
        for (int i = 0; i < cellTitleArr.count; i ++){
            NSString *imageStr = nil;
            switch (i) {
                case 0:{
                     imageStr = @"set000";
                }
                    break;
                case 1:{
                    imageStr = @"employmentRecord";
                }
                    break;
                default:{
                    imageStr = [NSString stringWithFormat:@"set0%d",i-2];
                }
                    break;
            }
            UIImage *image = [UIImage imageNamed:imageStr];
            [cellImageArr addObject:image];
        }
    }
}


//切换身份
- (void)exchangeIndentity{
    NSLog(@"??????????userid=%ld",[[lzhGetAccountInfo getAccount].userID integerValue]);
    [TDHttpTools exchangeUserIdentity:@{} success:^(id response) {
        [SVProgressHUD showInfoWithStatus:response[@"msg"]];
        NSLog(@"!!!!!!!!!!dict=%@ 后台切换为了%@",response,response[@"data"]);
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        lzhGetAccountInfo *accountInfo = [lzhGetAccountInfo getAccount];
        
        NSDictionary *dataDict = response[@"data"];
        NSInteger identityFlagNum = [dataDict[@"userType"] integerValue];
        NSDictionary *infoDict = accountInfo.infoDict;
        if (identityFlagNum == 1){//已经切换为了零工
            [infoDict setValue:@1 forKey:@"userType"];
           BOOL writeSuc =  [accountInfo writeToAccount:infoDict];
            if(writeSuc){
                [appDelegate setupViewControllersForCasualLabour];
            }
            
        }else if (identityFlagNum == 2){//已经切换为了雇主
            //
            [infoDict setValue:@2 forKey:@"userType"];
            if([accountInfo writeToAccount:infoDict]){
                [appDelegate setupViewControllersForEmployment];
            }
        }
        NSLog(@"打印切换身份%ld", [lzhGetAccountInfo getAccount].identityFlag);
    } failure:^(NSError *error) {
        
    }];
}


//view
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    WS(weakSelf);
    headerView = [[MyInfoTableHeaderView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT / 2)];
    headerView.userNameLabel.text = @"昵称昵称昵称";
    headerView.commissionLabel.text = @"6666";
    headerView.backImageButt.clickButtBlock = ^{
        [weakSelf callActionSheetFunc];
    };
    //
    footerView = [[MyInfoTableFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.195)];
    if ([lzhGetAccountInfo getAccount].identityFlag){
        [footerView.identityButtView.loginButt setTitle:@"切换为零工状态" forState:UIControlStateNormal];
    }else{
         [footerView.identityButtView.loginButt setTitle:@"切换为雇主状态" forState:UIControlStateNormal];
    }
    footerView.identityButtView.clickButtBlock = ^{
        //NSLog(@"切换身份");
        [weakSelf exchangeIndentity];
    };
    footerView.exitLoginButtView.clickButtBlock = ^{
        //NSLog(@"退出登录");
        [lzhGetAccountInfo cleanAccountInfo];
        AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [app displayLoginPageByIsInstalledWX];
    };
    //
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = footerView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cellTitleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellFlag = @"cellFlag";
    MyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    if (nil == cell){
        cell = [[MyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag height:SCREEN_HEIGHT * 0.074];
    }
    UIImage *leftImage = cellImageArr[indexPath.row];
    NSString *title = cellTitleArr[indexPath.row];
    [cell.leftImageView setImage:leftImage];
    [cell.rightLabel setText:title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger accountFlag =  [lzhGetAccountInfo getAccount].identityFlag;
    switch (indexPath.row) {
        case 0:{
            MessageViewController *messageVC = [[MessageViewController alloc]init];
            [self.navigationController pushViewController:messageVC  animated:YES];
        }
            break;
        case 1:{
                if (accountFlag){
                    EmploymentRecordViewController *emplomentVC = [[EmploymentRecordViewController alloc]init];
                    [self.navigationController pushViewController:emplomentVC animated:YES];
                }else{
                    ConcernViewController *concernVC = [[ConcernViewController alloc]init];
                    [self.navigationController pushViewController:concernVC animated:YES];
                }
        }
            break;
        case 2:{
            if (accountFlag){
                ConcernViewController *concernVC = [[ConcernViewController alloc]init];
                [self.navigationController pushViewController:concernVC animated:YES];
            }else{
                SearchViewController *searchVC = [[SearchViewController alloc]init];
                [self.navigationController pushViewController:searchVC animated:YES];
            }
            
        }
            break;
        case 3:{
            if (accountFlag){
                SearchViewController *searchVC = [[SearchViewController alloc]init];
                [self.navigationController pushViewController:searchVC animated:YES];
            }else{
                OwnPersonalInfomationViewController *personalInfoVC = [[OwnPersonalInfomationViewController alloc]init];
                 personalInfoVC.targetUserId= [lzhGetAccountInfo getAccount].userID;
                [self.navigationController pushViewController:personalInfoVC animated:YES];
            }
            
        }
            break;
        case 4:{
            if (accountFlag){
                OwnPersonalInfomationViewController *personalInfoVC = [[OwnPersonalInfomationViewController alloc]init];
                personalInfoVC.targetUserId = [lzhGetAccountInfo getAccount].userID;
                [self.navigationController pushViewController:personalInfoVC animated:YES];
            }else{
                SettingViewController *setVC = [[SettingViewController alloc]init];
                [self.navigationController pushViewController:setVC animated:YES];
            }
           
        }
            break;
        case 5:{
            SettingViewController *setVC = [[SettingViewController alloc]init];
            [self.navigationController pushViewController:setVC animated:YES];
        }
            break;
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT * 0.074;
}

- (void)updateUserTypeNoti:(NSNotificationCenter*)_n{
    NSLog(@"通知刷新界面");
    [self.tableView reloadData];
}

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
