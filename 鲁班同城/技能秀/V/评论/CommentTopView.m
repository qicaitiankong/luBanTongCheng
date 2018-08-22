//
//  CommentTopView.m
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CommentTopView.h"

@implementation CommentTopView
@synthesize cancelButt;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat cancelButtWidth = frame.size.height;
        
        self.leftDisplayLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.leftDisplayLabel.frame = CGRectMake(15, 0, frame.size.width - 15- 10 -  cancelButtWidth, frame.size.height);
        self.leftDisplayLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.leftDisplayLabel];
        //
        cancelButt = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButt.frame =  CGRectMake(frame.size.width - cancelButtWidth - 5, 0, cancelButtWidth, cancelButtWidth);
        cancelButt.center = CGPointMake(cancelButt.centerX, frame.size.height / 2);
        [cancelButt setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        [cancelButt addTarget:self action:@selector(clickCancelHandler) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButt];
        //
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0,frame.size.height - 1,frame.size.width,0.5);
        lineView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        [self addSubview:lineView];
    }
    return self;
}

- (void)clickCancelHandler{
    if (self.clickCancelBlock){
        self.clickCancelBlock();
    }
}


@end
