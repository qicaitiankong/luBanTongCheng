//
//  RankViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "RankViewController.h"
#import "RankTableViewCell.h"
#import "ZHQScrollMenu.h"


@interface RankViewController ()<UITableViewDelegate,UITableViewDataSource,categoryButtonClickDelegate>{
    ZHQScrollMenu *topScrollView;
}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;


@end

@implementation RankViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([lzhGetAccountInfo getAccount].identityFlag){
        [self hiddenXuanFuButt];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools displayNav:self.navigationController];
    [NavTools displayTabbar:self.rdv_tabBarController];
    if ([lzhGetAccountInfo getAccount].identityFlag){
        [self displayXuanFuButt];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排行榜";
    [NavTools displayNav:self.navigationController];
    [NavTools displayTabbar:self.rdv_tabBarController];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initOwnObjects];
    //
    [self addTopScrollView];
    //
    [self addTableView:CGRectMake(0, topScrollView.bottom,self.view.width,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight - topScrollView.bottom - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    //
    [self getData];
}

- (void)initOwnObjects{
    self.modelArr = [[NSMutableArray alloc]init];
}

- (void)getData{
    //
    for (int i = 0; i < 20; i ++){
        RankModel *localModel = [RankModel setModelFromDict:nil];
        [self.modelArr addObject:localModel];
    }
    //
    [self.tableView reloadData];
}

-(void)categoryButtonHandler:(NSInteger)tag{
    
}

//view
- (void)addTopScrollView{
    topScrollView = [[ZHQScrollMenu alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50) delegate:self];
    topScrollView.lineColor = SPECIAL_BLUE_COLOR;
    topScrollView.norMalTitleColor = [UIColor colorWithRed:101.997/255.0 green:101.997/255.0 blue:101.997/255.0 alpha:1];
    topScrollView.changeTitleColor = SPECIAL_BLUE_COLOR;
    UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, topScrollView.width, 1)];
    topLineView.backgroundColor = [UIColor colorWithHexString:@"#DADADA"];
    [topScrollView addSubview:topLineView];
    [self.view addSubview:topScrollView];
    [topScrollView addButton:@[@"好评榜",@"接单榜"] titleFontSize:17];
    topScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    topScrollView.lineView.frame = CGRectMake(0, topScrollView.lineView.y, self.view.width / 2, 1);
    
}
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    self.tableView = [[UITableView alloc]initWithFrame:size style:styles];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
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
    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    if (nil == cell){
        cell = [[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
        WS(weakSelf);
//        cell.bottomButtBlock = ^(NSIndexPath *indexPath) {
//            [weakSelf clickCellButt:indexPath];
//        };
    }
    RankModel *model = self.modelArr[indexPath.row];
    cell.indexPath = indexPath;
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankModel *model = self.modelArr[indexPath.row];
    CGFloat height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[RankTableViewCell class] contentViewWidth:SCREEN_WIDTH];
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
