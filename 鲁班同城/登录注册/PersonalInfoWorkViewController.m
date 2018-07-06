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

@interface PersonalInfoWorkViewController (){
    PersonalInfoInputAgeView *technologyView;
    PersonalInfoInputAgeView *jobView;
    PersonalInfoInputAgeView *experienceView;
    OwnTextView *experienceTextView;
    __block BOOL isSound;
}

@end

@implementation PersonalInfoWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    self.leftBarbuttBlock = ^{
        
    };
    self.rightBarbuttBlock = ^{
        
    };
    // Do any additional setup after loading the view.
}



- (void)addViews{
    CGFloat viewHeight = SCREEN_HEIGHT * 0.074;
    PersonalInfoExchangeViceTextView *topTipView = [[PersonalInfoExchangeViceTextView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, viewHeight)];
    WS(weakSelf);
    topTipView.clickSoundTextChangeViewBlock = ^(BOOL isSound) {
        __strong typeof(weakSelf) sself = weakSelf;
        [sself->technologyView displayTextOrYuYin:isSound];
        [sself->jobView displayTextOrYuYin:isSound];
        [sself->experienceView displayTextOrYuYin:isSound];
        [sself->experienceTextView setHidden:isSound];
        [sself->technologyView hiddenBottomLine:isSound];
        [sself->jobView hiddenBottomLine:isSound];
        [sself->experienceView hiddenBottomLine:isSound];
        sself->isSound  = isSound;
    };
    [self.view addSubview:topTipView];
    [topTipView addOwnContraints];
    //技能
    technologyView = [[PersonalInfoInputAgeView alloc] initWithFrame:CGRectMake(0, topTipView.bottom, self.view.width, viewHeight)];
    
    technologyView.ageLabel.text = @"技能";
    [self.view addSubview:technologyView];
    technologyView.backButtBlock = ^(UITextField *textField) {
        __strong typeof(weakSelf) sself = weakSelf;
        if(NO == sself->isSound){
            PersonalInfoTechnologyChooseViewController *chooseVC = [[PersonalInfoTechnologyChooseViewController alloc] init];
            [weakSelf.navigationController pushViewController:chooseVC animated:YES];
        }
        
    };
    [technologyView addOwnConstraints:[UIImage imageNamed:@"tecnology"]];
    //职业类型
    jobView = [[PersonalInfoInputAgeView alloc] initWithFrame:CGRectMake(0, technologyView.bottom, self.view.width, viewHeight)];
    jobView.ageLabel.text = @"职业类型";
    [self.view addSubview:jobView];
    jobView.backButtBlock = ^(UITextField *textField) {
        NSLog(@"职业类型");
       // textField.text = @"男";
    };
    [jobView addOwnConstraints:[UIImage imageNamed:@"job"]];
    //工作经历
    experienceView = [[PersonalInfoInputAgeView alloc] initWithFrame:CGRectMake(0, jobView.bottom, self.view.width, viewHeight)];
    experienceView.ageLabel.text = @"工作经历";
    [self.view addSubview:experienceView];
    experienceView.backButtBlock = ^(UITextField *textField) {
        NSLog(@"工作经历");
    };
    [experienceView addOwnConstraints:[UIImage imageNamed:@"experience"]];
    //
    experienceTextView = [[OwnTextView alloc] initWithFrame:CGRectMake(35, experienceView.bottom + 20, SCREEN_WIDTH - 2 * 35, SCREEN_HEIGHT * 0.134)];
    experienceTextView.writeViewPlaceHolderLabel.text = @"详细的工作经历会增加你的魅力值哦";
    experienceTextView.layer.borderWidth = 1;
    experienceTextView.layer.borderColor = [UIColor colorWithHexString:@"#C6C6C6"].CGColor;
    experienceTextView.layer.cornerRadius = 3;
    experienceTextView.clipsToBounds = YES;
    [self.view addSubview:experienceTextView];
    //
    CGFloat buttWidth = SCREEN_WIDTH * 0.874;
    CGFloat buttHeigt = buttWidth * 0.137;
    
    CustomeStyleCornerButt *nextButt = [[CustomeStyleCornerButt alloc] initWithFrame:CGRectMake(0, experienceTextView.bottom + SCREEN_HEIGHT * 0.3, buttWidth, buttHeigt) backColor:[UIColor colorWithHexString:@"#78CAC5"] cornerRadius:4 title:@"下一步" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:18]];
    nextButt.center = CGPointMake(self.view.width  / 2, nextButt.centerY);
    nextButt.clickButtBlock = ^{
        [weakSelf nextHandler];
    };
    [self.view addSubview:nextButt];
    
}

- (void)nextHandler{
    PersonalInfoVideoViewController *videoVC = [[PersonalInfoVideoViewController alloc]init];
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
