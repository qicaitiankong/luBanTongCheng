//
//  LaunchPiesViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "LaunchPiesViewController.h"
//
#import "PersonalInfoTechnologyChooseViewController.h"
//
#import "ChooseTechnologyLeftModel.h"
#import "OwnPersonalInfoModel.h"
//
#import "LaunchPiesTicketInputNameView.h"
#import "LaunchPiesTicketChooseJobView.h"
#import "LaunchPiesTicketYuSuanView.h"
#import "OwnTextView.h"
#import "CommitPopView.h"
#import "OwnPersonalInfoSectionView.h"

#import "OwnPersonalInfoSelectPictureCellTableViewCell.h"

//third
#import "GSPickerView.h"

//组头sub View标记
struct ViewTagStruct {
    int tag1;
    int tag2;
    int tag3;
    int tag4;
    int tag5;
    int tag6;
    int tag7;
};
struct ViewTagStruct viewTag = {0,1,2,3,4,5,6};

@interface LaunchPiesViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIView *topHeaderView;
    //
    NSIndexPath *currentClickpath;
    //点击的图片索引
    NSInteger currentClickIndex;
    //表头里的
    LaunchPiesTicketInputNameView *nameView;
    LaunchPiesTicketInputNameView *mobileView;
    LaunchPiesTicketInputNameView *addressView;
    LaunchPiesTicketChooseJobView *jobKindView;
    LaunchPiesTicketChooseJobView *technologeView;
    LaunchPiesTicketYuSuanView *yuSuanView;
    LaunchPiesTicketChooseJobView *timeChooseView;
    LaunchPiesTicketInputNameView *beiZhuView;
    OwnTextView *beiZhuTextView ;
    //
    CommitPopView *popView;
    UIButton *popbackButt;
    UIView *commitButtBaseView;
    OwnPersonalInfoSectionView *firstSectionView;
    OwnPersonalInfoSectionView *secondSectionView;
}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) OwnPersonalInfoChoosePictureModel *videoModel;

@property (strong,nonatomic) OwnPersonalInfoChoosePictureModel *pictureModel;

//是否是替换图片
@property (assign,nonatomic) BOOL isInsteadPicture;


//表头信息
@property (strong,nonatomic) NSString *selectedJobStr;

@property (strong,nonatomic) NSString *selectedTechnoStr;

@property (strong,nonatomic) GetLocationICitynfo *locationInfo;

@property (strong,nonatomic) GSPickerView *pickerView;
//
@property (strong,nonatomic) NSString *selectedTimeStr;

//
@end

@implementation LaunchPiesViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     self.title = @"发起派单";
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    //图片选取回调
    WS(weakSelf);
    self.selectedImageBlock = ^(NSData *pictureData, UIImage *selectedPicture) {
        [weakSelf setPictureWhenChooseCpmplete:pictureData image:selectedPicture];
    };
    //
    [self initOwnobjects];
    //
    [self hiddenXuanFuButt];
    
    [self crateHeaderView];
    
    [self createCommitButt];
    //
    [self addTableView];
}

- (void)initOwnobjects{
    self.videoModel = [[OwnPersonalInfoChoosePictureModel alloc]init];
    self.pictureModel = [[OwnPersonalInfoChoosePictureModel alloc]init];
    self.selectedJobStr = @"";
    self.selectedTechnoStr = @"";
    self.selectedTimeStr = @"";
    self.locationInfo = [GetLocationICitynfo getLocationInfo];
}

