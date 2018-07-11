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
#import "CompanyCruitDetailPictureTableViewCell.h"
#import "CompanyCruitDetailVedioTableViewCell.h"

#import "CompanyCruitDetailModel.h"

@interface CompanyRecuritDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    CompanyRecuritDetailHeaderView *headerView;
}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@property (strong,nonatomic) CompanyCruitDetailModel *pictureModel;

@property (strong,nonatomic) CompanyCruitDetailModel *videoModel;

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
    self.pictureModel = [CompanyCruitDetailModel setModelFromDict:nil];
    self.videoModel = [CompanyCruitDetailModel setModelFromDict:nil];
    for (int k = 0; k < 6; k ++){
         [self.pictureModel.imageUrlArr addObject:@"https://image.baidu.com"];
         [self.videoModel.imageUrlArr addObject:@"https://image.baidu.com"];
    }
    for (int i = 0; i < 6; i ++){
        CompanyCruitDetailModel *singleModel = [CompanyCruitDetailModel setModelFromDict:nil];
        [self.modelArr addObject:singleModel];
    }
    [self.tableView reloadData];
}
//
- (void)clickDetailButt:(NSIndexPath*)path{
    CompanyCruitDetailModel *model = self.modelArr[path.row];
    model.isDetailDisplayState = !model.isDetailDisplayState;
    [self.tableView reloadData];
}

//
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    //
    headerView = [[CompanyRecuritDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    //
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    //
    [headerView.companyLogoImageView setImage:[UIImage imageNamed:@"test01"]];
    headerView.companyNameLabel.text = @"青岛鲁班同城";
    headerView.companyAddressLabel.text = @"山东李沧区";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = self.modelArr.count;
            break;
        case 1:
            rows = 1;
            break;
        case 2:
            rows = 1;
            break;
        default:
            break;
    }
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *parentCell = nil;
    switch (indexPath.section) {
        case 0:{
            static NSString *cellFlag = @"cellFlag";
            CompanyCruitDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
            if (nil == cell){
                cell = [[CompanyCruitDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
                WS(weakSelf);
                cell.cliclDetailBlock = ^(NSIndexPath *path) {
                    [weakSelf clickDetailButt:path];
                };
            }
            cell.indexPath = indexPath;
            CompanyCruitDetailModel *model = self.modelArr[indexPath.row];
            cell.model = model;
            parentCell = cell;
        }
            break;
        case 1:{
            static NSString *cellFlag = @"cellFlag01";
            CompanyCruitDetailVedioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
            if (nil == cell){
                cell = [[CompanyCruitDetailVedioTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
            }
            CompanyCruitDetailModel *model = self.videoModel;;
            cell.model = model;
            parentCell = cell;
        }
             break;
        case 2:{
            static NSString *cellFlag = @"cellFlag02";
            CompanyCruitDetailPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
            if (nil == cell){
                cell = [[CompanyCruitDetailPictureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
            }
            CompanyCruitDetailModel *model = self.pictureModel;;
            cell.model = model;
            parentCell = cell;
        }
             break;
        default:
            break;
    }
    
    return parentCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    switch (indexPath.section) {
        case 0:{
            CompanyCruitDetailModel *model = self.modelArr[indexPath.row];
            height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CompanyCruitDetailTableViewCell class] contentViewWidth:SCREEN_WIDTH];
        }
            break;
        case 1:{
            CompanyCruitDetailModel *model = self.videoModel;
            height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CompanyCruitDetailVedioTableViewCell class] contentViewWidth:SCREEN_WIDTH];
        }
            break;
        case 2:{
            CompanyCruitDetailModel *model = self.pictureModel;
            height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CompanyCruitDetailPictureTableViewCell class] contentViewWidth:SCREEN_WIDTH];
        }
            break;
        default:
            break;
    }
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
