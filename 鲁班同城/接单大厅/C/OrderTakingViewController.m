//
//  OrderTakingViewController.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OrderTakingViewController.h"
#import "DispatchTicketDetailViewController.h"

//views
#import "SSSearchBar.h"
#import "TakeOrderTableViewCell.h"

//vc
#import "SearchViewController.h"

#import "ZWMSegmentController.h"
#import "TakeorderSeveralCategoryViewController.h"

@interface OrderTakingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    SSSearchBar *searchView;
    __block BOOL isRefresh;//刷新标记
    __block BOOL isLoad;//加载标记
}

@property (nonatomic, strong) ZWMSegmentController *segmentVC;

//雇主版使用
@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

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
    }else{
        [self hiddenXuanFuButt];
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //
    [self addTopSearchView];
    //
    if ([lzhGetAccountInfo getAccount].identityFlag){
        searchView.placeholder = @"找零工上鲁班同城";
        [self addViewForEmployment];
    }else{
        searchView.placeholder = @"找工作上鲁班同城";
        [self addSeveralVC];
    }
}

- (void)addTopSearchView{
    searchView = [[SSSearchBar alloc] initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_WIDTH,TAKE_ORDER_SEARCH_VIEW_HEIGHT)];
    WS(weakSelf);
    searchView.clickTextFieldBlock = ^{
        SearchViewController *searchVC = [[SearchViewController alloc]init];
        [weakSelf.navigationController pushViewController:searchVC animated:YES];
    };
    [self.view addSubview:searchView];
}

//零工版
- (void)addSeveralVC{
    NSArray *titleArr = @[];
    NSMutableArray *vcArr = [[NSMutableArray alloc]init];
    titleArr = @[@"全部",@"未报价",@"已报价",@"被雇佣",@"落选单"];
    self.segmentVC = [[ZWMSegmentController alloc] initWithFrame:CGRectMake(0, searchView.bottom, self.view.width, SCREEN_HEIGHT - searchView.bottom- TAB_BAR_HEIGHT) titles:titleArr];
    self.segmentVC.segmentView.showSeparateLine = YES;
    for (int i = 0; i < titleArr.count; i ++){
        TakeorderSeveralCategoryViewController *takeSubVC = [[TakeorderSeveralCategoryViewController alloc]init];
        takeSubVC.flagVC = i;
        [vcArr addObject:takeSubVC];
    }
    
    self.segmentVC.viewControllers = [vcArr copy];
    if (vcArr.count==1) {
        self.segmentVC.segmentView.style=ZWMSegmentStyleDefault;
        self.segmentVC.segmentView.frame = CGRectZero;
    } else {
        self.segmentVC.segmentView.style=ZWMSegmentStyleFlush;
    }
    [self addSegmentController:self.segmentVC];
    [self.segmentVC  setSelectedAtIndex:0];
}

//雇主

- (void)getData:(int)page{
        NSDictionary *paraDict = @{@"key":@"",@"page":[NSNumber numberWithInt:page],@"pageSize":@10};
        [TDHttpTools getLauchOrderList:paraDict success:^(id response) {
            NSDictionary *dict = response;
            NSLog(@"雇主接单大厅%@",dict);
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
        } failure:^(NSError *error) {
            if (self->isLoad && self.page > 1){
                self.page --;
            }
            [self stopRefreshOrLoad];
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

- (void)clickCellButt:(NSIndexPath*)path{
    NSLog(@"%ld",path.row);
    if ([lzhGetAccountInfo getAccount].identityFlag){
        DispatchTicketDetailViewController *dispatchDetailVC = [[DispatchTicketDetailViewController alloc]init];
        TakeOrderMainHallModel *model = self.modelArr[path.row];
        dispatchDetailVC.orderId = model.orderID;
        [self.navigationController pushViewController:dispatchDetailVC animated:YES];
        
    }
}

- (void)initObjects{
    self.modelArr = [[NSMutableArray alloc] init];
    self.page = 1;
}
- (void)addViewForEmployment{
    [self initObjects];
    //
    [self addTableView:CGRectMake(0, searchView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-STATUSBAR_HEIGHT- searchView.height - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
   
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
    
    //获取数据
     [self getData:1];
    
}
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
