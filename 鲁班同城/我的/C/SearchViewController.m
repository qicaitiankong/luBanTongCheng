//
//  SearchViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "SearchViewController.h"
//v
#import "searchHeaderView.h"
#import "TakeOrderTableViewCell.h"
#import "searchBiaoQianView.h"
//c
#import "OrderTakingQuotePriceViewController.h"
#import "OrderTakingQuotePriceDetailViewController.h"
//m
#import "TakeOrderMainHallModel.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>{
    searchHeaderView *searchHeadView;
    searchBiaoQianView *searchFlagView;
    UIView *biaoQianView;
    //
    __block BOOL isRefresh;//刷新标记
    __block BOOL isLoad;//加载标记
}


@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@property (assign,nonatomic) int page;

@property (strong,nonatomic) NSString *searchStr;

@end

@implementation SearchViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools hiddenNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [NavTools hiddenNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    //
    [self addViews];
    //
    [self initOwnObjects];
    //
    [self addTableView:CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_WIDTH, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT + NAVIGATION_HEIGHT) style:UITableViewStylePlain];
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
            [weakSelf getData:self.page searchStr:self.searchStr];
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
            if (sself -> isLoad == NO){//上次加载结束后本次加载才有效
                weakSelf.page ++;
                sself -> isLoad = YES;
                [weakSelf getData:self.page searchStr:self.searchStr];
            }
           
        }
    }];
}

- (void)initOwnObjects{
    self.modelArr = [[NSMutableArray alloc]init];
    self.page = 1;
    self.searchStr = @"";
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


- (void)getData:(int)page searchStr:(NSString*)keyStr{
    WS(weakSelf);
    if ([lzhGetAccountInfo getAccount].identityFlag == 0){//零工
        NSDictionary *paraDict = @{@"userId":[NSNumber numberWithInt:3],@"page":[NSNumber numberWithInt:page],@"size":[NSNumber numberWithInt:10],@"key":keyStr};
        [TDHttpTools getReceiveOrderList:paraDict success:^(id response) {
            NSDictionary *dict = response;
            if ([dict allKeys].count){
                NSLog(@"%@",dict);
                NSDictionary *dataDict = dict[@"data"];
                NSArray *dataArr = dataDict[@"list"];
                if (dataArr.count){
                    __strong typeof(weakSelf) sself  = weakSelf;
                    if(sself -> isLoad == NO){
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
        NSDictionary *paraDict = @{@"userId":[NSNumber numberWithInt:1],@"page":[NSNumber numberWithInt:page],@"size":[NSNumber numberWithInt:10],@"key":keyStr};
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

- (void)addViews{
     WS(weakSelf);
    //
    searchHeadView = [[searchHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT * 0.06)];
    searchHeadView.navReturnButt.clickButtBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    searchHeadView.searchView.placeholder = @"输入搜索内容";
    searchHeadView.searchView.searchTextFieldBlock = ^(NSString *targetStr) {
        __strong typeof(weakSelf) sself = weakSelf;
        if ((sself -> isRefresh == NO) && (sself -> isLoad == NO)){
            if(targetStr.length == 0){
                weakSelf.searchStr = SEARCH_NULL_FLAG_STR;
            }else{
                weakSelf.searchStr = targetStr;
            }
            weakSelf.page = 1;
            [weakSelf getData:weakSelf.page searchStr:weakSelf.searchStr];
        }
        
    };
    //
    searchFlagView = [[searchBiaoQianView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    searchFlagView.flagViewBlock = ^(NSString *flagStr) {
        __strong typeof(weakSelf) sself = weakSelf;
        if ([sself -> searchHeadView.searchView.textField isFirstResponder]){
            [sself -> searchHeadView.searchView.textField resignFirstResponder];
        }
        sself -> searchHeadView.searchView.textField.text = flagStr;
       
        if ((sself -> isRefresh == NO) && (sself -> isLoad == NO)){
            
            weakSelf.searchStr = flagStr;
            weakSelf.page = 1;
            [weakSelf getData:weakSelf.page searchStr:weakSelf.searchStr];
        }
    };
}

//cell 发起按钮
- (void)clickCellButt:(NSIndexPath*)path{
    NSLog(@"%ld",path.row);
    OrderTakingQuotePriceViewController *quotePriceVC = [[OrderTakingQuotePriceViewController alloc]init];
    [self.navigationController pushViewController:quotePriceVC animated:YES];
}
//
//view
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
   
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.tableHeaderView = searchHeadView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return 0;
    }else{
        return self.modelArr.count;

    }
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
    OrderTakingQuotePriceDetailViewController *orderDetailVC = [[OrderTakingQuotePriceDetailViewController alloc]init];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return searchFlagView;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return searchFlagView.height;
    }else{
        return 0;
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
