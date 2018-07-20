//
//  MessageViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageModel.h"
#import "CommunicateViewController.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@end

@implementation MessageViewController

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
    self.title = @"消息";
    [self initOwnObjects];
    //
    [self addTableView:CGRectMake(0, 0, self.view.width, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    [self getData];
}
- (void)initOwnObjects{
    self.modelArr = [[NSMutableArray alloc]init];
}

- (void)getData{
    for (int i = 0; i < 20; i ++){
        MessageModel *localModel = [[MessageModel alloc]init];
        localModel.userImage = [UIImage imageNamed:@"test01"];
        localModel.nameStr = @"李丽";
        localModel.jobStr = @"鲁班同城·技术总监";
        localModel.messageStr = @"消息消息内容消息内容消息内容消息消息消息内容消息内容消息内";
        localModel.timeStr = @"6月4日";
        [self.modelArr addObject:localModel];
    }
    
    [self.tableView reloadData];
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
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    if (nil == cell){
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag cellHieght:SCREEN_HEIGHT *0.12];
    }
    MessageModel *localModel = self.modelArr[indexPath.row];
    cell.model = localModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT * 0.12;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //测试聊天
    CommunicateViewController *communicateVC = [[CommunicateViewController alloc]init];
    communicateVC.conversationType = 1;
    NSString *deviceID = VENDER_IDENTIFIER;
    NSString *lzhDeviceStr = @"6D74CBD6-1D81-45E0-B329-690CA31AF49C";
    if([deviceID isEqualToString:lzhDeviceStr]){
        communicateVC.targetId = @"TEST02-6D74CBD6-1D81-45E0-B329-690CA31AF49C";
        communicateVC.title = @"test02";
    }else{
        communicateVC.targetId = @"LZH-6D74CBD6-1D81-45E0-B329-690CA31AF49C";
        communicateVC.title = @"LZH";
    }
    
    [self.navigationController pushViewController:communicateVC animated:YES];
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
