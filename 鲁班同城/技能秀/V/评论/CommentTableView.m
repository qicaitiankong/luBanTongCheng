//
//  CommentTableView.m
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CommentTableView.h"

#import "CommentTopView.h"
#import "WriteCommentInputView.h"
#import "WriteCommentKeyboardPop.h"
#import "CommentTableViewCell.h"
#import "CommentAnswerTableView.h"


@interface CommentTableView ()<UITableViewDelegate,UITableViewDataSource>{
    UIButton *backButt;
    UIView *myParentView;
    CommentAnswerTableView *answerView;
}

@property (strong,nonatomic) CommentTopView *topView;

@property (strong,nonatomic) WriteCommentInputView * bottomInputView;

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@end

@implementation CommentTableView

- (instancetype)initWithFrame:(CGRect)frame parentView:(UIView*)parentView
{
    self = [super initWithFrame:frame];
    if (self) {
        myParentView = parentView;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.modelArr = [[NSMutableArray alloc]init];
        //
        backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        backButt.frame = CGRectMake(0, 0, frame.size.width, SCREEN_HEIGHT);
        [backButt addTarget:self action:@selector(backClickHander) forControlEvents:UIControlEventTouchUpInside];
        [parentView addSubview:backButt];
        //
        CGFloat bottomInputViewHeight = SCREEN_HEIGHT * 0.06;
        [self addTopView:CGRectMake(0, 0, frame.size.width, bottomInputViewHeight)];
        //
        [self initTableView:CGRectMake(0, self.topView.bottom, frame.size.width, frame.size.height - self.topView.height - bottomInputViewHeight)];
        //
        [self addBottomInputView:CGRectMake(0, self.tableView.bottom, frame.size.width, bottomInputViewHeight)];
        //
        [self getData];
    }
    return self;
}

//data
- (void)getData{
    for (int k = 0; k < 2; k ++){
        CommentModel *model = [CommentModel setModelFromDict:nil];
        [self.modelArr addObject:model];
    }
    [self.tableView reloadData];
}

- (void)clickGoodForComment:(NSIndexPath*)path{
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


- (void)answerHandler:(NSIndexPath*)path{
    NSLog(@"answerHandler点击的indexpath.row=%ld",path.row);
    answerView = [[CommentAnswerTableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, self.top, self.width, self.height)];
    [answerView giveTopSingleModel:self.modelArr[path.row]];
    [myParentView addSubview:answerView];
    [answerView showAnswetView];
    
}



- (void)backClickHander{
    if (answerView){
        [answerView dismissAnswerViewFromBottom];
        answerView = nil;
    }
    [self dismissCommentView];
   
    
}

//view
-(void)addTopView:(CGRect)frame{
    WS(weakSelf);
    self.topView = [[CommentTopView alloc]initWithFrame:frame];
    self.topView.leftDisplayLabel.text = @"6372条评论";
    self.topView.clickCancelBlock = ^{
        [weakSelf dismissCommentView];
    };
    [self addSubview:self.topView];
}

- (void)showCommentView{
    self->backButt.hidden = NO;
    self.hidden = NO;
    [UIView animateWithDuration:0.5f animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -self.height);
        
    } completion:^(BOOL finished) {
        
    }];
}


- (void)dismissCommentView{
    [UIView animateWithDuration:0.35 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self->backButt.hidden = YES;
    }];
}

- (void)addBottomInputView:(CGRect)rect{
    WS(weakSelf);
    self.bottomInputView = [[WriteCommentInputView alloc]initWithFrame:rect];
    self.bottomInputView.clickButtClick = ^{
        //NSLog(@"弹出键盘");
        [weakSelf showKeyBoard];
    };
    [self addSubview:self.bottomInputView];
}

- (void)showKeyBoard{
    [WriteCommentKeyboardPop showKeyBoardInputView:^(NSString *contentStr) {
        NSLog(@"点击了发布：%@",contentStr);
    } leftTextViewTipStr:@"优质评论将被优先展示" rightButtTitle:@"发布"];
    
}

//table view
- (void)initTableView:(CGRect)rect{
    self.tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellFlag = @"cell";
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    if (nil == cell){
        WS(weakSelf);
        cell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
        cell.clickAnswerBlock = ^(NSIndexPath *indexPath) {
            [weakSelf answerHandler:indexPath];
        };
        cell.clickGoodBlock = ^(NSIndexPath *indexPath) {
            [weakSelf clickGoodForComment:indexPath];
        };
    }
    cell.indexPath = indexPath;
    cell.model = self.modelArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView cellHeightForIndexPath:indexPath model:self.modelArr[indexPath.row] keyPath:@"model" cellClass:[CommentTableViewCell class] contentViewWidth:SCREEN_WIDTH];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}




@end