-(void)lauchOrder{
    
    NSInteger yuSuanMoney = 0;
    NSString *mobileStr =    mobileView.rightTextField.myTextField.text;
     NSString *nameStr =    nameView.rightTextField.myTextField.text;
    NSString *addressStr =    addressView.rightTextView.writeTextView.text;
    NSString *beiZhuStr =   [NSString getResultStrBySeverStr:beiZhuTextView.writeTextView.text] ;
    NSString *yuSuanMoneyStr =  yuSuanView.rightTextField.myTextField.text;
    //
    if (nameStr.length == 0){
        [SVProgressHUD showInfoWithStatus:@"请输入称呼"];
        return;
    }
    if (mobileStr.length == 0){
        [SVProgressHUD showInfoWithStatus:@"请输入手机号码"];
        return;
    }
    
    if (addressStr.length == 0){
        [SVProgressHUD showInfoWithStatus:@"请输入地址"];
        return;
    }
    if (self.selectedJobStr.length == 0){
        [SVProgressHUD showInfoWithStatus:@"请选择工作类型"];
        return;
    }
    if (self.selectedTechnoStr.length == 0){
        [SVProgressHUD showInfoWithStatus:@"请选择技能"];
        return;
    }
    //
    if (yuSuanMoneyStr.length != 0){
        yuSuanMoney = [yuSuanMoneyStr integerValue];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请输入金额"];
        return;
    }
    
    if (self.selectedTimeStr.length == 0){
        [SVProgressHUD showInfoWithStatus:@"请选择时间"];
        return;
    }
    NSLog(@"打印称呼 nameStr=%@",nameStr);
    NSDictionary *paraDict = @{@"userName":nameStr,@"mobile":mobileStr,@"provinceName":self.locationInfo.provinceStr,@"cityName":self.locationInfo.cityStr,@"areaName":self.locationInfo.areaStr,@"address":addressStr,@"technologys":self.selectedTechnoStr,@"professional":self.selectedJobStr,@"toDoorTime":self.selectedTimeStr,@"remark":beiZhuStr,@"budget":[NSNumber numberWithInteger:yuSuanMoney]};
    
    NSLog(@"/////选择的图片%ld",self.pictureModel.selectedDataArr.count);
    [TDHttpTools launchOder:paraDict pictureDataArr:self.pictureModel.selectedDataArr success:^(id response) {
        int status = [response[@"status"] intValue];
        if (status == 0){
            [self showPopView];
        }else if (status == 1){
            [SVProgressHUD showInfoWithStatus:response[@"msg"]];
        }
    } failure:^(NSError *error) {

    }];
}
//
- (void)clickTextField:(UITextField*)textField{
    WS(weakSelf);
    switch (textField.tag) {
        case 3:{
            PersonalInfoTechnologyChooseViewController *chooseTechNoLogy = [[PersonalInfoTechnologyChooseViewController alloc]init];
            chooseTechNoLogy.kindTag = 2;
            chooseTechNoLogy.selectedBlock = ^(NSMutableArray *modelArr) {
                __strong typeof(weakSelf) sself = weakSelf;
                NSMutableArray *resultStrArr = [[NSMutableArray alloc]init];
                NSMutableArray *resultIDArr = [[NSMutableArray alloc]init];
                for (ChooseTechnologyLeftModel *model in modelArr){
                    [resultStrArr addObject:[NSString stringWithFormat:@"%@",model.title]];
                    [resultIDArr addObject:[NSString stringWithFormat:@"%ld",model.idFlag]];
                }
                NSString *resultStr = [resultStrArr componentsJoinedByString:@","];
                sself -> jobKindView.rightTextField.myTextField.text = resultStr;
                weakSelf.selectedJobStr = [resultIDArr componentsJoinedByString:@","];
            };
            [self.navigationController pushViewController:chooseTechNoLogy animated:YES];
        }
            break;
        case 4:{//技能
            PersonalInfoTechnologyChooseViewController *chooseTechNoLogy = [[PersonalInfoTechnologyChooseViewController alloc]init];
            chooseTechNoLogy.kindTag = 1;
            chooseTechNoLogy.selectedBlock = ^(NSMutableArray *modelArr) {
                __strong typeof(weakSelf) sself = weakSelf;
                NSMutableArray *resultStrArr = [[NSMutableArray alloc]init];
                NSMutableArray *resultIDArr = [[NSMutableArray alloc]init];
                for (ChooseTechnologyLeftModel *model in modelArr){
                    [resultStrArr addObject:[NSString stringWithFormat:@"%@",model.title]];
                    [resultIDArr addObject:[NSString stringWithFormat:@"%ld",model.idFlag]];
                }
                NSString *resultStr = [resultStrArr componentsJoinedByString:@","];
                sself -> technologeView.rightTextField.myTextField.text = resultStr;
                weakSelf.selectedTechnoStr = [resultIDArr componentsJoinedByString:@","];
            };
            [self.navigationController pushViewController:chooseTechNoLogy animated:YES];
        }
            break;
        case 6:{
            [self addChooseTimeView];
        }
            break;
        default:
            break;
    }
}

