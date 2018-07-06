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

}

@property (strong,nonatomic) UITableView *leftTableView;

@property (strong,nonatomic) UITableView *rightTableView;

@property (strong,nonatomic) NSMutableArray *leftModelArr;

@property (strong,nonatomic) NSMutableArray *rightModelArr;


@end

@implementation PersonalInfoTechnologyChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"技能";
    [self initOwnObjects];
    self.leftBarbuttBlock = ^{
    };
    self.rightBarbuttBlock = ^{
    };
    [self addViews];
}



- (void)initOwnObjects{
    self.leftModelArr = [[NSMutableArray alloc]init];
    
    spaceViewWidth = 10;
    leftCellHeight = 40;
    rightCellHeight = 50;
    leftCellWidth = SCREEN_WIDTH * 0.293;
    rightCellWidth = SCREEN_WIDTH - leftCellWidth - spaceViewWidth;
    for (int i = 0; i < 15; i ++){
        ChooseTechnologyLeftModel *localModel = [[ChooseTechnologyLeftModel alloc]init];
        localModel.title = @"分类1";
        [self.leftModelArr addObject:localModel];
    }
}

- (void)addViews{
    //
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftCellWidth, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    self.leftTableView.tag = 1;
    self.leftTableView.backgroundColor = [UIColor whiteColor];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    [self.view addSubview:self.leftTableView];
    UIView *spaceView = [[UIView alloc]initWithFrame:CGRectMake(self.leftTableView.right, 0, spaceViewWidth, self.leftTableView.height)];
    spaceView.backgroundColor = [UIColor colorWithHexString:@"#78CAC5"];
    [self.view addSubview:spaceView];
    //
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(spaceView.right, 0, rightCellWidth, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    self.rightTableView.tag = 2;
    self.rightTableView.backgroundColor = [UIColor whiteColor];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    [self.view addSubview:self.rightTableView];
    //
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = 0;
    if (tableView.tag == 1){
        count = self.leftModelArr.count;
    }else{
        count = 20;
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
        rightCell.jobNameLabel.text = @"瓦工";
        parentCell = rightCell;
    }
    return parentCell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 2){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }else{
        for (ChooseTechnologyLeftModel *localModel in self.leftModelArr){
            if (localModel.judgeSelected && (localModel.indexPath.row != indexPath.row)){
                localModel.judgeSelected = NO;
            }
            if (localModel.indexPath.row == indexPath.row){
                localModel.judgeSelected = YES;
            }
        }
        [self.leftTableView reloadData];
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
