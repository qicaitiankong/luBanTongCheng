//
//  TakeorderSeveralCategoryViewController.m
//  鲁班同城
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "TakeorderSeveralCategoryViewController.h"
//
#import "OrderTakingQuotePriceViewController.h"
#import "OrderTakingQuotePriceDetailViewController.h"
#import "TakeOrderTableViewCell.h"

@interface TakeorderSeveralCategoryViewController ()<UITableViewDelegate,UITableViewDataSource>{
    __block BOOL isRefresh;//刷新标记
    __block BOOL isLoad;//加载标记
    
}
@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@property (assign,nonatomic) int page;

@end

@implementation TakeorderSeveralCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initObjects];
    //
    [self addTableView:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUSBAR_HEIGHT - TAKE_ORDER_SEARCH_VIEW_HEIGHT - TAKE_ORDER_SEGUMENT_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    [self getData:1];
    //
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(weakSelf) sself = weakSelf;
        sself -> isRefresh = YES;
        //
        if([ShareNetWorkState getNetState] == NO){
            [SVProgressHUD showErrorWithStatus:@"刷新失败，请检查网络"];
            [weakSelf stopRefreshOrLoad];
        }else{
            weakSelf.page = 1;
            [weakSelf getData:weakSelf.page];
        }
    }];
    //
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(weakSelf) sself = weakSelf;

        //
        if([ShareNetWorkState getNetState] == NO){
            sself -> isLoad = YES;
            [SVProgressHUD showErrorWithStatus:@"加载失败，请检查网络"];
            [weakSelf stopRefreshOrLoad];
        }else{
            if (sself -> isLoad == NO){
                weakSelf.page ++;
                sself -> isLoad = YES;
                [weakSelf getData:weakSelf.page];
            }
        }
    }];
}


//停止刷新加载
- (void)stopRefreshOrLoad{
    
    if (isRefresh){
        [self.tableView.mj_header endRefreshing];
        isRefresh = NO;
    }
    if (isLoad){
        [self.tableView.mj_footer endRefreshing];
        isLoad = NO;
    }
}
//
- (void)initObjects{
    self.modelArr = [[NSMutableArray alloc] init];
    self.page = 1;
}

//处理接单大厅角标
- (void)displayJiaoBiao{
    NSInteger countNew = 0;
    if (self.flagVC == 0){//用全部处理
        for (TakeOrderMainHallModel *singleModel in self.modelArr){
            if (singleModel.canReceive){
                countNew ++;
            }
        }
    }
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.tabBarController.tabBar setBadgeDisplayByNum:countNew];
    //
}
//
- (void)getData:(int)page{
        NSDictionary *paraDict = @{@"key":@"",@"page":[NSNumber numberWithInt:page],@"pageSize":@10,@"type":[NSNumber numberWithInteger:self.flagVC]};
        
        [TDHttpTools getReceiveOrderList:paraDict success:^(id response) {
            NSDictionary *dict = response;
            NSLog(@"零工接单大厅%@",dict);
            
            if ([dict allKeys].count){
                NSDictionary *dataDict = dict[@"data"];
                NSArray *dataArr = dataDict[@"list"];
                if (NO == self -> isLoad){
                    [self.modelArr removeAllObjects];
                }
                if (dataArr.count){
                    
                    for (NSDictionary *singleDict in dataArr){
                        TakeOrderMainHallModel *model = [TakeOrderMainHallModel setModelFromDict:singleDict];
                        [self.modelArr addObject:model];
                    }
                    [self.tableView reloadData];
                }else{
                    if (self->isLoad && self.page > 1){
                        self.page --;
                    }
                }
                
            }else{
                if (self->isLoad && self.page > 1){
                    self.page --;
                }
            }
            [self stopRefreshOrLoad];
            //处理角标显示
            [self displayJiaoBiao];
        } failure:^(NSError *error) {
            if (self->isLoad && self.page > 1){
                self.page --;
            }
            [self stopRefreshOrLoad];
            NSLog(@"零工接单大厅");
            //处理角标显示
            [self displayJiaoBiao];
        }];
}

//events
//cell 发起按钮
- (void)clickCellButt:(NSIndexPath*)path{
    NSLog(@"%ld",path.row);
        TakeOrderMainHallModel *model = self.modelArr[path.row];
        if (model.canReceive){//抢单
            OrderTakingQuotePriceViewController *quotePriceVC = [[OrderTakingQuotePriceViewController alloc]init];
            quotePriceVC.isBapJiaDetail = NO;
            quotePriceVC.orderId = model.orderID;
            //刷新接单列表数据
            WS(weakSelf);
            quotePriceVC.refreshDataAfterTakeOrderBlock = ^{
                weakSelf.page = 1;
                [weakSelf.modelArr removeAllObjects];
                [weakSelf.tableView reloadData];
                [weakSelf getData:weakSelf.page];
            };
            [self.navigationController pushViewController:quotePriceVC animated:YES];
        }else{//查看
            if(model.isHiredMe){//跳恭喜雇佣界面
                OrderTakingQuotePriceDetailViewController *gongXiVC = [[ OrderTakingQuotePriceDetailViewController alloc]init];
                gongXiVC.orderId = model.orderID;
                gongXiVC.stateFlag = model.orderState;
                WS(weakSelf);
                gongXiVC.refreshDataAfterTakeOrderBlock = ^{
                    weakSelf.page = 1;
                    [weakSelf.modelArr removeAllObjects];
                    [weakSelf.tableView reloadData];
                    [weakSelf getData:weakSelf.page];
                };
                [self.navigationController pushViewController:gongXiVC animated:YES];
            }else{//跳报价详情界面
                OrderTakingQuotePriceViewController *orderDetailVC = [[OrderTakingQuotePriceViewController alloc]init];
                orderDetailVC.isBapJiaDetail = YES;
                orderDetailVC.orderId = model.orderID;
                WS(weakSelf);
                orderDetailVC.refreshDataAfterTakeOrderBlock = ^{
                    weakSelf.page = 1;
                    [weakSelf.modelArr removeAllObjects];
                    [weakSelf.tableView reloadData];
                    [weakSelf getData:weakSelf.page];
                };
                [self.navigationController pushViewController:orderDetailVC animated:YES];
                
            }
        }
}

//view
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellFlag = @"cellFlag";
    TakeOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    if (nil == cell){
        cell = [[TakeOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
        WS(weakSelf);
        cell.bottomButtBlock = ^(NSIndexPath *indexPath) {
            [weakSelf clickCellButt:indexPath];
        };
    }
    TakeOrderMainHallModel *model = self.modelArr[indexPath.row];
    cell.indexPath = indexPath;
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TakeOrderMainHallModel *model = self.modelArr[indexPath.row];
    CGFloat height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[TakeOrderTableViewCell class] contentViewWidth:SCREEN_WIDTH];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
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
