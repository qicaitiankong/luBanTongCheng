//
//  LoginOtherTipView.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "LoginOtherTipView.h"

@implementation LoginOtherTipView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *leftLine = [[UIView alloc] initWithFrame: CGRectMake(0,0,48,1)];
        leftLine.center = CGPointMake(leftLine.centerX, frame.size.height / 2);
        leftLine.backgroundColor = [UIColor colorWithRed:127.5/255.0 green:127.5/255.0 blue:127.5/255.0 alpha:1];
        [self addSubview:leftLine];
        //
        CGFloat tipViewWidth = [LzhReturnLabelHeight getLabelWidth:@"你还可以选择以下方式登录" font:[UIFont systemFontOfSize:10] targetHeight:10];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftLine.right, 0, tipViewWidth, 10)];
        label.text = @"您还可以选择以下方式登录";
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor colorWithRed:119.001/255.0 green:119.001/255.0 blue:119.001/255.0 alpha:1];
        [self addSubview:label];
        //
        UIView *rightLine = [[UIView alloc] init];
        rightLine.frame = CGRectMake(label.right,0,48,1);
        rightLine.center = CGPointMake(rightLine.centerX, frame.size.height / 2);
        rightLine.backgroundColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
        [self addSubview:rightLine];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
