//
//  CompanyRecuritDetailViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CompanyRecuritDetailViewController.h"
#import "CompanyRecuritDetailHeaderView.h"
#import "CompanyCruitDetailTableViewCell.h"
#import "CompanyCruitDetailModel.h"

@interface CompanyRecuritDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    CompanyRecuritDetailHeaderView *headerView;
}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@end

@implementation CompanyRecuritDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [NavTools displayNav:self.navigationController];
    [self addTableView:CGRectMake(0, 0, SCREEN_WIDTH, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    //
    [self initOwnObjects];
}

- (void)initOwnObjects{
    self.modelArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 30; i ++){
        CompanyCruitDetailModel *singleModel = [CompanyCruitDetailModel setModelFromDict:nil];
        [self.modelArr addObject:singleModel];
    }
    [self.tableView reloadData];
}
//
- (void)clickDetailButt:(NSIndexPath*)path{
    for (int i = 0; i < self.modelArr.count; i ++){
        CompanyCruitDetailModel *model = self.modelArr[path.row];
        
        if (i == path.row){
            model.isDetailDisplayState = !model.isDetailDisplayState;
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
    }
}

//
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    //
    headerView = [[CompanyRecuritDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    //
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.tableView.tableHeaderView = self.headerView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = headerView;
    [self.view addSubview:self.tableView];
    //
    [headerView.companyLogoImageView setImage:[UIImage imageNamed:@"test01"]];
    headerView.companyNameLabel.text = @"青岛鲁班同城";
    headerView.companyAddressLabel.text = @"山东李沧区";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellFlag = @"cellFlag";
    CompanyCruitDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    if (nil == cell){
        cell = [[CompanyCruitDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
        WS(weakSelf);
        cell.cliclDetailBlock = ^(NSIndexPath *path) {
            [weakSelf clickDetailButt:path];
        };
    }
    CompanyCruitDetailModel *model = self.modelArr[indexPath.row];
    cell.indexPath = indexPath;
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CompanyCruitDetailModel *model = self.modelArr[indexPath.row];
    CGFloat height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CompanyCruitDetailTableViewCell class] contentViewWidth:SCREEN_WIDTH];
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
