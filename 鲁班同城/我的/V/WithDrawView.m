//
//  WithDrawView.m
//  鲁班同城
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WithDrawView.h"

@interface WithDrawView (){
    UIImageView *leftImageView;
    UILabel *rightLabel;
    UIButton *backButt;
}
@end

@implementation WithDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.cornerRadius = 4;
        
        self.backgroundColor = [UIColor whiteColor];
        leftImageView = [[UIImageView alloc] init];
        leftImageView.backgroundColor = [UIColor whiteColor];
        [leftImageView setImage:[UIImage imageNamed:@"withDraw"]];
        [self addSubview:leftImageView];
        //
        rightLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        rightLabel.backgroundColor = [UIColor whiteColor];
        rightLabel.text = @"提现";
        [self addSubview:rightLabel];
        //
        backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButt addTarget:self action:@selector(backButtHandler) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButt];
        //
        leftImageView.sd_layout.leftSpaceToView(self, 5)
        .widthIs(15)
        .heightIs(16)
        .centerYEqualToView(self);
        
        rightLabel.sd_layout
        .leftSpaceToView(leftImageView, 5)
        .widthIs(35)
        .heightIs(frame.size.height * 0.8)
        .centerYEqualToView(self);
        
        backButt.sd_layout
        .leftEqualToView(self)
        .rightEqualToView(self)
        .topEqualToView(self)
        .bottomEqualToView(leftImageView);
    }
    return self;
}


- (void)backButtHandler{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
