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
#import "OwnTextView.h"
#import "CommitPopView.h"

@interface LaunchPiesViewController ()<UIScrollViewDelegate>{
    UIScrollView *baseScrollView;
    LaunchPiesTicketInputNameView *nameView;
    LaunchPiesTicketInputNameView *mobileView;
    LaunchPiesTicketInputNameView *addressView;
    LaunchPiesTicketChooseJobView *jobKindView;
    LaunchPiesTicketChooseJobView *technologeView;
    LaunchPiesTicketYuSuanView *yuSuanView;
    LaunchPiesTicketChooseJobView *timeChooseView;
    LaunchPiesTicketInputNameView *beiZhuView;
    //
    CommitPopView *popView;
    UIButton *popbackButt;
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
    [self hiddenXuanFuButt];
    [self addViews];
}

- (void)addViews{
    //
    CGFloat groupViewVerticalSpace = 10;
    CGFloat singleViewHeight = 50;
   //
    baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, self.view.width, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT)];
    baseScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    baseScrollView.backgroundColor = [UIColor colorWithHexString:@"#DADADA"];
    baseScrollView.delegate = self;
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
    //备注
    beiZhuView = [[LaunchPiesTicketInputNameView alloc]initWithFrame:CGRectMake(0,timeChooseView.bottom, self.view.width,singleViewHeight) needRightMapButt:NO];
    beiZhuView.rightTextField.hidden = YES;
    beiZhuView.bottomLineView.hidden = YES;
    [beiZhuView addOwnConstraints:[UIImage imageNamed:@"ticket_beizhu"]];
    beiZhuView.nameLabel.text = @"备注";
    [baseScrollView addSubview:beiZhuView];
    //textview baseview
    UIView *baseTextView = [[UIView alloc]initWithFrame:CGRectMake(0, beiZhuView.bottom, baseScrollView.width, SCREEN_HEIGHT * 0.15)];
    baseTextView.backgroundColor = [UIColor whiteColor];
    [baseScrollView addSubview:baseTextView];
    //textview
    OwnTextView *beiZhuTextView = [[OwnTextView alloc]initWithFrame:CGRectMake(35, 0, baseTextView.width - 35 - 10, baseTextView.height * 0.8)];
    beiZhuTextView.backgroundColor = [UIColor whiteColor];
    beiZhuTextView.clipsToBounds = YES;
    beiZhuTextView.layer.borderWidth = 1;
    beiZhuTextView.layer.borderColor = [UIColor colorWithHexString:@"#C6C6C6"].CGColor;
    beiZhuTextView.layer.cornerRadius = 5;
    WS(weakSelf);
    CGPoint rememberContentOffset = baseScrollView.contentOffset;
    NSLog(@"rememberContentOffset.y = %lf",rememberContentOffset.y);
    beiZhuTextView.keyBoardChangedBlock = ^(CGFloat keyBoardHeight) {
        __strong typeof(weakSelf) sself = weakSelf;
        CGFloat currentContentOffsetY = sself -> baseScrollView.contentOffset.y;
        CGFloat contentSizeHeight = sself -> baseScrollView.contentSize.height;
        CGFloat offsetY = contentSizeHeight - currentContentOffsetY - (SCREEN_HEIGHT - StatusBarAndNavigationBarHeight - keyBoardHeight);
        NSLog(@"offsetY = %lf",offsetY);
        if (currentContentOffsetY >= 0){
            sself -> baseScrollView.contentOffset = CGPointMake(rememberContentOffset.x, 280);
        }
    };
    beiZhuTextView.keyBoardExistBlock = ^{
        __strong typeof(weakSelf) sself = weakSelf;
        sself -> baseScrollView.contentOffset = rememberContentOffset;
       
    };
    [baseTextView addSubview:beiZhuTextView];
    //提交基view
    UIView *commitButtBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, baseTextView.bottom + groupViewVerticalSpace, baseScrollView.width, SCREEN_HEIGHT * 0.112)];
    commitButtBaseView.backgroundColor = [UIColor whiteColor];
    [baseScrollView addSubview:commitButtBaseView];
    //
    UIColor *commitButtBackColor = SPECIAL_BLUE_COLOR;
    CustomeStyleCornerButt *commitButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(0, 0, commitButtBaseView.width - 20, commitButtBaseView.height * 0.6) backColor:commitButtBackColor cornerRadius:8 title:@"提交" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:18]];
    commitButt.center = CGPointMake(commitButtBaseView.width / 2, commitButtBaseView.height / 2);
    commitButt.clickButtBlock = ^{
        [weakSelf showPopView];
    };
    [commitButtBaseView addSubview:commitButt];
    //
    [baseScrollView setContentSize:CGSizeMake(baseScrollView.width, commitButtBaseView.bottom + 15)];
    //
    
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
