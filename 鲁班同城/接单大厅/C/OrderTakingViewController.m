//
//  OrderTakingViewController.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OrderTakingViewController.h"
//views
#import "SSSearchBar.h"
//vc
#import "SearchViewController.h"

#import "ZWMSegmentController.h"
#import "TakeorderSeveralCategoryViewController.h"

@interface OrderTakingViewController (){
    SSSearchBar *searchView;
}

@property (nonatomic, strong) ZWMSegmentController *segmentVC;




@end

@implementation OrderTakingViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([lzhGetAccountInfo getAccount].identityFlag){
        [self hiddenXuanFuButt];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools displayTabbar:self.rdv_tabBarController];
    if ([lzhGetAccountInfo getAccount].identityFlag){
        [self displayXuanFuButt];
    }else{
        [self hiddenXuanFuButt];
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //
    [self addTopSearchView];
    //
    [self addSeveralVC];
}

- (void)addTopSearchView{
    searchView = [[SSSearchBar alloc] initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_WIDTH,TAKE_ORDER_SEARCH_VIEW_HEIGHT)];
    WS(weakSelf);
    searchView.clickTextFieldBlock = ^{
        SearchViewController *searchVC = [[SearchViewController alloc]init];
        [weakSelf.navigationController pushViewController:searchVC animated:YES];
    };
    if ([lzhGetAccountInfo getAccount].identityFlag){
       searchView.placeholder = @"找零工上鲁班同城";
    }else{
        searchView.placeholder = @"找工作上鲁班同城";
    }
    [self.view addSubview:searchView];
}

- (void)addSeveralVC{
    NSArray *titleArr = @[@"全部",@"未报价",@"已报价",@"被雇佣",@"落选单"];
    self.segmentVC = [[ZWMSegmentController alloc] initWithFrame:CGRectMake(0, searchView.bottom, self.view.width, SCREEN_HEIGHT - searchView.bottom- TAB_BAR_HEIGHT) titles:titleArr];
    self.segmentVC.segmentView.showSeparateLine = YES;
    
    NSMutableArray *vcArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < titleArr.count; i ++){
        TakeorderSeveralCategoryViewController *takeSubVC = [[TakeorderSeveralCategoryViewController alloc]init];
        takeSubVC.flagVC = i;
        [vcArr addObject:takeSubVC];
    }
    self.segmentVC.viewControllers = [vcArr copy];
    if (vcArr.count==1) {
        self.segmentVC.segmentView.style=ZWMSegmentStyleDefault;
    } else {
        self.segmentVC.segmentView.style=ZWMSegmentStyleFlush;
    }
    [self addSegmentController:self.segmentVC];
    [self.segmentVC  setSelectedAtIndex:0];
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
