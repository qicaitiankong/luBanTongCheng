//
//  PersonalInfoVideoViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "PersonalInfoVideoViewController.h"
#import "PersonalInfoAddPhotoFlagView.h"
#import "CustomeStyleCornerButt.h"
#import "CommitPopView.h"
#import "OwnPersonalInfoSelectPictureCellTableViewCell.h"

#import "OwnPersonalInfoSectionView.h"

@interface PersonalInfoVideoViewController ()<UITableViewDelegate,UITableViewDataSource>{
    ImageAndLabelView *seondImageAndLabelView;
    
    CommitPopView *popView;
    UIButton *popbackButt;
    
    OwnPersonalInfoSectionView *firstSectionView;
    OwnPersonalInfoSectionView *secondSectionView;
    UIView *completeView;
    
    NSIndexPath *currentClickpath;
}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) OwnPersonalInfoChoosePictureModel *videoModel;

@property (strong,nonatomic) OwnPersonalInfoChoosePictureModel *pictureModel;

@end

@implementation PersonalInfoVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavStyle];
    //图片选取回调
    WS(weakSelf);
    self.selectedImageBlock = ^(NSString *pictureBase64str, UIImage *selectedPicture) {
        NSLog(@"!!!!!!!!!!!!!!选取图片%@ %@",selectedPicture,pictureBase64str);
        [weakSelf setPictureWhenChooseCpmplete:pictureBase64str image:selectedPicture];
    };
    //WS(weakSelf);
    [self initOwnObjects];
    
    [self createCompleteViews];
    [self addTableViews];
}

- (void)initNavStyle{
    [self.navigationController setNavigationBarHidden:NO];
    [self.rdv_tabBarController setTabBarHidden:YES];
    //
    self.title = @"个人资料";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButt)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButt)];
}

