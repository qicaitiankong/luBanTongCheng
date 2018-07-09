//
//  SkillShowViewController.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "SkillShowViewController.h"
#import "SkillShowSecondViewController.h"

//views
#import "JHCollectionViewCell.h"
#import "JHWaterfallCollectionLayout.h"
//m
#import "FirstPageInfoModel.h"

//
@interface SkillShowViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,WaterFlowLayoutDelegate>{
    UICollectionView *mainCollectionView;
}

@property (strong,nonatomic) NSMutableArray *modelArr;

@end

@implementation SkillShowViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools displayTabbar:self.rdv_tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initObjects];
    [self addCollectionView];
    [self getData];
}
//
- (void)initObjects{
    self.modelArr = [[NSMutableArray alloc] init];
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


//
- (void)addCollectionView{
    JHWaterfallCollectionLayout* layout = [[JHWaterfallCollectionLayout alloc]init];
    layout.delegate = self ;
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, CENTER_VIEW_HEIGHT + NAVIGATION_HEIGHT + STATUSBAR_HEIGHT) collectionViewLayout:layout];
    mainCollectionView.backgroundColor = [UIColor clearColor];
    [mainCollectionView registerClass:[JHCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JHCollectionViewCell class])];
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    [self.view addSubview:mainCollectionView];
    
}

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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"row=%ld",indexPath.row);
    SkillShowSecondViewController *skillVC = [[SkillShowSecondViewController alloc]init];
    [self.navigationController pushViewController:skillVC animated:YES];

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
