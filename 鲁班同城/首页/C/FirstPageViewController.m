//
//  FirstPageViewController.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "FirstPageViewController.h"
//
#import "DispatchOrderMapViewController.h"
#import "SearchViewController.h"
//
#import "GetLocationICitynfo.h"

//views
#import "JHCollectionViewCell.h"
#import "JHWaterfallCollectionLayout.h"
#import "FirstPageWaterCollectionReusableHeaderView.h"
#import "LaunchTicketOnWindowCircleButtView.h"

@interface FirstPageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,WaterFlowLayoutDelegate>{
    UICollectionView *mainCollectionView;
    //heder所有权
    FirstPageWaterCollectionReusableHeaderView *ownHeaderView;
    GetLocationICitynfo *locationInfo;
    
}

@property (strong,nonatomic) NSMutableArray *modelArr;

@end

@implementation FirstPageViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([lzhGetAccountInfo getAccount].identityFlag){
        [self hiddenXuanFuButt];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools hiddenNav:self.navigationController];
    [NavTools displayTabbar:self.rdv_tabBarController];
    if ([lzhGetAccountInfo getAccount].identityFlag){
        [self displayXuanFuButt];
    }else{
        [self hiddenXuanFuButt];
    }
    //
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    static BOOL isFirstCome = YES;
    if (isFirstCome){
        [self getLocationCity];
        isFirstCome = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createButtView];
    [self initObjects];
    [self addCollectionView];
    [self getData];
}
//
- (void)initObjects{
    self.modelArr = [[NSMutableArray alloc] init];
    locationInfo =  [[GetLocationICitynfo alloc]init];
}

//获取定位城市
- (void)getLocationCity{
    
    [locationInfo startLocation];
    WS(weakSelf);
    locationInfo.getLocationInfoBlock = ^{
        __strong typeof(weakSelf) sself = weakSelf;
        [sself -> ownHeaderView.searchView.locationCityButt setTitle:[GetLocationICitynfo getLocationInfo].cityStr forState:UIControlStateNormal];
    };
}




- (void)getData{
    for (int index = 0; index < 20; index ++){
        FirstPageInfoModel *webModel = [FirstPageInfoModel getModelFromDict:nil];
        if (index % 2){
            webModel.bigImage = [UIImage imageNamed:@"test02"];
        }else{
            webModel.bigImage = [UIImage imageNamed:@"test03"];
        }
        [webModel getImageDisplayHeight:webModel.bigImage];
        [self.modelArr addObject:webModel];
    }
    [mainCollectionView reloadData];
}

- (void)clickLocationCity:(UIButton*)targetButt{
    [self getLocationCity];
}

-(void)carouselTouch:(CXCarouselView *)carousel atIndex:(NSUInteger)index{
    NSLog(@"轮播%@",@(index).stringValue);
}

-(void)categoryButtonHandler:(NSInteger)tag{
    NSLog(@"分类按钮tag=%ld",tag);
}

- (void)traingleButtonHandler:(NSInteger)index targetView:(TraingleCategorySmallButtonView*)targetView{
    NSLog(@"筛选按钮组点击：%ld",index);
    if (index != 3){
        targetView.leftLabel.text = @"测试测试";
        [targetView adjustConstraintsAfterGiveTitle];
    }
}
//
- (void)addCollectionView{
    JHWaterfallCollectionLayout* layout = [[JHWaterfallCollectionLayout alloc]init];
    layout.delegate = self ;
    layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, SCREEN_HEIGHT * 0.518);
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, CENTER_VIEW_HEIGHT + NAVIGATION_HEIGHT + STATUSBAR_HEIGHT) collectionViewLayout:layout];
    mainCollectionView.backgroundColor = [UIColor clearColor];
    [mainCollectionView registerClass:[JHCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JHCollectionViewCell class])];
    mainCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [mainCollectionView registerClass:[FirstPageWaterCollectionReusableHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([FirstPageWaterCollectionReusableHeaderView class])];
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    [self.view addSubview:mainCollectionView];
}

#pragma mark - WaterFlowLayoutDelegate
- (CGFloat)waterFlowLayout:(JHWaterfallCollectionLayout *)waterFlowLayout heightForRowAtIndex:(NSInteger)index itemWidth:(CGFloat)width
{
    FirstPageInfoModel *singleModel = self.modelArr[index];
    return singleModel.bigImageDisplayHeight + 24;
}

//决定cell的列数
- (NSInteger)cloumnCountInWaterFlowLayout:(JHWaterfallCollectionLayout *)waterFlowLayout
{
    return  2 ;
}
//决定cell 的列的距离
- (CGFloat)columMarginInWaterFlowLayout:(JHWaterfallCollectionLayout *)waterFlowLayout
{
    return  3 ;
}

//决定cell 的行的距离
- (CGFloat)rowMarginInWaterFlowLayout:(JHWaterfallCollectionLayout *)waterFlowLayout
{
    return 3 ;
}

//决定cell 的边缘距
- (UIEdgeInsets)edgeInsetInWaterFlowLayout:(JHWaterfallCollectionLayout *)waterFlowLayout
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JHCollectionViewCell *cell = (JHCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JHCollectionViewCell class]) forIndexPath:indexPath];
    if (self.modelArr.count){
        FirstPageInfoModel *singleModel = self.modelArr[indexPath.row];
        cell.model = singleModel;
    }
    return cell;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    FirstPageWaterCollectionReusableHeaderView *header =nil;
    //返回段头段尾视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
         header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([FirstPageWaterCollectionReusableHeaderView class]) forIndexPath:indexPath];
        //获取头视图所有权
        ownHeaderView = header;
        WS(weakSelf);
        header.searchView.clickLocationCity = ^(UIButton *targetCityButton) {
            [weakSelf clickLocationCity:targetCityButton];
        };
        header.searchView.clickTextViewBlock = ^{
            SearchViewController *searchVC = [[SearchViewController alloc]init];
            [weakSelf.navigationController pushViewController:searchVC animated:YES];
        };
        header.traingleButtonGroupView.traingleButtBlock = ^(NSInteger index, TraingleCategorySmallButtonView *targetView) {
            [weakSelf traingleButtonHandler:index targetView:targetView];
        };
        
        //添加头视图的内容
        [header addConstraints];
    }
    return header;
}
//悬浮按钮
- (void)createButtView{
    if([lzhGetAccountInfo getAccount].identityFlag){
        self.xuanFubuttView = [[LaunchTicketOnWindowCircleButtView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - SCREEN_WIDTH * 0.24, SCREEN_HEIGHT - TAB_BAR_HEIGHT - SCREEN_WIDTH * 0.24 - 50, SCREEN_WIDTH * 0.24, SCREEN_WIDTH * 0.24)];
        UIWindow *appWindow = APP_MAIN_WINDOW;
        [appWindow addSubview:self.xuanFubuttView];
        WS(weakSelf);
        self.xuanFubuttView.clickButtBlock = ^{
             UINavigationController *currentNav = [NavTools currentNavgation:weakSelf.rdv_tabBarController];
            if (currentNav){
                DispatchOrderMapViewController *dispatchVC = [[DispatchOrderMapViewController alloc]init];
                [currentNav pushViewController:dispatchVC animated:YES];
            }else{
                //NSLog(@"悬浮按钮点击 当前导航栏为空");
            }
            //NSLog(@"悬浮按钮点击");
        };
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