- (void)addPicture:(NSIndexPath*)path index:(NSInteger)clickIndex{
    //WS(weakSelf);
    currentClickpath = path;
    currentClickIndex = clickIndex;
    NSLog(@"点击选取图片path.section=%ld",path.section);
    UIImage *singleImage = nil;
    if (path.section == 1){
        if (self.videoModel.selectedImageArr.count > clickIndex){
            singleImage = self.videoModel.selectedImageArr[clickIndex];
        }
    }else{
        if (self.pictureModel.selectedImageArr.count > clickIndex){
            singleImage = self.pictureModel.selectedImageArr[clickIndex];
        }
    }
    //没图片只能选择
    if (singleImage == nil){
        self.isInsteadPicture = NO;
        [self callActionSheetFunc];
    }else{//要替换或删除
        [self callActionSheetWithChangeStyleFunc:^{//删除图片
            self.isInsteadPicture = NO;
            [self dealDeletePicture:path index:clickIndex];
        } insteadBlock:^{//替换图片
            self.isInsteadPicture = YES;
        }];
    }
}

//处理删除
- (void)dealDeletePicture:(NSIndexPath*)path index:(NSInteger)clickIndex{
    if (path.section == 1 && (self.videoModel.selectedImageArr.count > clickIndex)){
        [self.videoModel.selectedDataArr removeObjectAtIndex:clickIndex];
        [self.videoModel.selectedImageArr removeObjectAtIndex:clickIndex];
       
    }
    if(path.section == 3 && (self.pictureModel.selectedImageArr.count > clickIndex)){
        [self.pictureModel.selectedDataArr removeObjectAtIndex:clickIndex];
        [self.pictureModel.selectedImageArr removeObjectAtIndex:clickIndex];
    }
    [self.tableView reloadData];
}

- (void)setPictureWhenChooseCpmplete:(NSData *)pictureBase64str image:(UIImage *)selectedPicture{
    //进入该方法的肯定是新加的图片
    NSLog(@"添加视频或图片");
    if (currentClickpath.section == 1){//添加视频
        if(self.isInsteadPicture){
            //替换
            [self.videoModel.selectedImageArr replaceObjectAtIndex:currentClickIndex withObject:selectedPicture];
            [self.videoModel.selectedDataArr replaceObjectAtIndex:currentClickIndex withObject:pictureBase64str];
        }else{
            [self.videoModel.selectedImageArr addObject:selectedPicture];
            [self.videoModel.selectedDataArr addObject:pictureBase64str];
        }
        
    }else{//图片
        if(self.isInsteadPicture){
            //替换
            [self.pictureModel.selectedImageArr replaceObjectAtIndex:currentClickIndex withObject:selectedPicture];
            [self.pictureModel.selectedDataArr replaceObjectAtIndex:currentClickIndex withObject:pictureBase64str];
           
            
        }else{
            [self.pictureModel.selectedImageArr addObject:selectedPicture];
            [self.pictureModel.selectedDataArr addObject:pictureBase64str];
        }
    }
    //刷新布局
    [self.tableView reloadData];
}

