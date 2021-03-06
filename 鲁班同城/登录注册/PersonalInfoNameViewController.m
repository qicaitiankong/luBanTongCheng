//
//  PersonalInfoNameViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "PersonalInfoNameViewController.h"
//
#import "PersonalInfoWorkViewController.h"
//v
#import "PersonalInfoInputAgeView.h"
#import "PersonalInfoExchangeViceTextView.h"
#import "CustomeStyleCornerButt.h"
#import "PersonalInfoInputNameView.h"

#import "YAddressPickerView.h"
#import "THChooseSexView.h"
#import "THScrollChooseView.h"

@interface PersonalInfoNameViewController ()<AddressViewDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate>{
    PersonalInfoInputNameView *nameView;
    UIScrollView *baseScrollView;
    UITextField *addressTextField;
    UITextField *sexTextField;
    UITextField *ageTextField;
    RecordAndPlaySound *dealRecordPlaySound;
}
//修改信息存储模型
@property (strong,nonatomic) OwnPersonalInfoModel *amendingInfoModel;

@property (nonatomic, strong) YAddressPickerView *addressView;

@property (strong,nonatomic) NSMutableArray *ageArr;

@end

@implementation PersonalInfoNameViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf);
    //语音对象
    dealRecordPlaySound = [[RecordAndPlaySound alloc]init:self plyerDelegate:self];
    
    self.leftBarbuttBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self addViews];
    //
    [self initAmendModel];
    //
    _addressView = [[YAddressPickerView alloc]init];
    _addressView.delegate = self;
    [self.view addSubview:_addressView];
   
}

- (void)initAmendModel{
    //将原始数据模型里面的数据拷贝一份
    //基本信息
     self.amendingInfoModel = [[OwnPersonalInfoModel alloc]init];
    
    self.amendingInfoModel.nameStr = [NSString getResultStrBySeverStr:self.orinalInfoModel.nameStr];
  
    if(self.orinalInfoModel.ageNum == nil){
        self.amendingInfoModel.ageNum = [NSNumber numberWithInteger:0];
    }else{
          self.amendingInfoModel.ageNum = [self.orinalInfoModel.ageNum copy];
    }
    self.amendingInfoModel.sexStr = [NSString getResultStrBySeverStr:self.orinalInfoModel.sexStr];
    self.amendingInfoModel.mobileStr = [NSString getResultStrBySeverStr:self.orinalInfoModel.mobileStr];
    self.amendingInfoModel.introduceStr =  [NSString getResultStrBySeverStr:self.orinalInfoModel.introduceStr];
    
    //地址工作信息
    self.amendingInfoModel.proviceStr =  [NSString getResultStrBySeverStr:self.orinalInfoModel.proviceStr];
    self.amendingInfoModel.cityStr =  [NSString getResultStrBySeverStr:self.orinalInfoModel.cityStr];
    self.amendingInfoModel.areaStr =  [NSString getResultStrBySeverStr:self.orinalInfoModel.areaStr];
    self.amendingInfoModel.technologyStr =   [NSString getResultStrBySeverStr:self.orinalInfoModel.technologyStr];
    self.amendingInfoModel.jobStr =   [NSString getResultStrBySeverStr:self.orinalInfoModel.jobStr];
    self.amendingInfoModel.jobExperienceStr =  [NSString getResultStrBySeverStr:self.orinalInfoModel.jobExperienceStr];
    NSLog(@"\n\n!!!!!!!!!!!technologyStr%@,!!!!!!!!!%@",self.amendingInfoModel.technologyStr,self.amendingInfoModel.jobStr);
    //技术(传给后台id的格式)
    NSArray *technoArr = [self getTargetServiceneedTechnologyArr:self.orinalInfoModel.technologyArr];
    self.amendingInfoModel.technologyServiceNeedStr = [technoArr componentsJoinedByString:@","];
    //职能(传给后台id的格式)
    NSArray *jobArr = [self getTargetServiceneedTechnologyArr:self.orinalInfoModel.jobArr];
    self.amendingInfoModel.jobServiceNeedStr= [jobArr componentsJoinedByString:@","];
    //视屏和图片展示
    self.amendingInfoModel.pictureInfoArr = [NSArray getOwnCopyArr:self.orinalInfoModel.pictureInfoArr];
    //
    self.amendingInfoModel.videoInfoArr = [NSArray getOwnCopyArr:self.orinalInfoModel.videoInfoArr];
    //语音信息
    self.amendingInfoModel.nameSoundUrlStr =  [NSString getResultStrBySeverStr:self.orinalInfoModel.nameSoundUrlStr];
    self.amendingInfoModel.nameSoundAmrData = [self.orinalInfoModel.nameSoundAmrData copy];
    self.amendingInfoModel.nameSoundData = [self.orinalInfoModel.nameSoundData copy];
    
    self.amendingInfoModel.nameSoundTime = self.orinalInfoModel.nameSoundTime;
    
    //
    self.amendingInfoModel.workExperienceUrlStr =  [NSString getResultStrBySeverStr:self.orinalInfoModel.workExperienceUrlStr];
    self.amendingInfoModel.workExperienceData = [self.orinalInfoModel.workExperienceData copy];
    self.amendingInfoModel.workExperienceAmrData = [self.orinalInfoModel.workExperienceAmrData copy];
    
    self.amendingInfoModel.workExperienceSoundTime = self.orinalInfoModel.workExperienceSoundTime ;
    
}

