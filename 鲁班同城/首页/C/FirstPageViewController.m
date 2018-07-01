//
//  FirstPageViewController.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "FirstPageViewController.h"
//views
#import "JHCollectionViewCell.h"
#import "JHWaterfallCollectionLayout.h"

@interface FirstPageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,WaterFlowLayoutDelegate>{
    UICollectionView *mainCollectionView;
}

@property (strong,nonatomic) NSMutableArray *modelArr;

@end

@implementation FirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initObjects];
    [self addCollectionView];
    [self getData];
}

- (void)initObjects{
    self.modelArr = [[NSMutableArray alloc] init];
}

- (void)getData{
    for (int index = 0; index < 20; index ++){
        FirstPageInfoModel *webModel = [FirstPageInfoModel getModelFromDict:nil];
        if (index / 2){
            if (index < 10){
                 webModel.bigImage = [UIImage imageNamed:@"test02"];
            }else{
                 webModel.bigImage = [UIImage imageNamed:@"test03.jpg"];
            }

        }else{
            if (index > 10){
                 webModel.bigImage = [UIImage imageNamed:@"test04"];
            }else{
                 webModel.bigImage = [UIImage imageNamed:@"test05"];
            }

        }
        [webModel getImageDisplayHeight:webModel.bigImage];
        [self.modelArr addObject:webModel];
    }
    [mainCollectionView reloadData];
}

- (void)addCollectionView{
    JHWaterfallCollectionLayout* layout = [[JHWaterfallCollectionLayout alloc]init];
    layout.delegate = self ;
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,STATUSBAR_HEIGHT,SCREEN_WIDTH, CENTER_VIEW_HEIGHT + NAVIGATION_HEIGHT) collectionViewLayout:layout];
    mainCollectionView.backgroundColor = [UIColor clearColor];
    [mainCollectionView registerClass:[JHCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
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
    
    JHCollectionViewCell *cell = (JHCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    if (self.modelArr.count){
        FirstPageInfoModel *singleModel = self.modelArr[indexPath.row];
        cell.model = singleModel;
    }
    return cell;
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
