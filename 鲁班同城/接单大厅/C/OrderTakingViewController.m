//
//  OrderTakingViewController.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OrderTakingViewController.h"
//views
#import "TakeOrderTableViewCell.h"
#import "SSSearchBar.h"
//vc
#import "OrderTakingQuotePriceViewController.h"
#import "OrderTakingQuotePriceDetailViewController.h"
#import "SearchViewController.h"
#import "DispatchTicketDetailViewController.h"
#import "DispatchOrderMapViewController.h"

@interface OrderTakingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    __block BOOL isRefresh;//刷新标记
    __block BOOL isLoad;//加载标记
}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@property (strong,nonatomic) SSSearchBar *headerView;

@property (assign,nonatomic) int page;

@end

@implementation OrderTakingViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([lzhGetAccountInfo getAccount].identityFlag){
        [self hiddenXuanFuButt];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools displayTabbar:self.rdv_tabBarController];
    if ([lzhGetAccountInfo getAccount].identityFlag){
        [self displayXuanFuButt];
    }
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initObjects];
    
    [self addTableView:CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_WIDTH, CENTER_VIEW_HEIGHT + NAVIGATION_HEIGHT) style:UITableViewStylePlain];
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
//
- (void)getData:(int)page{
    if ([lzhGetAccountInfo getAccount].identityFlag == 0){//零工
        NSDictionary *paraDict = @{@"userId":[NSNumber numberWithInt:3],@"page":[NSNumber numberWithInt:page],@"size":[NSNumber numberWithInt:10]};
        [TDHttpTools getReceiveOrderList:paraDict success:^(id response) {
            NSDictionary *dict = response;
            if ([dict allKeys].count){
                NSLog(@"%@",dict);
                NSDictionary *dataDict = dict[@"data"];
                NSArray *dataArr = dataDict[@"list"];
                if (dataArr.count){
                    if (NO == self -> isLoad){
                        [self.modelArr removeAllObjects];
                    }
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
        } failure:^(NSError *error) {
            if (self->isLoad && self.page > 1){
                self.page --;
            }
            [self stopRefreshOrLoad];
            
        }];
        
    }else{//雇主
        NSDictionary *paraDict = @{@"userId":[NSNumber numberWithInt:1],@"page":[NSNumber numberWithInt:page],@"size":[NSNumber numberWithInt:10]};
        [TDHttpTools getLauchOrderList:paraDict success:^(id response) {
            NSDictionary *dict = response;
            if ([dict allKeys].count){
                NSLog(@"%@",dict);
                NSDictionary *dataDict = dict[@"data"];
                NSArray *dataArr = dataDict[@"list"];
                if (dataArr.count){
                    if (NO == self -> isLoad){
                        [self.modelArr removeAllObjects];
                    }
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
        } failure:^(NSError *error) {
            if (self->isLoad && self.page > 1){
                self.page --;
            }
            [self stopRefreshOrLoad];
            
        }];
    }
}
//events
//cell 发起按钮
- (void)clickCellButt:(NSIndexPath*)path{
    NSLog(@"%ld",path.row);
    if ([lzhGetAccountInfo getAccount].identityFlag){
        DispatchOrderMapViewController *mapVC = [[DispatchOrderMapViewController alloc]init];
        [self.navigationController pushViewController:mapVC animated:YES];
    }else{
        OrderTakingQuotePriceViewController *quotePriceVC = [[OrderTakingQuotePriceViewController alloc]init];
        [self.navigationController pushViewController:quotePriceVC animated:YES];
    }
}

//view
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    self.headerView = [[SSSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.06)];
    WS(weakSelf);
    self.headerView.clickTextFieldBlock = ^{
        SearchViewController *searchVC = [[SearchViewController alloc]init];
        [weakSelf.navigationController pushViewController:searchVC animated:YES];
    };
    if ([lzhGetAccountInfo getAccount].identityFlag){
        self.headerView.placeholder = @"找零工上鲁班同城";
    }else{
        self.headerView.placeholder = @"找工作上鲁班同城";
    }
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.tableHeaderView = self.headerView;
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
    if ([lzhGetAccountInfo getAccount].identityFlag){
         DispatchTicketDetailViewController *dispatchDetailVC = [[DispatchTicketDetailViewController alloc]init];
         TakeOrderMainHallModel *model = self.modelArr[indexPath.row];
        dispatchDetailVC.orderIdStr = [NSString stringWithFormat:@"%ld",model.orderID];
        [self.navigationController pushViewController:dispatchDetailVC animated:YES];
    }else{
        OrderTakingQuotePriceDetailViewController *orderDetailVC = [[OrderTakingQuotePriceDetailViewController alloc]init];
        TakeOrderMainHallModel *model = self.modelArr[indexPath.row];
        orderDetailVC.orderIdStr = [NSString stringWithFormat:@"%ld",model.orderID];
        [self.navigationController pushViewController:orderDetailVC animated:YES];
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