- (NSMutableArray*)getTargetServiceneedTechnologyArr:(NSArray*)originArr{
    NSMutableArray *localTechnologyArr = [[NSMutableArray alloc]init];
    for (NSDictionary *localDict in originArr){
        NSNumber *idNum = localDict[@"id"];
        [localTechnologyArr addObject:[idNum stringValue]];
    }
    return localTechnologyArr;
}

//性别选择
- (void)chooseSex{
    WS(weakSelf);
    THChooseSexView *sheetView = [[THChooseSexView alloc]initWithTitle:@"" buttons:@[@"男",@"女",@"取消"] buttonClick:^(THChooseSexView *chooseSexView, NSInteger buttonIndex) {
        __strong typeof(weakSelf) sself = weakSelf;
        if (buttonIndex < 2){
            weakSelf.amendingInfoModel.sexStr = (buttonIndex == 0) ? @"男":@"女";
            sself -> sexTextField.text = weakSelf.amendingInfoModel.sexStr;
        }
    }];
    [sheetView showView];
}
//
- (NSMutableArray*)ageArr{
    if (_ageArr == nil){
        _ageArr = [[NSMutableArray alloc]init];
        for (int age = 18; age < 80; age ++){
            [_ageArr addObject:[NSString stringWithFormat:@"%d",age]];
        }
    }
    return _ageArr;
}
//年龄选择
- (void)showAgeChooseView{
      WS(weakSelf);
    THScrollChooseView *scrollChooseView = [[THScrollChooseView alloc] initWithQuestionArray:self.ageArr withDefaultDesc:@"30"];
    [scrollChooseView showView];
    scrollChooseView.confirmBlock = ^(NSInteger selectedQuestion) {
        __strong typeof(weakSelf) sself = weakSelf;
         sself -> ageTextField.text =  self.ageArr[selectedQuestion];
        NSString *ageStr = [self.ageArr[selectedQuestion] copy];
        
        weakSelf.amendingInfoModel.ageNum = [NSNumber numberWithInteger:[ageStr integerValue]];
        NSLog(@"age=%ld",[weakSelf.amendingInfoModel.ageNum integerValue] );
    };
}

//地区选择
- (void)completingTheSelection:(NSString *)province city:(NSString *)city area:(NSString *)area{
   
    addressTextField.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
    
    self.amendingInfoModel.proviceStr = [province copy];
    self.amendingInfoModel.cityStr = [city copy];
    self.amendingInfoModel.areaStr = [area copy];
}
//地区取消选择
-(void)cancelOnclick{
    [self.addressView hide];
}