- (void)leftBarButt{
        [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBarButt{
   
}

- (void)initOwnObjects{
    self.videoModel = [[OwnPersonalInfoChoosePictureModel alloc]init];
    self.videoModel.selectedImageArr = [NSArray getOwnCopyArr:self.amendingInfoModel.technologyPicArr];
    self.pictureModel = [[OwnPersonalInfoChoosePictureModel alloc]init];
    self.videoModel.selectedImageArr = [NSArray getOwnCopyArr:self.amendingInfoModel.technologyVideoArr];
}

- (void)addPicture:(NSIndexPath*)path{
    currentClickpath = path;
    NSLog(@"点击选取图片path.section=%ld",path.section);
     [self callActionSheetFunc];
   
    
}

- (void)setPictureWhenChooseCpmplete:(NSString *)pictureBase64str image:(UIImage *)selectedPicture{
    NSLog(@"添加视频或图片");
    if (currentClickpath.section == 1){//添加视频
        if (self.videoModel.selectedImageArr.count < 7){
            [self.videoModel.selectedImageArr addObject:selectedPicture];
            [self.videoModel.selectedImageBaseStrArr addObject:pictureBase64str];
        }
        
    }else{//图片
        if (self.pictureModel.selectedImageArr.count < 7){
            [self.pictureModel.selectedImageArr addObject:selectedPicture];
             [self.pictureModel.selectedImageBaseStrArr addObject:pictureBase64str];
        }
    }
    [self.tableView reloadData];
}



- (void)addTableViews{
    //
    firstSectionView = [[OwnPersonalInfoSectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 30) image:[UIImage imageNamed:@"videoFlag"] title:@"技能-视频秀"];
    //
   secondSectionView = [[OwnPersonalInfoSectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 30) image:[UIImage imageNamed:@"photoFlag"] title:@"技能-图片秀"];
    secondSectionView.rightTopTipLabel.hidden = YES;
    //
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    //
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section % 2){
        return 1;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OwnPersonalInfoSelectPictureCellTableViewCell
    *parentCell = nil;
    if (indexPath.section == 1){
        static NSString *cellFlag = @"cell";
        OwnPersonalInfoSelectPictureCellTableViewCell
        *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
        if (nil == cell){
            WS(weakSelf);
            cell = [[OwnPersonalInfoSelectPictureCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
            cell.addPictureBlock = ^(NSIndexPath *path) {
                [weakSelf addPicture:path];
            };
        }
        parentCell = cell;
    }else if (indexPath.section == 3){
        static NSString *cellFlag = @"cell2";
        OwnPersonalInfoSelectPictureCellTableViewCell
        *cell2 = [tableView dequeueReusableCellWithIdentifier:cellFlag];
        if (nil == cell2){
            WS(weakSelf);
            cell2 = [[OwnPersonalInfoSelectPictureCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
            cell2.addPictureBlock = ^(NSIndexPath *path) {
                [weakSelf addPicture:path];
            };
        }
        parentCell = cell2;
    }
  
    parentCell.path = indexPath;
    if (indexPath.section == 1){
        parentCell.model = self.videoModel;
    }else{
        parentCell.model = self.pictureModel;
    }
    return parentCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if (indexPath.section == 1){
         height = [tableView cellHeightForIndexPath:indexPath model:self.videoModel keyPath:@"model" cellClass:[OwnPersonalInfoSelectPictureCellTableViewCell class] contentViewWidth:SCREEN_WIDTH];
    }else{
         height = [tableView cellHeightForIndexPath:indexPath model:self.pictureModel keyPath:@"model" cellClass:[OwnPersonalInfoSelectPictureCellTableViewCell class] contentViewWidth:SCREEN_WIDTH];
    }
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section % 2){
        return nil;
    }else{
        if (section == 0){
            return firstSectionView;
        }else{
            return secondSectionView;
        }

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section % 2){
        return 0;
    }else{
        if (section == 0){
             return firstSectionView.height;
        }else{
             return secondSectionView.height;
        }
       
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3){
        return completeView.height;
    }else{
        return 0;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3){
        return completeView;
    }else{
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)createCompleteViews{
    completeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 300)];
        CustomeStyleCornerButt *nextButt = [[CustomeStyleCornerButt alloc] initWithFrame:CGRectMake(0, 240, completeView.width * 0.9, 50) backColor:[UIColor colorWithHexString:@"#78CAC5"] cornerRadius:4 title:@"完成" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:18]];
        nextButt.center = CGPointMake(completeView.width  / 2, nextButt.centerY);
        WS(weakSelf);
        nextButt.clickButtBlock = ^{
            [weakSelf nextHandler];
        };
    [completeView addSubview:nextButt];
}

- (void)nextHandler{
    self.amendingInfoModel.nameStr = [NSString getResultStrBySeverStr:self.amendingInfoModel.nameStr];
    self.amendingInfoModel.sexStr = [NSString getResultStrBySeverStr:self.amendingInfoModel.sexStr];
     self.amendingInfoModel.proviceStr = [NSString getResultStrBySeverStr:self.amendingInfoModel.proviceStr];
     self.amendingInfoModel.cityStr = [NSString getResultStrBySeverStr:self.amendingInfoModel.cityStr];
    self.amendingInfoModel.areaStr = [NSString getResultStrBySeverStr:self.amendingInfoModel.areaStr];
    
    self.amendingInfoModel.jobExperienceStr = [NSString getResultStrBySeverStr:self.amendingInfoModel.jobExperienceStr];
    NSLog(@"请求之前答应选择的技术self.amendingInfoModel.technologyServiceNeedStr = %@ ,jobstr = %@",self.amendingInfoModel.technologyServiceNeedStr,self.amendingInfoModel.jobServiceNeedStr);
    //;
    //self.amendingInfoModel.technologyServiceNeedStr = @"1,2,3,4,5,6,7,8,40,41,42,43";
//    self.amendingInfoModel.jobServiceNeedStr = @"1,2,3,4,5,6,8,16";
    //
    NSDictionary *paraDict = @{@"realName":self.amendingInfoModel.nameStr,@"realNamePath":@"",
                               @"age":self.amendingInfoModel.ageNum,@"gender":self.amendingInfoModel.sexStr,
                               @"province":self.amendingInfoModel.proviceStr,@"city":self.amendingInfoModel.cityStr,
                               @"area":self.amendingInfoModel.areaStr,@"address":@"",
                               @"technologys":self.amendingInfoModel.technologyServiceNeedStr,@"professionals":self.amendingInfoModel.jobServiceNeedStr,
//                               @"technologyShowPic":self.amendingInfoModel.technologyPicSeviceNeedStr,@"technologyShowVideo":self.amendingInfoModel.technologyVideoSeviceNeedStr,
                               @"userId":[lzhGetAccountInfo getAccount].userID,@"headImg":@"",
                               @"mobile":@"",@"workExperience":self.amendingInfoModel.jobExperienceStr,
                               @"workExperiencePath":@""
                                   };
    [TDHttpTools casualChangeOwnInfo:paraDict success:^(id response) {
        NSLog(@"修改个人信息%@",response);
        NSDictionary *webDict = response;
        [SVProgressHUD showSuccessWithStatus:webDict[@"msg"]];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}


//弹窗
- (void)showPopView{
    UIWindow *appWindow = APP_MAIN_WINDOW;
    if (nil == popView){
        popbackButt = [UIButton buttonWithType:UIButtonTypeCustom];
        popbackButt.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        popbackButt.backgroundColor = [UIColor grayColor];
        popbackButt.alpha = POP_VIEW_ALPHA;
        [popbackButt addTarget:self action:@selector(popBackButtHandler) forControlEvents:UIControlEventTouchUpInside];
        [appWindow addSubview:popbackButt];
        popView = [[CommitPopView alloc]initWithFrame:CGRectMake(0, 0, 194, 223)];
        popView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT  / 2);
        [appWindow addSubview:popView];
        WS(weakSelf);
        popView.sureBlock = ^{
            __strong typeof(weakSelf)sself = weakSelf;
            [sself -> popbackButt setHidden:YES];
            [sself -> popView setHidden:YES];
            [weakSelf.navigationController setNavigationBarHidden:YES];
            [weakSelf.rdv_tabBarController setTabBarHidden:NO];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            //[weakSelf.rdv_tabBarController setSelectedIndex:4];
            
        };
    }else{
        [popbackButt setHidden:NO];
        [popView setHidden:NO];
    }
}

- (void)popBackButtHandler{
    [popbackButt setHidden:YES];
    [popView setHidden:YES];
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
