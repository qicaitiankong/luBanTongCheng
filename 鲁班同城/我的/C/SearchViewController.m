//
//  SearchViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "SearchViewController.h"
#import "SSSearchBar.h"
#import "SearchBiaoQianSmallView.h"


@interface SearchViewController ()

@property (strong,nonatomic) SSSearchBar *headerView;

@end

@implementation SearchViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools hiddenNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [NavTools hiddenNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    //
    [self addViews];
}

- (void)addViews{
    //
    WS(weakSelf);
    CustomerImageButt *navReturnButt = [NavTools getOwnNavStyleGrayReturnButt];
    navReturnButt.clickButtBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:navReturnButt];
    
    self.headerView = [[SSSearchBar alloc] initWithFrame:CGRectMake(navReturnButt.right + 10, STATUSBAR_HEIGHT + 15, SCREEN_WIDTH - navReturnButt.right - 10 - 15, SCREEN_HEIGHT * 0.06)];
    self.headerView.isNeedSearch = YES;
    self.headerView.placeholder = @"输入搜索内容";
    self.headerView.clickTextFieldBlock = ^{

    };
    [self.view addSubview:self.headerView];
    //
    navReturnButt.center = CGPointMake(navReturnButt.centerX, self.headerView.centerY);
    //
    CGFloat viewWidth = 70;
    CGFloat viewHeight = 20;
    CGFloat leftBeginSpace = 20;
    CGFloat topBeginSpace = self.headerView.bottom + 25;
    CGFloat centerHorizotalSpace = (self.view.width - 3 * viewWidth - 2 * leftBeginSpace) / 3;
    CGFloat centerVerticalSpace = 10;
    for (int i = 0; i < 6; i ++){
        SearchBiaoQianSmallView *biaoQianView = [[SearchBiaoQianSmallView alloc]initWithFrame:CGRectMake(leftBeginSpace + (i % 3) *(viewWidth + centerHorizotalSpace), topBeginSpace + (i / 3) * (viewHeight + centerVerticalSpace) , viewWidth, viewHeight)];
        biaoQianView.rightDisplayLabel.text = @"关键词";
        [self.view addSubview:biaoQianView];

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
