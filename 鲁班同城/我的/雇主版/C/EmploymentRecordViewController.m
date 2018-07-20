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
}

- (void)initOwnObjects{
    self.modelArr = [[NSMutableArray alloc]init];
}

- (void)getData{
    //
    for (int i = 0; i < 20; i ++){
        EmploymentRecordModel *localModel = [EmploymentRecordModel setModelFromDict:nil];
        [self.modelArr addObject:localModel];
    }
    //
    [self.tableView reloadData];
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
    return 150;
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
