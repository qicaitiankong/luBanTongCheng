//
//  LaunchPiesViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "LaunchPiesViewController.h"

#import "LaunchPiesTicketInputNameView.h"
#import "LaunchPiesTicketChooseJobView.h"
#import "LaunchPiesTicketYuSuanView.h"

@interface LaunchPiesViewController (){
    UIScrollView *baseScrollView;
    LaunchPiesTicketInputNameView *nameView;
    LaunchPiesTicketInputNameView *mobileView;
    LaunchPiesTicketInputNameView *addressView;
    LaunchPiesTicketChooseJobView *jobKindView;
    LaunchPiesTicketChooseJobView *technologeView;
    LaunchPiesTicketYuSuanView *yuSuanView;
    LaunchPiesTicketChooseJobView *timeChooseView;
}

@end

@implementation LaunchPiesViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发起派单";
    [self addViews];
}

- (void)addViews{
    //
    CGFloat groupViewVerticalSpace = 10;
    CGFloat singleViewHeight = 50;
   //
    baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, self.view.width, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT)];
    baseScrollView.backgroundColor = [UIColor colorWithHexString:@"#DADADA"];
    [self.view addSubview:baseScrollView];
    //
    nameView = [[LaunchPiesTicketInputNameView alloc]initWithFrame:CGRectMake(0, groupViewVerticalSpace, self.view.width,singleViewHeight) needRightMapButt:NO];
    nameView.nameLabel.text = @"称呼";
    nameView.rightTextField.myTextField.placeholder = @"";
    nameView.rightTextField.userInteractionEnabled = NO;
    [nameView addOwnConstraints:[UIImage imageNamed:@"name"]];
    nameView.rightTextField.myTextField.text = @"鲁班同城";
    [baseScrollView addSubview:nameView];
    //
    mobileView = [[LaunchPiesTicketInputNameView alloc]initWithFrame:CGRectMake(0, nameView.bottom, self.view.width,singleViewHeight) needRightMapButt:NO];
    mobileView.nameLabel.text = @"电话";
    mobileView.rightTextField.myTextField.placeholder = @"请输入电话";
    [baseScrollView addSubview:mobileView];
    [mobileView addOwnConstraints:[UIImage imageNamed:@"ticket_mobile"]];
    [baseScrollView addSubview:mobileView];
    //
    addressView = [[LaunchPiesTicketInputNameView alloc]initWithFrame:CGRectMake(0, mobileView.bottom, self.view.width,singleViewHeight) needRightMapButt:YES];
    addressView.nameLabel.text = @"地址";
    addressView.rightTextField.myTextField.placeholder = @"请输入地址";
    [addressView addOwnConstraints:[UIImage imageNamed:@"ticket_address"]];
    [baseScrollView addSubview:addressView];
    //
    UIView *addressBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, addressView.bottom, self.view.width, 15)];
    addressBottomView.backgroundColor = [UIColor whiteColor];
    [baseScrollView addSubview:addressBottomView];
    //工作类型
    jobKindView = [[LaunchPiesTicketChooseJobView alloc]initWithFrame:CGRectMake(0,addressBottomView.bottom + groupViewVerticalSpace, self.view.width,singleViewHeight)];
    [jobKindView addOwnConstraints:[UIImage imageNamed:@"ticket_jobKind"]];
    jobKindView.ageLabel.text = @"工作类型";
    jobKindView.rightTextField.myTextField.placeholder = @"请选择";
    [baseScrollView addSubview:jobKindView];
    //技能要求
    technologeView = [[LaunchPiesTicketChooseJobView alloc]initWithFrame:CGRectMake(0,jobKindView.bottom, self.view.width,singleViewHeight)];
    [technologeView addOwnConstraints:[UIImage imageNamed:@"tecnology"]];
    technologeView.ageLabel.text = @"技能要求";
    technologeView.rightTextField.myTextField.placeholder = @"请选择";
    [baseScrollView addSubview:technologeView];
    //
    yuSuanView = [[LaunchPiesTicketYuSuanView alloc]initWithFrame:CGRectMake(0,technologeView.bottom, self.view.width,singleViewHeight)];
    [yuSuanView addOwnConstraints:[UIImage imageNamed:@"ticket_yuSuan"]];
    yuSuanView.nameLabel.text = @"预算";
    [baseScrollView addSubview:yuSuanView];
    //
    UIView *yuSuanBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, yuSuanView.bottom, self.view.width, 15)];
    yuSuanBottomView.backgroundColor = [UIColor whiteColor];
    [baseScrollView addSubview:yuSuanBottomView];
    //
    timeChooseView = [[LaunchPiesTicketChooseJobView alloc]initWithFrame:CGRectMake(0,yuSuanBottomView.bottom + groupViewVerticalSpace, self.view.width,singleViewHeight)];
    [timeChooseView addOwnConstraints:[UIImage imageNamed:@"ticket_time"]];
    timeChooseView.ageLabel.text = @"上门时间";
    timeChooseView.rightTextField.myTextField.placeholder = @"请选择";
    [baseScrollView addSubview:timeChooseView];
    //
    [baseScrollView setContentSize:CGSizeMake(baseScrollView.width, timeChooseView.bottom + 15)];
    //
    
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
