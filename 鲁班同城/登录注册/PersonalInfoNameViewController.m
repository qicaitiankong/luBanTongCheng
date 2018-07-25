//
//  PersonalInfoNameViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "PersonalInfoNameViewController.h"
//
#import "PersonalInfoInputAgeView.h"
#import "PersonalInfoExchangeViceTextView.h"
#import "CustomeStyleCornerButt.h"
#import "PersonalInfoInputNameView.h"

#import "PersonalInfoWorkViewController.h"

@interface PersonalInfoNameViewController (){
    PersonalInfoInputNameView *nameView;
    UIScrollView *baseScrollView;
}

@end

@implementation PersonalInfoNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    WS(weakSelf);
    self.leftBarbuttBlock = ^{
        [weakSelf.navigationController setNavigationBarHidden:YES];
    };
    self.rightBarbuttBlock = ^{
        
    };
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
    };
    [baseScrollView addSubview:topTipView];
    [topTipView addOwnContraints];
    //
    nameView = [[PersonalInfoInputNameView alloc]initWithFrame:CGRectMake(0, topTipView.bottom, self.view.width,viewHeight)];
    nameView.nameLabel.text = @"姓名";
    nameView.rightTextField.myTextField.placeholder = @"请输入名字";
    [baseScrollView addSubview:nameView];
    [nameView addOwnConstraints:[UIImage imageNamed:@"name"]];
    //
    PersonalInfoInputAgeView *ageView = [[PersonalInfoInputAgeView alloc] initWithFrame:CGRectMake(0, nameView.bottom, self.view.width, viewHeight)];
    ageView.ageLabel.text = @"年龄";
    [baseScrollView addSubview:ageView];
    ageView.rightTextField.myTextField.placeholder = @"请选择年龄";
    ageView.backButtBlock = ^(UITextField *textField) {
        NSLog(@"选择年龄");
        textField.text = @"20";
    };
    [ageView addOwnConstraints:[UIImage imageNamed:@"age"]];
    //性别
    PersonalInfoInputAgeView *sexView = [[PersonalInfoInputAgeView alloc] initWithFrame:CGRectMake(0, ageView.bottom, self.view.width, viewHeight)];
    sexView.ageLabel.text = @"性别";
    [baseScrollView addSubview:sexView];
    sexView.rightTextField.myTextField.placeholder = @"请选择性别";
    sexView.backButtBlock = ^(UITextField *textField) {
        NSLog(@"选择性别");
        textField.text = @"男";
    };
    [sexView addOwnConstraints:[UIImage imageNamed:@"sex"]];
    //城市
    PersonalInfoInputAgeView *cityView = [[PersonalInfoInputAgeView alloc] initWithFrame:CGRectMake(0, sexView.bottom, self.view.width, viewHeight)];
    cityView.ageLabel.text = @"城市";
    [baseScrollView addSubview:cityView];
    cityView.rightTextField.myTextField.placeholder = @"请选择城市";
    cityView.backButtBlock = ^(UITextField *textField) {
        NSLog(@"选择城市");
        textField.text = @"青岛";
    };
    [cityView addOwnConstraints:[UIImage imageNamed:@"city"]];
    //
    CGFloat buttWidth = SCREEN_WIDTH * 0.874;
    CGFloat buttHeigt = buttWidth * 0.137;
    
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
    PersonalInfoWorkViewController *workVC = [[PersonalInfoWorkViewController alloc]init];
    [self.navigationController pushViewController:workVC animated:YES];
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