//
- (void)addTableView{
    //
    firstSectionView = [[OwnPersonalInfoSectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 40) image:[UIImage imageNamed:@"videoFlag"] title:@"添加视频"];
    //
    secondSectionView = [[OwnPersonalInfoSectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 40) image:[UIImage imageNamed:@"photoFlag"] title:@"添加图片"];
    secondSectionView.rightTopTipLabel.hidden = YES;
    //
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = topHeaderView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
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
            cell.addPictureBlock = ^(NSIndexPath *path, NSInteger clickIndex) {
                [weakSelf addPicture:path index:clickIndex];
            };
        }
        cell.path = indexPath;
        cell.model = self.videoModel;
        parentCell = cell;
    }else if (indexPath.section == 3){
        static NSString *cellFlag2 = @"cell2";
        OwnPersonalInfoSelectPictureCellTableViewCell
        *cell2 = [tableView dequeueReusableCellWithIdentifier:cellFlag2];
        if (nil == cell2){
            WS(weakSelf);
            cell2 = [[OwnPersonalInfoSelectPictureCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag2];
            cell2.addPictureBlock = ^(NSIndexPath *path, NSInteger clickIndex) {
                [weakSelf addPicture:path index:clickIndex];
            };
        }
        cell2.path = indexPath;
        cell2.model = self.pictureModel;
        parentCell = cell2;
    }
    
    
    return parentCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if (indexPath.section == 1){
        height = [tableView cellHeightForIndexPath:indexPath model:self.videoModel keyPath:@"model" cellClass:[OwnPersonalInfoSelectPictureCellTableViewCell class] contentViewWidth:SCREEN_WIDTH];
    }else if (indexPath.section == 3){
        height = [tableView cellHeightForIndexPath:indexPath model:self.pictureModel keyPath:@"model" cellClass:[OwnPersonalInfoSelectPictureCellTableViewCell class] contentViewWidth:SCREEN_WIDTH];
    }
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = nil;
    switch (section) {
        case 0:
            sectionView = firstSectionView;
            break;
        case 1:
            break;
        case 2:
            sectionView = secondSectionView;
            break;
        case 3:
            break;
        case 4:
            sectionView = commitButtBaseView;
            break;
        default:
            break;
    }
    return sectionView;
}

//
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    switch (section) {
        case 0:
            height = firstSectionView.height;
            break;
        case 1:
            break;
        case 2:
            height = secondSectionView.height;
            break;
        case 3:
            break;
        case 4:
            height = commitButtBaseView.height;
            break;
        default:
            break;
    }
    return height;
}


