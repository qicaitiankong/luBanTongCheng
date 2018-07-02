//
//  TraingleCategoryButtonGroupView.m
//  鲁班同城
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "TraingleCategoryButtonGroupView.h"
#import "TraingleCategorySmallButtonView.h"

@interface TraingleCategoryButtonGroupView (){
    NSMutableArray *viewArr;
}

@end

@implementation TraingleCategoryButtonGroupView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        viewArr = [[NSMutableArray alloc] init];
        
        for (short index = 0; index < 4; index ++){
            TraingleCategorySmallButtonView *smallView = [[TraingleCategorySmallButtonView alloc] init];
            smallView.clipsToBounds = YES;
            [viewArr addObject:smallView];
            [self addSubview:smallView];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        viewArr = [[NSMutableArray alloc] init];
        
        for (short index = 0; index < 4; index ++){
            TraingleCategorySmallButtonView *smallView = [[TraingleCategorySmallButtonView alloc] init];
            smallView.backButt.tag = index;
            
            [smallView.backButt addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
            [viewArr addObject:smallView];
            [self addSubview:smallView];
        }
        
        
        [self addOwnConstraints:frame.size.height];
    }
    return self;
}


- (void)addOwnConstraints:(CGFloat)height{
    CGFloat buttWidth = 0.186 * SCREEN_WIDTH;
    CGFloat buttHeight  = 0.75 * height;
    CGFloat horizontalSpace = (SCREEN_WIDTH - 4 * buttWidth) / 5;
    UIView *preferView = self;
    NSArray *titleArr = @[@"全青岛",@"职位类型",@"离我最近",@"筛选"];
    for (int i = 0; i < viewArr.count; i ++){
        TraingleCategorySmallButtonView *smallView = viewArr[i];
        smallView.leftLabel.text = [titleArr[i] copy];
        smallView.sd_layout
        .leftSpaceToView(preferView, horizontalSpace)
        .widthIs(buttWidth)
        .heightIs(buttHeight)
        .centerYIs(height / 2);
        smallView.layer.cornerRadius = 3;
        preferView = smallView;
    }
}

- (void)backButton:(UIButton*)_b{
     TraingleCategorySmallButtonView *smallView = viewArr[_b.tag];
    if (self.traingleButtBlock){
        self.traingleButtBlock(_b.tag,smallView.leftLabel);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
