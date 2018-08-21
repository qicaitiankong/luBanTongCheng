//
//  PersonalInfoVideoViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "PersonalInfoVideoViewController.h"

#import "OwnPersonalInfomationViewController.h"
//v
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
    //点击的图片索引
    NSInteger currentClickIndex;
}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) OwnPersonalInfoChoosePictureModel *videoModel;

@property (strong,nonatomic) OwnPersonalInfoChoosePictureModel *pictureModel;
//需要删除的的图片id字符串数组
@property (strong,nonatomic) NSMutableArray *needDeleteTecPicIdStrArr;
//需要删除的的视频id字符串数组
@property (strong,nonatomic) NSMutableArray *needDeleteTecVideoIdStrArr;
//新增加的图片数组
@property (strong,nonatomic) NSMutableArray *IncreasedNewPictureDataArr;
//新增加的video数组
@property (strong,nonatomic) NSMutableArray *IncreasedNewVideoDataArr;

//是否是替换图片
@property (assign,nonatomic) BOOL isInsteadPicture;

@end

@implementation PersonalInfoVideoViewController

- (NSMutableArray*)needDeleteTecPicIdStrArr{
    if (_needDeleteTecPicIdStrArr == nil){
        _needDeleteTecPicIdStrArr = [NSMutableArray array];
    }
    return _needDeleteTecPicIdStrArr;
}

- (NSMutableArray*)needDeleteTecVideoIdStrArr{
    if (_needDeleteTecVideoIdStrArr == nil){
        _needDeleteTecVideoIdStrArr = [NSMutableArray array];
    }
    return _needDeleteTecVideoIdStrArr;
}

- (NSMutableArray*)IncreasedNewPictureDataArr{
    if (_IncreasedNewPictureDataArr == nil){
        _IncreasedNewPictureDataArr = [NSMutableArray array];
    }
    return _IncreasedNewPictureDataArr;
}

- (NSMutableArray*)IncreasedNewVideoDataArr{
    if (_IncreasedNewVideoDataArr == nil){
        _IncreasedNewVideoDataArr = [NSMutableArray array];
    }
    return _IncreasedNewVideoDataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavStyle];
    
    //图片选取回调
    WS(weakSelf);
    self.selectedImageBlock = ^(NSData *pictureData, UIImage *selectedPicture) {
        [weakSelf setPictureWhenChooseCpmplete:pictureData image:selectedPicture];
        
    };

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
}

