//
//  OrderTakingQuotePriceViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OrderTakingQuotePriceViewController.h"
#import "TakeOrderQuotePriceTableViewCell.h"
#import "TakeOrderQuotePriceQiangBiaoTableViewCell.h"
#import "TakeOrderQuotePriceSectionView.h"

@interface OrderTakingQuotePriceViewController ()<UITableViewDelegate,UITableViewDataSource>{
    TakeOrderQuotePriceSectionView *sectionView;
}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@property (strong,nonatomic) TakeOrderQuotePriceModel *singleModel;

@end

@implementation OrderTakingQuotePriceViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [NavTools hiddenTabbar:self.rdv_tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    //
    self.title = @"报价";
    self.view.backgroundColor = [UIColor whiteColor];
    //
    [self initOwnObjects];
    //
    [self addTableView:CGRectMake(0, 0,self.view.width,CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    //
    [self getData];
}

- (void)initOwnObjects{
    self.modelArr = [[NSMutableArray alloc]init];
}

- (void)getData{
    self.singleModel = [[TakeOrderQuotePriceModel alloc] init];
    self.singleModel.image = [UIImage imageNamed:@"test07.jpg"];
    self.singleModel.timeStr = @"2018-6-6";
    self.singleModel.personNameStr = @"发起人名称";
    self.singleModel.detailStr = @"详细要求：工作要求详细要求：工作要求详细要求工作要求详细要求工作要求详细要求工作要求详细要求。";
    self.singleModel.praiseStr = @"成交价格：99+";
    self.singleModel.ticketsNumberStr = @"抢单名额 3/10";
    self.singleModel.imageUrls = [[NSMutableArray alloc]init];
    for(int k = 0; k < 6; k ++){
        [self.singleModel.imageUrls addObject:@"https://image.baidu.com/search/detail?"];
    }
    //
    for (int i = 0; i < 20; i ++){
        TakeOrderQuotePriceModel *localModel = [TakeOrderQuotePriceModel setModelFromDict:nil];

        [self.modelArr addObject:localModel];
    }
    //
    [self.tableView reloadData];
    
}


//views
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    //
    sectionView = [[TakeOrderQuotePriceSectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
    sectionView.tipLabel.text = @"抢标列表";
    //
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
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
    }
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *parentCell = nil;
    if (indexPath.section == 0){
            static NSString *cellFlag = @"cellFlag";
            TakeOrderQuotePriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
            if (nil == cell){
                cell = [[TakeOrderQuotePriceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
            }
        
            cell.model = self.singleModel;
            parentCell = cell;
    }else{
        static NSString *cellFlag = @"cellFlag02";
        TakeOrderQuotePriceQiangBiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
        if (nil == cell){
            cell = [[TakeOrderQuotePriceQiangBiaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag cellHeight:SCREEN_HEIGHT * 0.12];
        }
        cell.model = self.modelArr[indexPath.row];
        parentCell = cell;
    }
    return parentCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if (indexPath.section == 0){
        TakeOrderQuotePriceModel *model = self.singleModel;
       height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[TakeOrderQuotePriceTableViewCell class] contentViewWidth:SCREEN_WIDTH];
    }else{
        height = SCREEN_HEIGHT * 0.12;
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
