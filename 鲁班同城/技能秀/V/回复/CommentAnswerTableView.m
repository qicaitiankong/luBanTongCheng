//
//  CommentAnswerTableView.m
//  鲁班同城
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CommentAnswerTableView.h"
#import "WriteCommentInputView.h"
#import "WriteCommentKeyboardPop.h"
#import "CommentTableViewCell.h"
#import "CommentTopView.h"
#import "CommentAnswerTableViewCell.h"


@interface CommentAnswerTableView ()<UITableViewDelegate,UITableViewDataSource>{
}

@property (strong,nonatomic) CommentTopView *topView;

@property (strong,nonatomic) CommentTopView *commentSectionView;

@property (strong,nonatomic) WriteCommentInputView * bottomInputView;

@property (strong,nonatomic) UITableView *tableView;

//data
@property (strong,nonatomic) CommentModel *singleModel;

@property (strong,nonatomic) NSMutableArray *modelArr;

@end


@implementation CommentAnswerTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.modelArr = [[NSMutableArray alloc]init];
        //
        CGFloat bottomInputViewHeight = SCREEN_HEIGHT * 0.06;
        [self addTopView:CGRectMake(0, 0, frame.size.width, 60)];
        //
        [self initTableView:CGRectMake(0, self.topView.bottom, frame.size.width, frame.size.height - self.topView.height - bottomInputViewHeight)];
        //
        [self addBottomInputView:CGRectMake(0, self.tableView.bottom, frame.size.width, bottomInputViewHeight)];
    }
    return self;
}


- (void)giveTopSingleModel:(CommentModel*)model{
    self.singleModel = model;
    [self.tableView reloadData];
    [self getData];
}
- (void)getData{
    for (int k = 0; k < 2; k ++){
        CommentModel *model = [CommentModel setModelFromDict:nil];
        model.isAnswerUse = YES;
        [self.modelArr addObject:model];
    }
    [self.tableView reloadData];
}

- (void)clickGoodForMainComment{
    NSLog(@"主评论点赞");
    self.singleModel.haveClickPraise = !self.singleModel.haveClickPraise;
    if (self.singleModel.haveClickPraise){
        NSInteger num =  [self.singleModel.praiseStr integerValue] + 1;
        self.singleModel.praiseStr = [NSString stringWithFormat:@"%ld",num];
    }else{
        NSInteger num =  [self.singleModel.praiseStr integerValue] - 1;
        self.singleModel.praiseStr = [NSString stringWithFormat:@"%ld",num];
    }
    [self.tableView reloadData];
}

- (void)clickGoodForAnswerComment:(NSIndexPath*)path{
    CommentModel *localModel = self.modelArr[path.row];
    NSLog(@"回复点赞");
    localModel.haveClickPraise = !localModel.haveClickPraise;
    if (localModel.haveClickPraise){
       NSInteger num =  [localModel.praiseStr integerValue] + 1;
        localModel.praiseStr = [NSString stringWithFormat:@"%ld",num];
    }else{
        NSInteger num =  [localModel.praiseStr integerValue] - 1;
        localModel.praiseStr = [NSString stringWithFormat:@"%ld",num];
    }
    [self.tableView reloadData];
}


-(void)addTopView:(CGRect)frame{
    WS(weakSelf);
    self.topView = [[CommentTopView alloc]initWithFrame:frame];
    self.topView.leftDisplayLabel.text = @"全部回复";
    self.topView.clickCancelBlock = ^{
        [weakSelf dismissAnswerView];
    };
    [self addSubview:self.topView];
}

- (void)showAnswetView{
    self.hidden = NO;
    [UIView animateWithDuration:0.5f animations:^{
        self.transform = CGAffineTransformMakeTranslation(-SCREEN_WIDTH, 0);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)addBottomInputView:(CGRect)rect{
    WS(weakSelf);
    self.bottomInputView = [[WriteCommentInputView alloc]initWithFrame:rect];
    self.bottomInputView.rightTipLabel.text = @"回复";
    self.bottomInputView.clickButtClick = ^{
        NSLog(@"弹出键盘");
        [weakSelf showKeyBoard];
    };
    [self addSubview:self.bottomInputView];
}

- (void)dismissAnswerView{
    [UIView animateWithDuration:0.35 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)dismissAnswerViewFromBottom{
    [UIView animateWithDuration:0.35 animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, 0, self.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showKeyBoard{
    [WriteCommentKeyboardPop showKeyBoardInputView:^(NSString *contentStr) {
        NSLog(@"点击了发布：%@",contentStr);
    } leftTextViewTipStr:@"优质评论将被优先展示" rightButtTitle:@"回复"];
}

//table view
- (void)initTableView:(CGRect)rect{
    self.commentSectionView = [[CommentTopView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 60)];
    self.commentSectionView.cancelButt.hidden = YES;
    self.commentSectionView.leftDisplayLabel.text = @"全部评论";
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 1, self.commentSectionView.width, 0.5)];
    topLine.backgroundColor =  [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [self.commentSectionView addSubview:topLine];
    
    self.tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 1;
            break;
        case 1:
            break;
        case 2:
            rows = self.modelArr.count;
            break;
        default:
            break;
    }
    
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *parentCell = nil;
    if(indexPath.section == 0){
        
        static NSString *cellFlag = @"cell01";
        CommentAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
        if (nil == cell){
            WS(weakSelf);
            cell = [[CommentAnswerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
            cell.concernButt.clickButtBlock = ^{
                weakSelf.singleModel.haveConcerned = !weakSelf.singleModel.haveConcerned;
                [weakSelf.tableView reloadData];
            };
            cell.clickGoodBlock = ^(NSIndexPath *indexPath) {
                [weakSelf clickGoodForMainComment];
            };
        }
        cell.indexPath = indexPath;
        cell.model = self.singleModel;
        parentCell = cell;
    }else if (indexPath.section == 2){
        static NSString *cellFlag = @"cell";
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
        if (nil == cell){
            WS(weakSelf);
            cell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
            cell.clickGoodBlock = ^(NSIndexPath *indexPath) {
                [weakSelf clickGoodForAnswerComment:indexPath];
            };
        }
        cell.indexPath = indexPath;
        cell.model = self.modelArr[indexPath.row];
        parentCell = cell;
    }
    return parentCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if (indexPath.section == 0){
         height =  [tableView cellHeightForIndexPath:indexPath model:self.singleModel keyPath:@"model" cellClass:[CommentAnswerTableViewCell class] contentViewWidth:SCREEN_WIDTH];
        
    }else if (indexPath.section == 2){
         height =  [tableView cellHeightForIndexPath:indexPath model:self.modelArr[indexPath.row] keyPath:@"model" cellClass:[CommentTableViewCell class] contentViewWidth:SCREEN_WIDTH];
    }
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = nil;
    switch (section) {
        case 0:
            break;
        case 1:
            sectionView = self.commentSectionView;
            break;
        case 2:
            break;
        default:
            break;
    }
    return sectionView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    switch (section) {
        case 0:
            break;
        case 1:
            height = self.commentSectionView.height;
            break;
        case 2:
            break;
        default:
            break;
    }
    return height;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