- (void)leftBarButt{
        [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBarButt{
   
}

- (void)initOwnObjects{
    self.videoModel = [[OwnPersonalInfoChoosePictureModel alloc]init];
    self.pictureModel = [[OwnPersonalInfoChoosePictureModel alloc]init];
    //通过网络请求下载图片保存到模型里面展示
    NSMutableArray *tecnologePicArr = [NSArray getTargetArr:self.amendingInfoModel.pictureInfoArr keyStr:@"filePath"];
    if(tecnologePicArr.count){
        [[ShareNetWorkState ShareNetState] asynSerialDownload:tecnologePicArr downloadCompleteHandler:@selector(addPictureToPictureModel:) target:self modelIndex:1];
        //
    }
    NSArray *tecnologeVideoPicArr = [NSArray getTargetArr:self.amendingInfoModel.videoInfoArr keyStr:@"filePath"];
    if (tecnologeVideoPicArr.count){
        [[ShareNetWorkState ShareNetState] asynSerialDownload:tecnologeVideoPicArr downloadCompleteHandler:@selector(addPictureToVideoModel:) target:self modelIndex:2];
    }
    
}


- (void)addPictureToPictureModel:(NSDictionary*)dict{
    //@{@"modelIndex":[NSNumber numberWithInteger:index],@"imageData":data}
    NSData *imageData = [dict[@"imageData"] copy];
    UIImage *image = [UIImage imageWithData:imageData];
    [self.pictureModel.selectedImageArr addObject:image];
    [self.pictureModel.selectedDataArr addObject:imageData];
    [self.tableView reloadData];
}

- (void)addPictureToVideoModel:(NSDictionary*)dict{
    //@{@"modelIndex":[NSNumber numberWithInteger:index],@"imageData":data}
    NSData *imageData = [dict[@"imageData"] copy];
    UIImage *image = [UIImage imageWithData:imageData];
    [self.videoModel.selectedImageArr addObject:image];
    [self.videoModel.selectedDataArr addObject:imageData];
    [self.tableView reloadData];
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
         if (self.IncreasedNewVideoDataArr.count > currentClickIndex){
             [self.IncreasedNewVideoDataArr removeObjectAtIndex:currentClickIndex];
         }
        if(self.amendingInfoModel.videoInfoArr.count > clickIndex){//确保被删除图片不是新增加的
            NSDictionary *pictureInfoDict =  [self.amendingInfoModel.videoInfoArr[clickIndex] copy];
            NSNumber *deletePicIdNum = pictureInfoDict[@"fileId"];
            [self.needDeleteTecVideoIdStrArr addObject:[deletePicIdNum stringValue]];
        }
    }
    if(path.section == 3 && (self.pictureModel.selectedImageArr.count > clickIndex)){
        [self.pictureModel.selectedDataArr removeObjectAtIndex:clickIndex];
        [self.pictureModel.selectedImageArr removeObjectAtIndex:clickIndex];
        if (self.IncreasedNewPictureDataArr.count > currentClickIndex){
            [self.IncreasedNewPictureDataArr removeObjectAtIndex:currentClickIndex];
        }
         if(self.amendingInfoModel.pictureInfoArr.count > clickIndex){//确保被删除图片不是新增加的
            NSDictionary *pictureInfoDict =  [self.amendingInfoModel.pictureInfoArr[clickIndex] copy];
            NSNumber *deletePicIdNum = pictureInfoDict[@"fileId"];
            [self.needDeleteTecPicIdStrArr addObject:[deletePicIdNum stringValue]];
         }
    }
    [self.tableView reloadData];
}

//替换此方法是为了得到被替换的图片的id,如果被替换图片没有id(是新选择的)，则加入空字符串，最后在网络请求前去除空字符串再去重
- (void)insteadPicture:(NSIndexPath*)path index:(NSInteger)clickIndex{
    //先记下来被替换图片的id然后再覆盖
    //视屏
    if (path.section == 1 && (self.videoModel.selectedImageArr.count > clickIndex)){
        
            if(self.amendingInfoModel.videoInfoArr.count > clickIndex){//确保被替换图片不是新增加的
                NSDictionary *pictureInfoDict =  [self.amendingInfoModel.videoInfoArr[clickIndex] copy];
                NSNumber *deletePicIdNum = pictureInfoDict[@"fileId"];
                [self.needDeleteTecVideoIdStrArr addObject:[deletePicIdNum stringValue]];
            }else{
                 [self.needDeleteTecVideoIdStrArr addObject:@""];
            }
    }
    //图片
    if(path.section == 3 && (self.pictureModel.selectedImageArr.count > clickIndex)){
         if(self.amendingInfoModel.pictureInfoArr.count > clickIndex){//确保被替换图片不是新增加的
            NSDictionary *pictureInfoDict =  [self.amendingInfoModel.pictureInfoArr[clickIndex] copy];
            NSNumber *deletePicIdNum = pictureInfoDict[@"fileId"];
            [self.needDeleteTecPicIdStrArr addObject:[deletePicIdNum stringValue]];
         }else{
              [self.needDeleteTecPicIdStrArr addObject:@""];
         }
    }
}




- (void)setPictureWhenChooseCpmplete:(NSData *)pictureBase64str image:(UIImage *)selectedPicture{
    //进入该方法的肯定是新加的图片
    NSLog(@"添加视频或图片");
    if (currentClickpath.section == 1){//添加视频
        if(self.isInsteadPicture){
            //必须先记录被替换的图片id，然后再替换
             [self insteadPicture:currentClickpath index:currentClickIndex];
            //替换
            [self.videoModel.selectedImageArr replaceObjectAtIndex:currentClickIndex withObject:selectedPicture];
            [self.videoModel.selectedDataArr replaceObjectAtIndex:currentClickIndex withObject:pictureBase64str];
            [self.IncreasedNewVideoDataArr replaceObjectAtIndex:currentClickIndex withObject:pictureBase64str];
        }else{
            [self.videoModel.selectedImageArr addObject:selectedPicture];
            [self.videoModel.selectedDataArr addObject:pictureBase64str];
             [self.IncreasedNewVideoDataArr addObject:pictureBase64str];
        }
        
    }else{//图片
        if(self.isInsteadPicture){
            //必须先记录被替换的图片id，然后再替换
            [self insteadPicture:currentClickpath index:currentClickIndex];
            //替换
            [self.pictureModel.selectedImageArr replaceObjectAtIndex:currentClickIndex withObject:selectedPicture];
            [self.pictureModel.selectedDataArr replaceObjectAtIndex:currentClickIndex withObject:pictureBase64str];
                [self.IncreasedNewPictureDataArr addObject: pictureBase64str];
            
        }else{
            [self.pictureModel.selectedImageArr addObject:selectedPicture];
            [self.pictureModel.selectedDataArr addObject:pictureBase64str];
            [self.IncreasedNewPictureDataArr addObject:pictureBase64str];
        }
    }
    //刷新布局
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
            sectionView = completeView;
            break;
        default:
            break;
    }
    return sectionView;
}

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
            height = completeView.height;
            break;
        default:
            break;
    }
    return height;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)createCompleteViews{
    completeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
        CustomeStyleCornerButt *nextButt = [[CustomeStyleCornerButt alloc] initWithFrame:CGRectMake(0, 0, completeView.width * 0.9, NEXT_BUTT_HEIGHT) backColor:[UIColor colorWithHexString:@"#78CAC5"] cornerRadius:4 title:@"完成" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:18]];
        nextButt.center = CGPointMake(completeView.width  / 2, completeView.height / 2);
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
//    NSLog(@"请求之前答应选择的技术图片：self.pictureModel.selectedImageBaseStrArr = %@ ,jobstr = %@ 性别:%@",self.pictureModel.selectedImageBaseStrArr,self.videoModel.selectedImageBaseStrArr,self.amendingInfoModel.sexStr);
      NSLog(@"修改个人信息提交前答应提交新增加图片数组self.IncreasedNewPictureDataArrcont=%ld\n, self.needDeleteTecPicIdStrArr=%@\n self.IncreasedNewVideoDataArr.count=%ld\n self.needDeleteTecVideoIdStrArr=%@\n",self.IncreasedNewPictureDataArr.count,self.needDeleteTecPicIdStrArr,self.IncreasedNewVideoDataArr.count,self.needDeleteTecVideoIdStrArr
            );
    //图片和视屏要传新增加的或修改的,self.IncreasedNewPictureDataArr然后通过上传多张file类型图片操作
    //要修改删除的图片或视屏id str 拼接
    NSString *needDeletePicStr = [self.needDeleteTecPicIdStrArr componentsJoinedByString:@","];
    NSString *needDeleteVideoStr = [self.needDeleteTecVideoIdStrArr componentsJoinedByString:@","];
    NSLog(@"打印工作经历:%@",self.amendingInfoModel.jobExperienceStr);
    //
    NSDictionary *paraDict = @{@"realName":self.amendingInfoModel.nameStr,@"realNamePath":@"",
                               @"age":self.amendingInfoModel.ageNum,@"gender":self.amendingInfoModel.sexStr,
                               @"province":self.amendingInfoModel.proviceStr,@"city":self.amendingInfoModel.cityStr,
                               @"area":self.amendingInfoModel.areaStr,@"address":@"",@"gender":self.amendingInfoModel.sexStr,
                               @"technologys":self.amendingInfoModel.technologyServiceNeedStr,@"professionals":self.amendingInfoModel.jobServiceNeedStr,@"delFileIds":needDeletePicStr,
                               @"userId":[lzhGetAccountInfo getAccount].userID,
                               @"mobile":@"",@"workExperience":self.amendingInfoModel.jobExperienceStr,
                               @"workExperiencePath":@""
                                   };
    
    
  
    [TDHttpTools capsualChangeOwnInfo:paraDict traileUrlStr:@"/lubantc/api/user/updateWorkerInfo" imageFlagNameArr:@[@"technologyPic"] picDataArr:self.IncreasedNewPictureDataArr soundNameData:self.amendingInfoModel.nameSoundAmrData soundExperienceData:self.amendingInfoModel.workExperienceAmrData videoDataArr:self.IncreasedNewVideoDataArr success:^(id response) {
        NSLog(@"修改个人信息%@",response);
        NSDictionary *webDict = response;
        NSInteger status = [webDict[@"status"] integerValue];
        if(status == 0){
             [SVProgressHUD showSuccessWithStatus:webDict[@"msg"]];
            [self.navigationController popToRootViewControllerAnimated:YES];
            //
            [[NSNotificationCenter defaultCenter] postNotificationName:PERSONAL_REFRESH_NOTI object:[OwnPersonalInfomationViewController class] userInfo:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:webDict[@"msg"]];
        }
       
        
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
