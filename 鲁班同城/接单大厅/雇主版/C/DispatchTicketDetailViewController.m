//
//  DispatchTicketDetailViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "DispatchTicketDetailViewController.h"
#import "TakeOrderQuotePriceDetailModel.h"
#import "OrderTakingQuotePriceDetailTableViewCell.h"
#import "DispatchTicketDetailBaoJiaTableViewCell.h"
#import "DispatchTicketDetailBaoJiaTableViewSectionView.h"

@interface DispatchTicketDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    DispatchTicketDetailBaoJiaTableViewSectionView *sectionView;
}

@property (strong,nonatomic) TakeOrderQuotePriceDetailModel *singleModel;

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@end

@implementation DispatchTicketDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    self.title = @"派单详情";
    //
    [self initOwnObjects];
    //
    [self addTableView:CGRectMake(0, 0, self.view.width, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    [self getData];
}

- (void)initOwnObjects{
    self.modelArr = [[NSMutableArray alloc]init];
}

- (void)getData{
    self.singleModel = [[TakeOrderQuotePriceDetailModel alloc] init];
    self.singleModel.image = [UIImage imageNamed:@"test07.jpg"];
    self.singleModel.timeStr = @"2018-6-6";
    self.singleModel.personNameStr = @"发起人名称";
    self.singleModel.detailStr = @"详细要求：工作要求详细要求：工作要求详细要求工作要求详细要求工作要求详细要求工作要求详细要求。";
    self.singleModel.praiseStr = @"成交价格：99+";
    self.singleModel.ticketsNumberStr = @"抢单名额 3/10";
    //
    for (int i = 0; i < 12; i ++){
        DispatchTicketDetailBaoJiaModel *model = [DispatchTicketDetailBaoJiaModel setModelFromDict:nil];
        [self.modelArr addObject:model];
    }
    //
    [self.tableView reloadData];
}



//views
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    //
    sectionView = [[DispatchTicketDetailBaoJiaTableViewSectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    sectionView.displayLabel.text = @"应征/报价列表";
    //
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 1;
            break;
        case 2:
            rows = self.modelArr.count;
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
    }else if(indexPath.section == 2){
        static NSString *cellFlag = @"cellFlag2";
        DispatchTicketDetailBaoJiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
        if (nil == cell){
            cell = [[DispatchTicketDetailBaoJiaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
        }
        cell.model = self.modelArr[indexPath.row];
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
    }else if (indexPath.section == 2){
        DispatchTicketDetailBaoJiaModel *model = self.modelArr[indexPath.row];
        height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[DispatchTicketDetailBaoJiaTableViewCell class] contentViewWidth:SCREEN_WIDTH];
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1){
        return sectionView.height;
    }else{
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1){
        return sectionView;
    }else{
        return nil;
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
