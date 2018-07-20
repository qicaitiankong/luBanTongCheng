//
//  OrderTakingQuotePriceDetailViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "OrderTakingQuotePriceDetailViewController.h"
#import "OrderTakingQuotePriceDetailTableViewCell.h"
#import "TakeOrderQuotePriceDetaiSectionView.h"
#import "OrderTakingQuotePriceDetailTelephoneTableViewCell.h"
#import "OrderTakingQuotePriceDetailTelephoneView.h"



#import "OrderTakingQuotePriceViewController.h"


@interface OrderTakingQuotePriceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIScrollView *baseScrollView;
    TakeOrderQuotePriceDetaiSectionView *sectionView;
    OrderTakingQuotePriceDetailTelephoneView *telephoneSectionView;
    OrderTakingQuotePriceDetailTelephoneView *addressSectionView;
    
    OrderTakingQuotePriceDetailTelephoneView *beiZhuSectionView;
    
    UILabel *tipSectionLabel;
}

@property (strong,nonatomic) TakeOrderQuotePriceDetailModel *singleModel;

@property (strong,nonatomic) UITableView *tableView;


@end

@implementation OrderTakingQuotePriceDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    //
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    //
    self.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initOwnObjects];
    //
     [self addTableView:CGRectMake(0, 0,self.view.width,CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT - 50) style:UITableViewStylePlain];
    [self addBottomButtView];
    [self getData];
}

- (void)initOwnObjects{
}

- (void)getData{
    self.singleModel = [[TakeOrderQuotePriceDetailModel alloc] init];
    self.singleModel.image = [UIImage imageNamed:@"test07.jpg"];
    self.singleModel.timeStr = @"2018-6-6";
    self.singleModel.personNameStr = @"发起人名称";
    self.singleModel.detailStr = @"详细要求：工作要求详细要求：工作要求详细要求工作要求详细要求工作要求详细要求工作要求详细要求。";
    self.singleModel.praiseStr = @"成交价格：99+";
    self.singleModel.ticketsNumberStr = @"抢单名额 3/10";
    [self.tableView reloadData];
}

- (void)takeOrderClick{
    NSLog(@"接单");
    OrderTakingQuotePriceViewController *baoJiaVC = [[OrderTakingQuotePriceViewController alloc]init];
    [self.navigationController pushViewController:baoJiaVC animated:YES];
}

//views
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    UIImage *backImage = [UIImage imageNamed:@"quotePriceDetailBack"];
    CGFloat imageDisplayHeight = self.view.width / (backImage.size.width / backImage.size.height);
    //
    sectionView = [[TakeOrderQuotePriceDetaiSectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, imageDisplayHeight + 30) backImageHeight:imageDisplayHeight image:backImage];
    sectionView.topDisplayLabel.text = @"恭喜被雇主选中";
    sectionView.botDisplayLabel.text = @"雇主联系方式";
    //
    tipSectionLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor whiteColor] aligement:1];
    tipSectionLabel.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    tipSectionLabel.text = @"提醒：放弃或超8小时接单将自动接受平台惩罚";
    tipSectionLabel.frame = CGRectMake(0, 0, self.view.width, 40);
    //
    telephoneSectionView = [[OrderTakingQuotePriceDetailTelephoneView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50) isNeedRightButt:YES];
    telephoneSectionView.ownLeftLabel.text =@"电话：";
    [telephoneSectionView.telephoneButt setImage:[UIImage imageNamed:@"telephone"] forState:UIControlStateNormal];
    //
    addressSectionView = [[OrderTakingQuotePriceDetailTelephoneView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50) isNeedRightButt:YES];
    addressSectionView.ownLeftLabel.text =@"地址：";
    [addressSectionView.telephoneButt setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    //
    beiZhuSectionView = [[OrderTakingQuotePriceDetailTelephoneView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50) isNeedRightButt:NO];
    beiZhuSectionView.ownLeftLabel.text =@"备注：";
    //
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)addBottomButtView{
    UIButton *giveButt = [UIButton buttonWithType:UIButtonTypeCustom];
    giveButt.backgroundColor = [UIColor whiteColor];
    giveButt.frame = CGRectMake(0, SCREEN_HEIGHT - StatusBarAndNavigationBarHeight  - 50, self.view.width / 2, 50);
    giveButt.titleLabel.font = [UIFont getPingFangSCMedium:16];
    [giveButt setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [giveButt setTitle:@"放弃" forState:UIControlStateNormal];
    
    [self.view addSubview:giveButt];
    //
    UIView *buttLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, giveButt.width, 1)];
    buttLine.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    [giveButt addSubview:buttLine];
    //
    UIButton *orderButt = [UIButton buttonWithType:UIButtonTypeCustom];
    orderButt.backgroundColor = [UIColor colorWithHexString:@"#FF7E00"];
    orderButt.frame = CGRectMake(giveButt.right, giveButt.top, self.view.width / 2, giveButt.height);
    orderButt.titleLabel.font = [UIFont getPingFangSCMedium:16];
    [orderButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [orderButt addTarget:self action:@selector(takeOrderClick) forControlEvents:UIControlEventTouchUpInside];
    [orderButt setTitle:@"接单" forState:UIControlStateNormal];
    [self.view addSubview:orderButt];
    //
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 1;
            break;
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
            rows = 0;
            break;
        default:
            break;
    }
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *parentCell = nil;
    if (indexPath.section == 0){
        static NSString *cellFlag = @"cellFlag";
        OrderTakingQuotePriceDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
        if (nil == cell){
            cell = [[OrderTakingQuotePriceDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
        }
        cell.model = self.singleModel;
        parentCell = cell;
    }
    return parentCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    
    if (indexPath.section == 0){
        TakeOrderQuotePriceDetailModel *model = self.singleModel;
        height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderTakingQuotePriceDetailTableViewCell class] contentViewWidth:SCREEN_WIDTH];
        NSLog(@"!!!!!!!!!HEIGHT=%lf",height);
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = nil;
    switch (section) {
        case 0:
            break;
        case 1:
            view = sectionView;
            break;
        case 2:
            telephoneSectionView.ownRightLabel.text = @"13956789236";
            view = telephoneSectionView;
            break;
        case 3:
            addressSectionView.ownRightLabel.text = @"青岛市-李沧区\n某某路12号12单元12户";
            view = addressSectionView;
            break;
        case 4:
            beiZhuSectionView.ownRightLabel.text = @"注意事项需要准备什么注意事项需要准备，什么注意事项需要准备什么。";
            view = beiZhuSectionView;
            break;
        case 5:
            tipSectionLabel.text = @"提醒：放弃或超8小时接单将自动接受平台惩罚";
            view = tipSectionLabel;
            break;
        default:
            break;
    }
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    switch (section) {
        case 0:
            break;
        case 1:
            height = sectionView.height;
            break;
        case 2:
            height = telephoneSectionView.height;
            break;
        case 3:
            height = addressSectionView.height;
            break;
        case 4:
            height = beiZhuSectionView.height;
            break;
        case 5:
            height = tipSectionLabel.height;
            break;
        default:
            break;
    }
    return height;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