//
- (void)crateHeaderView{
    WS(weakSelf);
    //
    CGFloat groupViewVerticalSpace = 10;
    CGFloat singleViewHeight = 50;
   //
    topHeaderView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, self.view.width, 10)];
    topHeaderView.backgroundColor = [UIColor colorWithHexString:@"#DADADA"];
    //
    nameView = [[LaunchPiesTicketInputNameView alloc]initWithFrame:CGRectMake(0, groupViewVerticalSpace, self.view.width,singleViewHeight) needRightMapButt:NO];
    nameView.nameLabel.text = @"称呼";
    nameView.rightTextField.myTextField.tag = viewTag.tag1;
    nameView.rightTextField.myTextField.placeholder = @"请输入称呼";
    [nameView addOwnConstraints:[UIImage imageNamed:@"name"]];
    [topHeaderView addSubview:nameView];
    //
    mobileView = [[LaunchPiesTicketInputNameView alloc]initWithFrame:CGRectMake(0, nameView.bottom, self.view.width,singleViewHeight) needRightMapButt:NO];
    mobileView.nameLabel.text = @"电话";
    mobileView.rightTextField.myTextField.placeholder = @"请输入电话";
    mobileView.rightTextField.myTextField.tag = viewTag.tag2;
    [mobileView addOwnConstraints:[UIImage imageNamed:@"ticket_mobile"]];
    [topHeaderView addSubview:mobileView];
    //
    addressView = [[LaunchPiesTicketInputNameView alloc]initWithFrame:CGRectMake(0, mobileView.bottom, self.view.width,singleViewHeight + 30) needRightMapButt:YES];
    addressView.nameLabel.text = @"地址";
    addressView.rightTextField.myTextField.tag = viewTag.tag3;
    addressView.rightTextField.myTextField.placeholder = @"请输入地址";
    addressView.rightTextView.writeTextView.text = [NSString stringWithFormat:@"%@%@%@%@",self.locationInfo.provinceStr,self.locationInfo.cityStr,self.locationInfo.areaStr,self.locationInfo.detailStreetStr];
    //返回地图选择
    addressView.mapChooseButtView.clickButtBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [topHeaderView addSubview:addressView];
     [addressView addOwnConstraints:[UIImage imageNamed:@"ticket_address"]];
    //
    UIView *addressBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, addressView.bottom, self.view.width, 15)];
    addressBottomView.backgroundColor = [UIColor whiteColor];
    [topHeaderView addSubview:addressBottomView];
    //工作类型
    jobKindView = [[LaunchPiesTicketChooseJobView alloc]initWithFrame:CGRectMake(0,addressBottomView.bottom + groupViewVerticalSpace, self.view.width,singleViewHeight)];
    jobKindView.rightTextField.myTextField.tag = viewTag.tag4;
    [jobKindView addOwnConstraints:[UIImage imageNamed:@"ticket_jobKind"]];
    jobKindView.ageLabel.text = @"工作类型";
    jobKindView.rightTextField.myTextField.placeholder = @"请选择";
    jobKindView.backButtBlock = ^(UITextField *textField) {
        [weakSelf clickTextField:textField];
    };
    [topHeaderView addSubview:jobKindView];
    //技能要求
    technologeView = [[LaunchPiesTicketChooseJobView alloc]initWithFrame:CGRectMake(0,jobKindView.bottom, self.view.width,singleViewHeight)];
    [technologeView addOwnConstraints:[UIImage imageNamed:@"tecnology"]];
    technologeView.rightTextField.myTextField.tag = viewTag.tag5;
    technologeView.ageLabel.text = @"技能要求";
    technologeView.rightTextField.myTextField.placeholder = @"请选择";
    technologeView.backButtBlock = ^(UITextField *textField) {
        [weakSelf clickTextField:textField];
    };
    [topHeaderView addSubview:technologeView];
    //
    yuSuanView = [[LaunchPiesTicketYuSuanView alloc]initWithFrame:CGRectMake(0,technologeView.bottom, self.view.width,singleViewHeight)];
    [yuSuanView addOwnConstraints:[UIImage imageNamed:@"ticket_yuSuan"]];
    yuSuanView.rightTextField.myTextField.tag = viewTag.tag6;
    yuSuanView.nameLabel.text = @"预算";
    [topHeaderView addSubview:yuSuanView];
    //
    UIView *yuSuanBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, yuSuanView.bottom, self.view.width, 15)];
    yuSuanBottomView.backgroundColor = [UIColor whiteColor];
    [topHeaderView addSubview:yuSuanBottomView];
    //
    timeChooseView = [[LaunchPiesTicketChooseJobView alloc]initWithFrame:CGRectMake(0,yuSuanBottomView.bottom + groupViewVerticalSpace, self.view.width,singleViewHeight)];
    [timeChooseView addOwnConstraints:[UIImage imageNamed:@"ticket_time"]];
    timeChooseView.rightTextField.myTextField.tag = viewTag.tag7;
    timeChooseView.backButtBlock = ^(UITextField *textField) {
        [weakSelf clickTextField:textField];
    };
    timeChooseView.ageLabel.text = @"上门时间";
    timeChooseView.rightTextField.myTextField.placeholder = @"请选择";
    [topHeaderView addSubview:timeChooseView];
    //备注
    beiZhuView = [[LaunchPiesTicketInputNameView alloc]initWithFrame:CGRectMake(0,timeChooseView.bottom, self.view.width,singleViewHeight) needRightMapButt:NO];
    beiZhuView.rightTextField.hidden = YES;
    beiZhuView.bottomLineView.hidden = YES;
    [beiZhuView addOwnConstraints:[UIImage imageNamed:@"ticket_beizhu"]];
    beiZhuView.nameLabel.text = @"备注";
    [topHeaderView addSubview:beiZhuView];
    //textview baseview
    UIView *baseTextView = [[UIView alloc]initWithFrame:CGRectMake(0, beiZhuView.bottom, topHeaderView.width, SCREEN_HEIGHT * 0.15)];
    baseTextView.backgroundColor = [UIColor whiteColor];
    [topHeaderView addSubview:baseTextView];
    //textview
    beiZhuTextView = [[OwnTextView alloc]initWithFrame:CGRectMake(35, 0, baseTextView.width - 35 - 10, baseTextView.height * 0.8)];
    beiZhuTextView.backgroundColor = [UIColor whiteColor];
    beiZhuTextView.clipsToBounds = YES;
    beiZhuTextView.layer.borderWidth = 1;
    beiZhuTextView.layer.borderColor = [UIColor colorWithHexString:@"#C6C6C6"].CGColor;
    beiZhuTextView.layer.cornerRadius = 5;
    CGPoint rememberContentOffset = self.tableView.contentOffset;
    //NSLog(@"rememberContentOffset.y = %lf",rememberContentOffset.y);
    beiZhuTextView.keyBoardChangedBlock = ^(CGFloat keyBoardHeight) {
         __strong typeof(weakSelf) sself = weakSelf;
        if([sself -> beiZhuTextView.writeTextView isFirstResponder]){
            CGFloat currentContentOffsetY = weakSelf.tableView.contentOffset.y;
            //CGFloat contentSizeHeight = weakSelf.tableView.contentSize.height;
            //CGFloat offsetY = contentSizeHeight - currentContentOffsetY - (SCREEN_HEIGHT - StatusBarAndNavigationBarHeight - keyBoardHeight);
            //NSLog(@"offsetY = %lf",offsetY);
            if (currentContentOffsetY >= 0){
                weakSelf.tableView.contentOffset = CGPointMake(rememberContentOffset.x, 280);
            }
        }
       
    };
    beiZhuTextView.keyBoardExistBlock = ^{
        
            weakSelf.tableView.contentOffset = rememberContentOffset;
        
    };
    [baseTextView addSubview:beiZhuTextView];
    
    [topHeaderView setFrame:CGRectMake(0, 0, self.view.width, baseTextView.bottom + 10)];
    
}

