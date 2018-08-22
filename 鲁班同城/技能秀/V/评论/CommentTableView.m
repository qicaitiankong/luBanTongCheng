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

@interface CommentTableView ()<UITableViewDelegate,UITableViewDataSource>{
    
}

@property (strong,nonatomic) CommentTopView *topView;

@property (strong,nonatomic) WriteCommentInputView * bottomInputView;

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@end

@implementation CommentTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.modelArr = [[NSMutableArray alloc]init];
        //
        CGFloat bottomInputViewHeight = SCREEN_HEIGHT * 0.052;
        [self addTopView:CGRectMake(0, 0, frame.size.width, 60)];
        //
        [self initTableView:CGRectMake(0, self.topView.bottom, frame.size.width, frame.size.height - self.topView.height - bottomInputViewHeight - 15)];
        //
        [self addBottomInputView:CGRectMake(10, self.tableView.bottom, frame.size.width - 20, bottomInputViewHeight)];
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
- (void)dismissCommentView{
    [UIView animateWithDuration:0.35 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)addBottomInputView:(CGRect)rect{
    WS(weakSelf);
    self.bottomInputView = [[WriteCommentInputView alloc]initWithFrame:rect];
    self.bottomInputView.clickButtClick = ^{
        NSLog(@"弹出键盘");
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
        cell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
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