- (void)addViews{
    //
    baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT)];
    baseScrollView.backgroundColor = [UIColor whiteColor];
    baseScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:baseScrollView];
    //
    CGFloat viewHeight = SCREEN_HEIGHT * 0.074;
    PersonalInfoExchangeViceTextView *topTipView = [[PersonalInfoExchangeViceTextView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, viewHeight)];
    WS(weakSelf);
    topTipView.clickSoundTextChangeViewBlock = ^(BOOL isSound) {
        __strong typeof(weakSelf) sself = weakSelf;
        [sself->nameView displayTextOrYuYin:isSound];
        [weakSelf judgeNameSoundDisplay];

    };
    [baseScrollView addSubview:topTipView];
    [topTipView addOwnContraints];
    //
    nameView = [[PersonalInfoInputNameView alloc]initWithFrame:CGRectMake(0, topTipView.bottom, self.view.width,viewHeight)];
    nameView.nameLabel.text = @"姓名";
    nameView.rightTextField.myTextField.text = self.orinalInfoModel.nameStr;
    nameView.rightTextField.myTextField.placeholder = @"请输入名字";
    nameView.addSoundView.addSoundClickBlock = ^{
        [weakSelf clickAddSound];
    };
    [baseScrollView addSubview:nameView];
    [nameView addOwnConstraints:[UIImage imageNamed:@"name"]];
    //
    PersonalInfoInputAgeView *ageView = [[PersonalInfoInputAgeView alloc] initWithFrame:CGRectMake(0, nameView.bottom, self.view.width, viewHeight)];
    ageTextField = ageView.rightTextField.myTextField;
    ageTextField.text = [self.orinalInfoModel.ageNum stringValue];
    ageView.ageLabel.text = @"年龄";
    [baseScrollView addSubview:ageView];
    ageView.rightTextField.myTextField.placeholder = @"请选择年龄";
    ageView.backButtBlock = ^(UITextField *textField) {
        NSLog(@"选择年龄");
        [weakSelf showAgeChooseView];
    };
    [ageView addOwnConstraints:[UIImage imageNamed:@"age"]];
    //性别
    PersonalInfoInputAgeView *sexView = [[PersonalInfoInputAgeView alloc] initWithFrame:CGRectMake(0, ageView.bottom, self.view.width, viewHeight)];
    sexTextField = sexView.rightTextField.myTextField;
    sexTextField.text = self.orinalInfoModel.sexStr;
    sexView.ageLabel.text = @"性别";
    [baseScrollView addSubview:sexView];
    sexView.rightTextField.myTextField.placeholder = @"请选择性别";
    sexView.backButtBlock = ^(UITextField *textField) {
        NSLog(@"选择性别");
        [weakSelf chooseSex];
        
    };
    [sexView addOwnConstraints:[UIImage imageNamed:@"sex"]];
    //城市
    PersonalInfoInputAgeView *cityView = [[PersonalInfoInputAgeView alloc] initWithFrame:CGRectMake(0, sexView.bottom, self.view.width, viewHeight)];
    addressTextField = cityView.rightTextField.myTextField;
    addressTextField.text = [NSString stringWithFormat:@"%@%@%@",[NSString getResultStrBySeverStr:self.orinalInfoModel.proviceStr],[NSString getResultStrBySeverStr:self.orinalInfoModel.cityStr],[NSString getResultStrBySeverStr:self.orinalInfoModel.areaStr]];
    cityView.ageLabel.text = @"城市";
    [baseScrollView addSubview:cityView];
    cityView.rightTextField.myTextField.placeholder = @"请选择城市";
    cityView.backButtBlock = ^(UITextField *textField) {
        NSLog(@"选择城市");
        [weakSelf.addressView show];
    };
    [cityView addOwnConstraints:[UIImage imageNamed:@"city"]];
    //
    CGFloat buttWidth = NEXT_BUTT_WIDTH;
    CGFloat buttHeigt = NEXT_BUTT_HEIGHT;
    
    CustomeStyleCornerButt *nextButt = [[CustomeStyleCornerButt alloc] initWithFrame:CGRectMake(0, cityView.bottom + SCREEN_HEIGHT * 0.404, buttWidth, buttHeigt) backColor:[UIColor colorWithHexString:@"#78CAC5"] cornerRadius:4 title:@"下一步" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:18]];
    nextButt.center = CGPointMake(self.view.width  / 2, nextButt.centerY);
    nextButt.clickButtBlock = ^{
        [weakSelf nextHandler];
    };
    [baseScrollView addSubview:nextButt];
    //
    [baseScrollView setContentSize:CGSizeMake(baseScrollView.width, nextButt.bottom + 30)];
    
}
- (void)nextHandler{
    //
    self.amendingInfoModel.nameStr = [NSString getResultStrBySeverStr:nameView.rightTextField.myTextField.text] ;
    //
    self.amendingInfoModel.sexStr = [NSString getResultStrBySeverStr:sexTextField.text];
    //
    PersonalInfoWorkViewController *workVC = [[PersonalInfoWorkViewController alloc]init];
    workVC.orinalInfoModel = self.orinalInfoModel;
    workVC.amendingInfoModel = self.amendingInfoModel;
    [self.navigationController pushViewController:workVC animated:YES];
}

//语音录制播放
- (void)clickAddSound{
    if (self.amendingInfoModel.nameSoundData == nil){
        NSLog(@"没有语音");
        //然后播放
        [self->dealRecordPlaySound startRecord];
        //录制语音弹窗
        [LuZhiYuYinPop showPopView:^{//暂时没有做取消块
            
        } completeBlock:^{
            [LuZhiYuYinPop dismissPopView];
            [self->dealRecordPlaySound endRecord];
            self.amendingInfoModel.nameSoundData = [self->dealRecordPlaySound.WavsoundData copy];
             self.amendingInfoModel.nameSoundTime = self->dealRecordPlaySound.recordTime;
            self.amendingInfoModel.nameSoundAmrData = [self->dealRecordPlaySound.amrSoundData copy];
            
            [self -> nameView.addSoundView changeToPlaySoundState];
            NSLog(@"录制完成后的语音文件%@",self.amendingInfoModel.nameSoundData);
        } ];
    }else{
         NSLog(@"有语音");
        [dealRecordPlaySound playSound:self.amendingInfoModel.nameSoundData];
        [BoFangYuYinOwnPop showPopView:self.amendingInfoModel.nameSoundTime deleteBlock:^{//删除点击
            [BoFangYuYinOwnPop dismissPopView];
            [self -> dealRecordPlaySound stopPlay];
            self.amendingInfoModel.nameSoundData = nil;
            self.amendingInfoModel.nameSoundAmrData = nil;
            self.amendingInfoModel.nameSoundTime = 0;
            self.amendingInfoModel.nameSoundUrlStr = @"";
            [self -> nameView.addSoundView changeToAddSoundState];
        } completeBlock:^{//完成点击
            [self->dealRecordPlaySound stopPlay];
            [BoFangYuYinOwnPop dismissPopView];
           [self -> nameView.addSoundView changeToPlaySoundState];
        }];
    }
}

- (void)judgeNameSoundDisplay{
    if(self.amendingInfoModel.nameSoundUrlStr.length == 0){
        [nameView.addSoundView changeToAddSoundState];
    }else{
         [nameView.addSoundView changeToPlaySoundState];
    }
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
