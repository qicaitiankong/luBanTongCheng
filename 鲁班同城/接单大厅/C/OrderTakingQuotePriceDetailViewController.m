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


@interface OrderTakingQuotePriceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIScrollView *baseScrollView;
    TakeOrderQuotePriceDetaiSectionView *sectionView;
}

@property (strong,nonatomic) TakeOrderQuotePriceDetailModel *singleModel;

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@end

@implementation OrderTakingQuotePriceDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    //
    self.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initOwnObjects];
    //
     [self addTableView:CGRectMake(0, 0,self.view.width,CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
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
    NSArray *bottomTitleArr = @[@"电话",@"地址",@"备注"];
    NSArray *bottomTitleArr2 = @[@"18633355555",@"青岛市-李沧区某某路12号12单元12户",@"注意事项需要准备什么注意事项需要准备，什么注意事项需要准备什么"];
    for (int k = 0; k < bottomTitleArr.count; k ++){
        TakeOrderQuotePriceDetailModel *model = [[TakeOrderQuotePriceDetailModel alloc]init];
        model.personInfoTipStr = bottomTitleArr[k];
        model.personInfoStr = bottomTitleArr2[k];
        [self.modelArr addObject:model];
    }
    //
    [self.tableView reloadData];
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
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    if (section == 0){
        rows = 1;
    }else{
        rows = self.modelArr.count;
        NSLog(@"rows=%ld",rows);
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
    }else{
        if (indexPath.row < 2){
            static NSString *cellFlag = @"cellFlag02";
            OrderTakingQuotePriceDetailTelephoneTableViewCell
            *cell02 = [tableView dequeueReusableCellWithIdentifier:cellFlag];
            if (nil == cell02){
                cell02 = [[OrderTakingQuotePriceDetailTelephoneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag isNeedRightButt:YES];
            }
            cell02.model = self.modelArr[indexPath.row];
            parentCell = cell02;
        }else{
            static NSString *cellFlag = @"cellFlag03";
            OrderTakingQuotePriceDetailTelephoneTableViewCell
            *cell03 = [tableView dequeueReusableCellWithIdentifier:cellFlag];
            if (nil == cell03){
                cell03 = [[OrderTakingQuotePriceDetailTelephoneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag isNeedRightButt:NO];
            }
            cell03.model = self.modelArr[indexPath.row];
            parentCell = cell03;
        }
    }
    return parentCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if (indexPath.section == 0){
        TakeOrderQuotePriceDetailModel *model = self.singleModel;
        height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderTakingQuotePriceDetailTableViewCell class] contentViewWidth:SCREEN_WIDTH];
    }else{
        TakeOrderQuotePriceDetailModel *model = self.modelArr[indexPath.row];
        height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderTakingQuotePriceDetailTelephoneTableViewCell class] contentViewWidth:SCREEN_WIDTH];
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return nil;
    }else{
        return sectionView;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 0;
    }else{
        return sectionView.height;
    }
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
