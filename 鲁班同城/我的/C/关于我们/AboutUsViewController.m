//
//  AboutUsViewController.m
//  鲁班同城
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "AboutUsViewController.h"
#import "SettingTableViewCell.h"

@interface AboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>{
     NSArray *titleArr;
}

@property (strong,nonatomic) UITableView *tableView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    titleArr = @[@"去评分",@"功能介绍"];
    
    [self addTableView:CGRectMake(0, 0, self.view.width, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
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
    //
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT * 0.32)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *baseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, headerView.height, headerView.height)];
    baseImageView.center = CGPointMake(headerView.width / 2, headerView.height / 2);
    
    [baseImageView setImage:[UIImage imageNamed:@"loginLogo"]];
    [headerView addSubview:baseImageView];
    self.tableView.tableHeaderView = headerView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellFlag = @"cellFlag";
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    if (nil == cell){
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag cellHeight:SCREEN_HEIGHT * 0.074];
    }
    NSString *title = titleArr[indexPath.row];
    cell.ownLeftLabel.text = [title copy];
    cell.ownRightLabel.hidden = YES;
    cell.ownRightLabel.text = @"";
    cell.goImageView.hidden = NO;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT * 0.074;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:{
            
        }
            break;
        case 1:{
        }
            break;
        default:
            break;
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
