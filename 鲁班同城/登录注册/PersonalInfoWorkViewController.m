//
//  PersonalInfoWorkViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "PersonalInfoWorkViewController.h"
#import "PersonalInfoInputAgeView.h"
#import "PersonalInfoExchangeViceTextView.h"
#import "CustomeStyleCornerButt.h"
#import "OwnTextView.h"
//vc
#import "PersonalInfoVideoViewController.h"
#import "PersonalInfoTechnologyChooseViewController.h"
//m
#import "ChooseTechnologyLeftModel.h"

@interface PersonalInfoWorkViewController ()<AVAudioPlayerDelegate,AVAudioRecorderDelegate>{
    PersonalInfoInputAgeView *technologyView;
    PersonalInfoInputAgeView *jobView;
    PersonalInfoInputAgeView *experienceView;
    OwnTextView *experienceTextView;
    __block BOOL isSound;
    UIScrollView *baseScrollView;
    RecordAndPlaySound *dealRecordPlaySound;
}

@end

@implementation PersonalInfoWorkViewController



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
    [self dealAllOwnEvent];
}

- (void)dealAllOwnEvent{
    WS(weakSelf);
    //工作经历语音点击添加语音
    experienceView.addSoundView.addSoundClickBlock = ^{
        [weakSelf clickAddSound];
    };
}

