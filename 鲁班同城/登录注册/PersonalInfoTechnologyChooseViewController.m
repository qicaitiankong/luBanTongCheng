//
//  PersonalInfoTechnologyChooseViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "PersonalInfoTechnologyChooseViewController.h"

#import "ChooseTechnologyRightTableViewCell.h"
#import "ChooseTechnologyLeftTableViewCell.h"

@interface PersonalInfoTechnologyChooseViewController ()<UITableViewDelegate,UITableViewDataSource>{
    CGFloat leftCellHeight;
    CGFloat rightCellHeight;
    CGFloat leftCellWidth;
    CGFloat rightCellWidth;
    CGFloat spaceViewWidth;
    UIView *spaceView;
}

@property (strong,nonatomic) UITableView *leftTableView;

@property (strong,nonatomic) UITableView *rightTableView;

@property (strong,nonatomic) NSMutableArray *leftModelArr;

@property (strong,nonatomic) NSMutableArray *rightModelArr;

@property (strong,nonatomic) NSMutableArray *selectedModelArr;

@end

@implementation PersonalInfoTechnologyChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.kindTag == 1){
        self.title = @"技能列表";

    }else{
        self.title = @"工作列表";
    }
    [self initOwnObjects];
    WS(weakSelf);
    self.leftBarbuttBlock = ^{
        if (weakSelf.selectedBlock){
            for (ChooseTechnologyLeftModel *localModel in weakSelf.rightModelArr){
                if (localModel.judgeSelected){
                    [weakSelf.selectedModelArr addObject:localModel];
                }
            } weakSelf.selectedBlock(weakSelf.selectedModelArr);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self addViews];
    //
    [self hiddenTableView];
    //
    [self getFirstLevelData:YES];
}

- (void)initOwnObjects{
    self.leftModelArr = [[NSMutableArray alloc]init];
    self.rightModelArr = [[NSMutableArray alloc]init];
    self.selectedModelArr = [[NSMutableArray alloc]init];
    spaceViewWidth = 10;
    leftCellHeight = 40;
    rightCellHeight = 50;
    leftCellWidth = SCREEN_WIDTH * 0.293;
    rightCellWidth = SCREEN_WIDTH - leftCellWidth - spaceViewWidth;
}

- (void)hiddenTableView{
    self.leftTableView.hidden = YES;
    self.rightTableView.hidden = YES;
    spaceView.hidden = YES;
}

- (void)displayTableView{
    self.leftTableView.hidden = NO;
    self.rightTableView.hidden = NO;
    spaceView.hidden = NO;
}

//获取一级列表数据 isSecondLevelUseItsResult:二级列表是否需要使用一集列表的值
- (void)getFirstLevelData:(BOOL) isSecondLevelUseItsResult{
    if (self.kindTag == 1){//技能
        [TDHttpTools getTechnologyList:@{@"parentId":[NSNumber numberWithInteger:0]} success:^(id response) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            if ([dict allKeys]){
                    int status = [dict[@"status"] intValue];
                    if (status == 0){
                        NSLog(@"%@",dict);
                        NSArray *dataArr = dict[@"data"];
                        if (dataArr.count){
                            //tableview 显示打开
                            [self displayTableView];
                            
                        }
                        for (NSDictionary *modelDict in dataArr){
                            ChooseTechnologyLeftModel *localModel =  [ChooseTechnologyLeftModel setModelFromDict:modelDict];
                            [self.leftModelArr addObject:localModel];
                        }
                        if (isSecondLevelUseItsResult){
                            ChooseTechnologyLeftModel *localModel = self.leftModelArr[0];
                            localModel.judgeSelected = YES;
                            [self getSecondLevelData:localModel.idFlag];
                        }
                        //
                       
                    }else if (status == 1){
                        [SVProgressHUD showInfoWithStatus:@"获取失败"];
                    }
                  [self.leftTableView reloadData];
            }
        } failure:^(NSError *error) {
        }];
        
    }else if (self.kindTag == 2){
        [TDHttpTools getJobList:@{@"parentId":[NSNumber numberWithInteger:0]} success:^(id response) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            if ([dict allKeys]){
                int status = [dict[@"status"] intValue];
                if (status == 0){
                    NSLog(@"%@",dict);
                    NSArray *dataArr = dict[@"data"];
                    if (dataArr.count){
                        //tableview 显示打开
                        [self displayTableView];
                    }
                    for (NSDictionary *modelDict in dataArr){
                        ChooseTechnologyLeftModel *localModel =  [ChooseTechnologyLeftModel setModelFromDict:modelDict];
                        [self.leftModelArr addObject:localModel];
                    }
                    //
                    if (isSecondLevelUseItsResult && self.leftModelArr.count){
                        ChooseTechnologyLeftModel *localModel = self.leftModelArr[0];
                        localModel.judgeSelected = YES;
                        [self getSecondLevelData:localModel.idFlag];
                    }
                    
                }else if (status == 1){
                    [SVProgressHUD showInfoWithStatus:@"获取失败"];
                }
                 [self.leftTableView reloadData];
            }
        } failure:^(NSError *error) {
        }];
        
        
    }
}
//
- (void)getSecondLevelData:(NSInteger)index{
    [self.rightModelArr removeAllObjects];
    [self.rightTableView reloadData];
    //
    if (self.kindTag == 1){//技能
        [TDHttpTools getTechnologyList:@{@"parentId":[NSNumber numberWithInteger:index]} success:^(id response) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            if ([dict allKeys]){
                int status = [dict[@"status"] intValue];
                if (status == 0){
                    NSLog(@"！！！！！二级列表%@",dict);
                    NSArray *dataArr = dict[@"data"];
                    for (NSDictionary *modelDict in dataArr){
                       ChooseTechnologyLeftModel *localModel =  [ChooseTechnologyLeftModel setModelFromDict:modelDict];
                        [self.rightModelArr addObject:localModel];
                    }
                    
                }else if (status == 1){
                    [SVProgressHUD showInfoWithStatus:@"获取失败"];
                }
                [self.rightTableView reloadData];
            }
        } failure:^(NSError *error) {
        }];
        
    }else if (self.kindTag == 2){
        
        [TDHttpTools getJobList:@{@"parentId":[NSNumber numberWithInteger:index]} success:^(id response) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
            if ([dict allKeys]){
                int status = [dict[@"status"] intValue];
                if (status == 0){
                    NSLog(@"%@",dict);
                    NSArray *dataArr = dict[@"data"];
                    for (NSDictionary *modelDict in dataArr){
                       ChooseTechnologyLeftModel *localModel =  [ChooseTechnologyLeftModel setModelFromDict:modelDict];
                        [self.rightModelArr addObject:localModel];
                    }
                    [self.rightTableView reloadData];
                }else if (status == 1){
                    [SVProgressHUD showInfoWithStatus:@"获取失败"];
                }
                [self.rightTableView reloadData];
            }
            
        } failure:^(NSError *error) {
        }];
        
        
    }
}

