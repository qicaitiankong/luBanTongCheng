//
//  OrderTakingViewController.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OrderTakingViewController.h"
#import "TakeOrderTableViewCell.h"
#import "SSSearchBar.h"

//views

@interface OrderTakingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@property (strong,nonatomic) SSSearchBar *headerView;

@end

@implementation OrderTakingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initObjects];
    
    [self addTableView:CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_WIDTH, CENTER_VIEW_HEIGHT + NAVIGATION_HEIGHT) style:UITableViewStylePlain];
    [self getData];
}
- (void)initObjects{
    self.modelArr = [[NSMutableArray alloc] init];
}
//
- (void)getData{
    for (int i = 0; i < 20; i ++){
        TakeOrderMainHallModel *model = [TakeOrderMainHallModel setModelFromDict:nil];
        [self.modelArr addObject:model];
    }
    [self.tableView reloadData];
}
//events
//cell 发起按钮
- (void)clickCellButt:(NSIndexPath*)path{
    NSLog(@"%ld",path.row);
}

//view
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    self.headerView = [[SSSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.06)];
    self.headerView.placeholder = @"找工作上鲁班同城";
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
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