//语音录制播放
- (void)clickAddSound{
    if (self.amendingInfoModel.workExperienceData == nil){
        NSLog(@"没有语音");
        [self->dealRecordPlaySound startRecord];
        //录制语音弹窗
        [LuZhiYuYinPop showPopView:^{//暂时没有做取消块
            
        } completeBlock:^{
            [LuZhiYuYinPop dismissPopView];
            [self->dealRecordPlaySound endRecord];
            self.amendingInfoModel.workExperienceData = [self->dealRecordPlaySound.WavsoundData copy];
            self.amendingInfoModel.workExperienceSoundTime = self->dealRecordPlaySound.recordTime;
            self.amendingInfoModel.workExperienceAmrData = [self->dealRecordPlaySound.amrSoundData copy];
            [self -> experienceView.addSoundView changeToPlaySoundState];

            NSLog(@"录制完成后的语音文件%@",self.amendingInfoModel.workExperienceData);
        }];
    }else{
        NSLog(@"有语音");
        [dealRecordPlaySound playSound:self.amendingInfoModel.workExperienceData];
        [BoFangYuYinOwnPop showPopView:self.amendingInfoModel.workExperienceSoundTime deleteBlock:^{//删除点击
            [BoFangYuYinOwnPop dismissPopView];
            [self -> dealRecordPlaySound stopPlay];
            self.amendingInfoModel.workExperienceAmrData = nil;
            self.amendingInfoModel.workExperienceData = nil;
            self.amendingInfoModel.workExperienceSoundTime = 0;
             [self -> experienceView.addSoundView changeToAddSoundState];
        } completeBlock:^{//完成点击
            [self->dealRecordPlaySound stopPlay];
            [BoFangYuYinOwnPop dismissPopView];
             [self -> experienceView.addSoundView changeToPlaySoundState];
        }];
    }
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
        [sself->experienceView displayTextOrYuYin:isSound];
        [sself->experienceTextView setHidden:isSound];
        [sself->experienceView hiddenBottomLine:isSound];
        sself->isSound  = isSound;
    };
    [baseScrollView addSubview:topTipView];
    [topTipView addOwnContraints];
    //技能
    technologyView = [[PersonalInfoInputAgeView alloc] initWithFrame:CGRectMake(0, topTipView.bottom, self.view.width, viewHeight)];
    
    technologyView.ageLabel.text = @"技能";
    [baseScrollView addSubview:technologyView];
    technologyView.backButtBlock = ^(UITextField *textField) {
        __strong typeof(weakSelf) sself = weakSelf;
            PersonalInfoTechnologyChooseViewController *chooseVC = [[PersonalInfoTechnologyChooseViewController alloc] init];
            chooseVC.kindTag = 1;
            chooseVC.selectedBlock = ^(NSMutableArray *modelArr) {
                NSArray *localModelArr = modelArr;
                NSMutableArray *nameArr = [[NSMutableArray alloc]init];
                NSMutableArray *nameIDArr = [[NSMutableArray alloc]init];
                for (int k = 0; k < modelArr.count; k ++){
                    ChooseTechnologyLeftModel *singleModel = localModelArr[k];
                    [nameArr addObject:singleModel.title];
                    [nameIDArr addObject:[NSString stringWithFormat:@"%ld",singleModel.idFlag]];
                }
                //跟新传给后台时的字符串
                weakSelf.amendingInfoModel.technologyStr = [nameArr componentsJoinedByString:@","];
                weakSelf.amendingInfoModel.technologyServiceNeedStr = [nameIDArr componentsJoinedByString:@","];
                //跟新显示信息
                sself -> technologyView.rightTextField.myTextField.text = [weakSelf.amendingInfoModel.technologyStr copy];
                
            };
            [weakSelf.navigationController pushViewController:chooseVC animated:YES];
    };
    technologyView.rightTextField.myTextField.text = [self.orinalInfoModel.technologyStr copy];
    [technologyView addOwnConstraints:[UIImage imageNamed:@"tecnology"]];
    //职业类型
    jobView = [[PersonalInfoInputAgeView alloc] initWithFrame:CGRectMake(0, technologyView.bottom, self.view.width, viewHeight)];
    jobView.ageLabel.text = @"职业类型";
    [baseScrollView addSubview:jobView];
    jobView.backButtBlock = ^(UITextField *textField) {
        __strong typeof(weakSelf) sself = weakSelf;
            PersonalInfoTechnologyChooseViewController *chooseVC = [[PersonalInfoTechnologyChooseViewController alloc] init];
            chooseVC.kindTag = 2;
            chooseVC.selectedBlock = ^(NSMutableArray *modelArr) {
                NSArray *localModelArr = modelArr;
                NSMutableArray *nameArr = [[NSMutableArray alloc]init];
                NSMutableArray *nameIDArr = [[NSMutableArray alloc]init];
                for (int k = 0; k < modelArr.count; k ++){
                    ChooseTechnologyLeftModel *singleModel = localModelArr[k];
                    [nameArr addObject:singleModel.title];
                    [nameIDArr addObject:[NSString stringWithFormat:@"%ld",singleModel.idFlag]];
                }
                weakSelf.amendingInfoModel.jobStr = [nameArr componentsJoinedByString:@","];
                weakSelf.amendingInfoModel.jobServiceNeedStr = [nameIDArr componentsJoinedByString:@","];
                sself -> jobView.rightTextField.myTextField.text = weakSelf.amendingInfoModel.jobStr;
            };
            [weakSelf.navigationController pushViewController:chooseVC animated:YES];
    };
    jobView.rightTextField.myTextField.text = [self.orinalInfoModel.jobStr copy];
    [jobView addOwnConstraints:[UIImage imageNamed:@"job"]];
    
    //工作经历
    experienceView = [[PersonalInfoInputAgeView alloc] initWithFrame:CGRectMake(0, jobView.bottom, self.view.width, viewHeight)];
   
    experienceView.flagImageView.hidden = YES;
    experienceView.ageLabel.text = @"工作经历";
    [baseScrollView addSubview:experienceView];
    [experienceView addOwnConstraints:[UIImage imageNamed:@"experience"]];
    //
    experienceTextView = [[OwnTextView alloc] initWithFrame:CGRectMake(35, experienceView.bottom + 20, SCREEN_WIDTH - 2 * 35, SCREEN_HEIGHT * 0.134)];
    if(self.orinalInfoModel.jobExperienceStr.length){
        experienceTextView.writeViewPlaceHolderLabel.hidden = YES;
    }else{
        experienceTextView.writeViewPlaceHolderLabel.hidden = NO;
    }
    experienceTextView.writeViewPlaceHolderLabel.text = @"详细的工作经验会增加你的魅力值哦";
    experienceTextView.writeTextView.text = [self.orinalInfoModel.jobExperienceStr copy];
    experienceTextView.layer.borderWidth = 1;
    experienceTextView.layer.borderColor = [UIColor colorWithHexString:@"#C6C6C6"].CGColor;
    experienceTextView.layer.cornerRadius = 3;
    experienceTextView.clipsToBounds = YES;
    experienceTextView.writeTextView.text = self.orinalInfoModel.jobExperienceStr;
    CGPoint rememeberContentOffset = baseScrollView.contentOffset;
    //调整basescrollview 方便输入
    experienceTextView.keyBoardChangedBlock = ^(CGFloat keyBoardHeight) {
        __strong typeof(weakSelf) sself = weakSelf;
        CGFloat offssetY = (sself -> experienceTextView.bottom) -  (SCREEN_HEIGHT - StatusBarAndNavigationBarHeight - keyBoardHeight);
        //NSLog(@"offssetY = %lf",offssetY);
        if (offssetY > 0){
            sself -> baseScrollView.contentOffset = CGPointMake( sself -> baseScrollView.contentOffset.x, offssetY + 5);
        }
    };
    experienceTextView.keyBoardExistBlock = ^{
         __strong typeof(weakSelf) sself = weakSelf;
        sself -> baseScrollView.contentOffset = rememeberContentOffset;
    };
    [baseScrollView addSubview:experienceTextView];
    //
    CGFloat buttWidth = NEXT_BUTT_WIDTH;
    CGFloat buttHeigt = NEXT_BUTT_HEIGHT;
   
    CustomeStyleCornerButt *nextButt = [[CustomeStyleCornerButt alloc] initWithFrame:CGRectMake(0, experienceTextView.bottom + SCREEN_HEIGHT * 0.3, buttWidth, buttHeigt) backColor:[UIColor colorWithHexString:@"#78CAC5"] cornerRadius:4 title:@"下一步" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:18]];
    nextButt.center = CGPointMake(self.view.width  / 2, nextButt.centerY);
    nextButt.clickButtBlock = ^{
        [weakSelf nextHandler];
    };
    [baseScrollView addSubview:nextButt];
    //
    [baseScrollView setContentSize:CGSizeMake(self.view.width, nextButt.bottom + 30)];
    NSLog(@"contentoffset.y=%lf",baseScrollView.contentOffset.y);
}



- (void)nextHandler{
    PersonalInfoVideoViewController *videoVC = [[PersonalInfoVideoViewController alloc]init];
    videoVC.orinalInfoModel = self.orinalInfoModel;
    videoVC.amendingInfoModel = self.amendingInfoModel;
    [self.navigationController pushViewController:videoVC animated:YES];
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
