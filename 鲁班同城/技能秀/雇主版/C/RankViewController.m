//
//  RankViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "RankViewController.h"
#import "RankTableViewCell.h"
#import "ZHQScrollMenu.h"

#import "OwnPersonalInfomationViewController.h"

@interface RankViewController ()<UITableViewDelegate,UITableViewDataSource,categoryButtonClickDelegate>{
    ZHQScrollMenu *topScrollView;
    __block BOOL isRefresh;//刷新标记
    __block BOOL isLoad;//加载标记
}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *goodModelArr;

@property (strong,nonatomic) NSMutableArray *takeModelArr;
//0:好评,1:接单
@property (assign,nonatomic) NSInteger topSelectedFlag;

@property (assign,nonatomic) int goodPage;

@property (assign,nonatomic) int takePage;

@end

@implementation RankViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([lzhGetAccountInfo getAccount].identityFlag){
        [self hiddenXuanFuButt];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools displayNav:self.navigationController];
    [NavTools displayTabbar:self.rdv_tabBarController];
    if ([lzhGetAccountInfo getAccount].identityFlag){
        [self displayXuanFuButt];
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排行榜";
    [NavTools displayNav:self.navigationController];
    [NavTools displayTabbar:self.rdv_tabBarController];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initOwnObjects];
    //
    [self addTopScrollView];
    //
    [self addTableView:CGRectMake(0, topScrollView.bottom,self.view.width,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight - topScrollView.bottom - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(weakSelf) sself = weakSelf;
        sself -> isRefresh = YES;
        //
        if([ShareNetWorkState getNetState] == NO){
            [SVProgressHUD showErrorWithStatus:@"刷新失败，请检查网络"];
            [weakSelf stopRefreshOrLoad];
        }else{
                if (weakSelf.topSelectedFlag == 0){
                    weakSelf.goodPage = 1;
                    [weakSelf getData:weakSelf.goodPage];
                }else{
                    weakSelf.takePage = 1;
                    [weakSelf getData:weakSelf.takePage];
                }
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
                if (weakSelf.topSelectedFlag == 0){
                    weakSelf.goodPage ++;
                    sself -> isLoad = YES;
                    [weakSelf getData:weakSelf.goodPage];
                }else{
                    weakSelf.takePage ++;
                    sself -> isLoad = YES;
                    [weakSelf getTakeData:weakSelf.takePage];
                }
            }
        }
    }];
    //
    [self getData:1];
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

- (void)initOwnObjects{
    self.goodModelArr = [[NSMutableArray alloc]init];
    self.takeModelArr = [[NSMutableArray alloc]init];
}
//好评
- (void)getData:(NSInteger)page{
    //
    [TDHttpTools getRankList:@{@"rankType":[NSNumber numberWithInteger:0],@"page":[NSNumber numberWithInteger:page]} success:^(id response) {
        NSDictionary *webDict = response;
        NSDictionary *dataDict = webDict[@"data"];
        NSArray *listArr = dataDict[@"list"];
        if (listArr.count){
            if (NO == self -> isLoad){
                [self.goodModelArr removeAllObjects];
            }
            for (NSDictionary *localDict in listArr){
                RankModel *localModel = [RankModel setModelFromDict:localDict];
                [self.goodModelArr addObject:localModel];
            }
            //
          
        }else{
            if (self->isLoad && self.goodPage > 1){
                self.goodPage --;
            }
        }
        [self.tableView reloadData];
        [self stopRefreshOrLoad];
    } failure:^(NSError *error) {
        if (self->isLoad && self.goodPage > 1){
            self.goodPage --;
        }
         [self.tableView reloadData];
        [self stopRefreshOrLoad];
    }];
    
}
//接单榜
- (void)getTakeData:(NSInteger)page{
    //
    [TDHttpTools getRankList:@{@"rankType":[NSNumber numberWithInteger:1],@"page":[NSNumber numberWithInteger:page]} success:^(id response) {
        NSDictionary *webDict = response;
        NSDictionary *dataDict = webDict[@"data"];
        NSArray *listArr = dataDict[@"list"];
        if (listArr.count){
            if (NO == self -> isLoad){
                [self.takeModelArr removeAllObjects];
            }
            for (NSDictionary *localDict in listArr){
                RankModel *localModel = [RankModel setModelFromDict:localDict];
                [self.takeModelArr addObject:localModel];
            }
            //
            [self.tableView reloadData];
        }else{
            if (self->isLoad && self.takePage > 1){
                self.takePage --;
            }
        }
         [self.tableView reloadData];
        [self stopRefreshOrLoad];
    } failure:^(NSError *error) {
        if (self->isLoad && self.takePage > 1){
            self.takePage --;
        }
         [self.tableView reloadData];
        [self stopRefreshOrLoad];
    }];
    
}
-(void)categoryButtonHandler:(NSInteger)tag{
    self.topSelectedFlag = tag;
    if (tag == 0){
        [self getData:self.goodPage];
    }else{
        [self getTakeData:self.takePage];
    }
}

- (void)clickCellButt:(NSIndexPath*)path{
    RankModel *localModel = nil;
    if (self.topSelectedFlag == 0){
         localModel = self.goodModelArr[path.row];
    }else{
        localModel = self.takeModelArr[path.row];
    }
    OwnPersonalInfomationViewController *personalVC = [[OwnPersonalInfomationViewController alloc]init];
     personalVC.targetUserId = localModel.userIdNum;
    [self.navigationController pushViewController:personalVC animated:YES];
}


//view
- (void)addTopScrollView{
    topScrollView = [[ZHQScrollMenu alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50) delegate:self];
    topScrollView.lineColor = SPECIAL_BLUE_COLOR;
    topScrollView.norMalTitleColor = [UIColor colorWithRed:101.997/255.0 green:101.997/255.0 blue:101.997/255.0 alpha:1];
    topScrollView.changeTitleColor = SPECIAL_BLUE_COLOR;
    UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, topScrollView.width, 1)];
    topLineView.backgroundColor = [UIColor colorWithHexString:@"#DADADA"];
    [topScrollView addSubview:topLineView];
    [self.view addSubview:topScrollView];
    [topScrollView addButton:@[@"好评榜",@"接单榜"] titleFontSize:17];
    topScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    topScrollView.lineView.frame = CGRectMake(0, topScrollView.lineView.y, self.view.width / 2, 1);
    
}
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    self.tableView = [[UITableView alloc]initWithFrame:size style:styles];
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
    if (_topSelectedFlag == 0){
        return self.goodModelArr.count;
    }else{
        return self.takeModelArr.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellFlag = @"cellFlag";
    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    if (nil == cell){
        cell = [[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
        WS(weakSelf);
        cell.clickRightButtBlock = ^(NSIndexPath *path) {
            [weakSelf clickCellButt:path];
        };
    }
    cell.indexPath = indexPath;
    if (_topSelectedFlag == 0){
        RankModel *model = self.goodModelArr[indexPath.row];
        cell.model = model;
    }else{
        RankModel *model = self.takeModelArr[indexPath.row];
        cell.model = model;
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankModel *model = nil;
    if (_topSelectedFlag == 0){
        model  = self.goodModelArr[indexPath.row];
    }else{
        model = self.takeModelArr[indexPath.row];
    }
    CGFloat height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[RankTableViewCell class] contentViewWidth:SCREEN_WIDTH];
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
