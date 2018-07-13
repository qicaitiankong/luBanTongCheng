//
//  SettingViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "MessageFeedBackViewController.h"


@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *titleArr;
}

@property (strong,nonatomic) UITableView *tableView;

@end

@implementation SettingViewController

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
    self.title = @"设置";
    //
    [self addTableView:CGRectMake(0, 0, self.view.width, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    [self getData];
}

- (void)getData{
    titleArr = @[@"清理缓存",@"信息反馈",@"使用帮助",@"APP介绍"];
    [self.tableView reloadData];
}

//add views
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
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
    if (indexPath.row == 0){
        //显示缓存
        cell.ownRightLabel.hidden = NO;
        cell.ownRightLabel.text = @"30M";
        cell.goImageView.hidden = YES;
    }else{
        cell.ownRightLabel.hidden = YES;
        cell.ownRightLabel.text = @"";
        cell.goImageView.hidden = NO;
    }
    
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
            MessageFeedBackViewController *messageVC = [[MessageFeedBackViewController alloc]init];
            [self.navigationController pushViewController:messageVC animated:YES];
        }
            break;
        case 2:{
        
        }
            break;
        case 3:{
            
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