- (void)addViews{
    //
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftCellWidth, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    self.leftTableView.tag = 1;
    self.leftTableView.backgroundColor = [UIColor whiteColor];
    self.leftTableView.tableFooterView = [[UITableView alloc]initWithFrame:CGRectZero];
    self.leftTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    [self.view addSubview:self.leftTableView];
    spaceView = [[UIView alloc]initWithFrame:CGRectMake(self.leftTableView.right, 0, spaceViewWidth, self.leftTableView.height)];
    spaceView.backgroundColor = [UIColor colorWithHexString:@"#78CAC5"];
    [self.view addSubview:spaceView];
    //
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(spaceView.right, 0, rightCellWidth, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    self.rightTableView.tag = 2;
    self.rightTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.rightTableView.backgroundColor = [UIColor whiteColor];
     self.rightTableView.tableFooterView = [[UITableView alloc]initWithFrame:CGRectZero];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    [self.view addSubview:self.rightTableView];
    //
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    //
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = 0;
    if (tableView.tag == 1){
        count = self.leftModelArr.count;
    }else{
        count = self.rightModelArr.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *parentCell = nil;
    if (tableView.tag == 1){
        static NSString *leftFlag = @"leftCell";
        ChooseTechnologyLeftTableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:leftFlag];
        if (nil == leftCell){
            leftCell = [[ChooseTechnologyLeftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftFlag];
        }
        leftCell.indexPath = indexPath;
        ChooseTechnologyLeftModel *model = self.leftModelArr[indexPath.row];
        leftCell.model = model;
        parentCell = leftCell;
    }else{
        static NSString *rightFlag = @"rightCell";
        ChooseTechnologyRightTableViewCell *rightCell = [tableView dequeueReusableCellWithIdentifier:rightFlag];
        if (nil == rightCell){
            rightCell = [[ChooseTechnologyRightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightFlag cellHeight:rightCellHeight cellWidth:rightCellWidth];
        }
        rightCell.indexPath = indexPath;
         ChooseTechnologyLeftModel *model = self.rightModelArr[indexPath.row];
        rightCell.model = model;
        parentCell = rightCell;
    }
    return parentCell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 2){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        ChooseTechnologyLeftModel *localModel = self.rightModelArr[indexPath.row];
        localModel.judgeSelected = !localModel.judgeSelected;
        //
        [self.rightTableView reloadData];
    }else{
        for (ChooseTechnologyLeftModel *localModel in self.leftModelArr){
            if (localModel.judgeSelected && (localModel.indexPath.row != indexPath.row)){
                localModel.judgeSelected = NO;
            }
            if (localModel.indexPath.row == indexPath.row){
                localModel.judgeSelected = YES;
            }
        }
        //
         [self.leftTableView reloadData];
        ChooseTechnologyLeftModel *localModel = self.leftModelArr[indexPath.row];
        NSLog(@"点击左边tableView时的索引:%ld parentID",indexPath.row,localModel.parentId);
        [self getSecondLevelData:localModel.idFlag];
        //
       
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if (tableView.tag == 1){
        height = leftCellHeight;
    }else{
        height = rightCellHeight;
    }
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
