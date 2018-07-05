//
//  CommitPopView.m
//  鲁班同城
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CommitPopView.h"

@implementation CommitPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        //
        UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 34, 43, 43)];
        logoImageView.center = CGPointMake(frame.size.width / 2, logoImageView.centerY);
        logoImageView.backgroundColor = [UIColor whiteColor];
        [logoImageView setImage:[UIImage imageNamed:@"sucsess"]];
        [self addSubview:logoImageView];
        //
        CGRect labelRect = CGRectMake(0, logoImageView.bottom + 17, frame.size.width, 16);
        UILabel *tipLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCBold:16] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:1];
        tipLabel.text = @"提交成功";
        tipLabel.frame = labelRect;
        [self addSubview:tipLabel];
        //
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, tipLabel.bottom + 30, frame.size.width, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
        [self addSubview:lineView];
        //
        UIButton *sureButt = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButt.backgroundColor = [UIColor whiteColor];
        sureButt.frame = CGRectMake(0, lineView.bottom + 30, 60, 30);
        sureButt.center = CGPointMake(frame.size.width / 2, sureButt.centerY);
        sureButt.layer.cornerRadius = 5;
        sureButt.layer.borderWidth = 2;
        sureButt.layer.borderColor = [UIColor colorWithHexString:@"#E3E3E3"].CGColor;
        [sureButt setTitle:@"确定" forState:UIControlStateNormal];
        [sureButt setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [sureButt addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureButt];
    }
    return self;
}


- (void)sureClick{
    if (self.sureBlock){
        self.sureBlock();
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
