//
//  EmploymentRecordViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "EmploymentRecordViewController.h"
#import "EmploymentRecordTableViewCell.h"
#import "EmploymentRecordModel.h"
#import "EmploymentRecordSectionView.h"

@interface EmploymentRecordViewController ()<UITableViewDelegate,UITableViewDataSource>{
    EmploymentRecordSectionView *sectionView;
      __block BOOL isRefresh;//刷新标记
}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@end

@implementation EmploymentRecordViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"雇佣记录";
    //
    [self initOwnObjects];
    //
    [self addTableView:CGRectMake(0, 0,self.view.width,CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    //
    [self getData];
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
            [weakSelf getData];
        }
    }];
    
}
//停止刷新加载
- (void)stopRefreshOrLoad{
    if (isRefresh){
        [self.tableView.mj_header endRefreshing];
        isRefresh = NO;
    }
}
- (void)initOwnObjects{
    self.modelArr = [[NSMutableArray alloc]init];
}

- (void)getData{
    //
    [TDHttpTools getGuYongRecordList:@{@"userId":[lzhGetAccountInfo getAccount].userID} success:^(id response) {
        NSDictionary *webDict = response;
        if ([[webDict allKeys] containsObject:@"data"]){
            NSArray *dataArr = webDict[@"data"];
            if(dataArr.count){
                    [self.modelArr removeAllObjects];
                    for (NSDictionary *localDict in dataArr){
                        EmploymentRecordModel *localModel = [EmploymentRecordModel setModelFromDict:localDict];
                        [self.modelArr addObject:localModel];
                    }
                   [self.tableView reloadData];
            }
        }
          [self stopRefreshOrLoad];
    } failure:^(NSError *error) {
          [self stopRefreshOrLoad];
    }];
}

- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    //
    sectionView = [[EmploymentRecordSectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    //
    self.tableView = [[UITableView alloc]initWithFrame:size style:styles];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    EmploymentRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    if (nil == cell){
        cell = [[EmploymentRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag cellHeight:150];
    }
    EmploymentRecordModel *model = self.modelArr[indexPath.row];
    
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    EmploymentRecordModel *model = self.modelArr[indexPath.row];
    return model.addressHeight + 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return sectionView;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return sectionView.height;
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