- (void)createCommitButt{
    WS(weakSelf);
    //提交基view
     commitButtBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT * 0.112)];
    commitButtBaseView.backgroundColor = [UIColor whiteColor];
    //
    UIColor *commitButtBackColor = SPECIAL_BLUE_COLOR;
    CustomeStyleCornerButt *commitButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(0, 0, commitButtBaseView.width - 20, commitButtBaseView.height * 0.6) backColor:commitButtBackColor cornerRadius:8 title:@"提交" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:18]];
    commitButt.center = CGPointMake(commitButtBaseView.width / 2, commitButtBaseView.height / 2);
    commitButt.clickButtBlock = ^{
        [weakSelf lauchOrder];
        
    };
    [commitButtBaseView addSubview:commitButt];
    //
}


//
- (GSPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[GSPickerView alloc]initWithFrame:self.view.bounds];
    }
    return _pickerView;
}

- (void)addChooseTimeView{
    WS(weakSelf);
    [self.pickerView appearWithTitle:@"" pickerType:GSPickerTypeDatePicker subTitles:nil selectedStr:@"2010-1-1" sureAction:^(NSInteger path, NSString *pathStr) {
        NSLog(@"%@",pathStr);
        __strong typeof(weakSelf) sself = weakSelf;
        weakSelf.selectedTimeStr = [pathStr copy];
        sself -> timeChooseView.rightTextField.myTextField.text = weakSelf.selectedTimeStr;
    } cancleAction:^{
        
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
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidScroll %lf",scrollView.contentOffset.y);
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
