//
//  ConcernViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "ConcernViewController.h"
#import "ConcernTableViewCell.h"
#import "OwnPersonalInfomationViewController.h"

@interface ConcernViewController ()<UITableViewDelegate,UITableViewDataSource>{
    __block BOOL isRefresh;
}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;


@end

@implementation ConcernViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    self.title = @"我的关注";
    [self initOwnObjects];
    //
    [self addTableView:CGRectMake(0, 0, self.view.width, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    [self getData];
    
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
    if (self.modelArr.count == 0){
        [UIView showNullTipView:self.tableView];
    }else{
        [UIView hiddenNullTipView:self.tableView];
    }
}

- (void)initOwnObjects{
    self.modelArr = [[NSMutableArray alloc]init];
}

- (void)getData{
//    {
//        data =     {
//            key = "<null>";
//            list =         (
//                            {
//                                headImg = "";
//                                userId = 19;
//                                userName = "\U66f9\U5efa\U6d9b";
//                            }
    
    [TDHttpTools getMyConcernList:@{} success:^(id response) {
        NSLog(@"我的关注:%@",response);
        NSDictionary *dataDict = response[@"data"];
        
        NSArray *webDataArr = dataDict[@"list"];
         [self.modelArr removeAllObjects];
        if (webDataArr.count){
           
            for (NSDictionary *localDict in webDataArr){
                [self.modelArr addObject:[localDict copy]];
            }
        }else{
            
        }
        [self stopRefreshOrLoad];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self stopRefreshOrLoad];
    }];
}

//add views
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    ConcernTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    if (nil == cell){
        cell = [[ConcernTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag cellHieght:SCREEN_HEIGHT *0.12];
    }
    NSDictionary *singleDict = self.modelArr[indexPath.row];
    NSString *urlStr = [NSString getResultStrBySeverStr:singleDict[@"headImg"]];
    [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    cell.nameLabel.text = [NSString getResultStrBySeverStr:singleDict[@"userName"] ];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT * 0.12;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    OwnPersonalInfomationViewController *rankVC = [[OwnPersonalInfomationViewController alloc]init];
    NSDictionary *singleDict = self.modelArr[indexPath.row];
    rankVC.targetUserId = singleDict[@"userId"];
    [self.navigationController pushViewController:rankVC animated:YES];
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
