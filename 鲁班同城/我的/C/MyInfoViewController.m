//
//  MyInfoViewController.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyInfoTableViewCell.h"
#import "MyInfoTableHeaderView.h"

@interface MyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *cellTitleArr;
    NSMutableArray *cellImageArr;
    MyInfoTableHeaderView *headerView;
}

@property (strong,nonatomic) UITableView *tableView;

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initObject];
    [self addTableView:CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_WIDTH, CENTER_VIEW_HEIGHT + NAVIGATION_HEIGHT) style:UITableViewStylePlain];

}
- (void)initObject{
    cellImageArr = [[NSMutableArray alloc] init];
    cellTitleArr = @[@"收藏",@"搜索",@"个人资料",@"设置"];
    for (int i = 0; i < cellTitleArr.count; i ++){
        NSString *imageStr = [NSString stringWithFormat:@"set0%d",i];
        UIImage *image = [UIImage imageNamed:imageStr];
        [cellImageArr addObject:image];
    }
}

//view
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    headerView = [[MyInfoTableHeaderView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT / 2)];
    headerView.userNameLabel.text = @"昵称昵称昵称";
    headerView.commissionLabel.text = @"6666";
    [headerView.userImageView setImage:[UIImage imageNamed:@"test07.jpg"]];
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cellTitleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellFlag = @"cellFlag";
    MyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    if (nil == cell){
        cell = [[MyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag height:SCREEN_HEIGHT * 0.074];
    }
    UIImage *leftImage = cellImageArr[indexPath.row];
    NSString *title = cellTitleArr[indexPath.row];
    [cell.leftImageView setImage:leftImage];
    [cell.rightLabel setText:title];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT * 0.074;
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
