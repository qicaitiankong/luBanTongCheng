//
//  PersonalInfoTechnologyChooseViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "PersonalInfoTechnologyChooseViewController.h"

@interface PersonalInfoTechnologyChooseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *leftTableView;


@property (strong,nonatomic) UITableView *rightTableView;

@end

@implementation PersonalInfoTechnologyChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftBarbuttBlock = ^{
    };
    self.rightBarbuttBlock = ^{
    };
    [self addViews];
}

- (void)addViews{
    //
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.293, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    self.leftTableView.tag = 1;
    self.leftTableView.backgroundColor = [UIColor whiteColor];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    [self.view addSubview:self.leftTableView];
    //
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.leftTableView.right + 10, 0, self.view.width - self.leftTableView.left - self.leftTableView.width - 10, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
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
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *parentCell = nil;
    if (tableView.tag == 1){
        static NSString *leftFlag = @"leftCell";
        UITableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:leftFlag];
        if (nil == leftCell){
            leftCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftFlag];
        }
        leftCell.textLabel.text = @"分类1";
        parentCell = leftCell;
    }else{
        static NSString *rightFlag = @"rightCell";
        UITableViewCell *rightCell = [tableView dequeueReusableCellWithIdentifier:rightFlag];
        if (nil == rightCell){
            rightCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightFlag];
        }
        rightCell.textLabel.text = @"瓦工";
        parentCell = rightCell;
    }
    return parentCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
