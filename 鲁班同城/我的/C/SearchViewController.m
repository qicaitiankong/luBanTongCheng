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
}


@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

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
    [self getData];
}

- (void)initOwnObjects{
    self.modelArr = [[NSMutableArray alloc]init];
}

- (void)getData{
    for (int i = 0; i < 20; i ++){
        TakeOrderMainHallModel *model = [TakeOrderMainHallModel setModelFromDict:nil];
        [self.modelArr addObject:model];
    }
    [self.tableView reloadData];
}

- (void)addViews{
     WS(weakSelf);
    //
    searchHeadView = [[searchHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT * 0.06)];
    searchHeadView.navReturnButt.clickButtBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    searchHeadView.searchView.placeholder = @"输入搜索内容";
    searchHeadView.searchView.clickTextFieldBlock = ^{
        
    };
    //
    searchFlagView = [[searchBiaoQianView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
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
