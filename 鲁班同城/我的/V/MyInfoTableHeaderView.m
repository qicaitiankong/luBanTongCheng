//
//  MyInfoTableHeaderView.m
//  鲁班同城
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MyInfoTableHeaderView.h"

@implementation MyInfoTableHeaderView
@synthesize backImageButt;


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        self.userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height * 0.05, frame.size.height * 0.36, frame.size.height * 0.36)];
        self.userImageView.backgroundColor = IMAGEVIEW_DEFAULT_COLOR;
        self.userImageView.center = CGPointMake(frame.size.width / 2, self.userImageView.centerY);
        self.userImageView.layer.cornerRadius = self.userImageView.width / 2;
        self.userImageView.clipsToBounds = YES;
        
        //
         backImageButt = [[CustomeStyleCornerButt alloc]initWithFrame:self.userImageView.frame backColor:[UIColor clearColor] cornerRadius:0 title:@"" titleColor:nil font:nil];
        [self addSubview:backImageButt];
        [self addSubview:self.userImageView];
        //
        self.userNameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:1];
        self.userNameLabel.frame = CGRectMake(0, self.userImageView.bottom + frame.size.height * 0.05, frame.size.width * 0.8, frame.size.height * 0.045);
        self.userNameLabel.center = CGPointMake(frame.size.width / 2, self.userNameLabel.centerY);
        [self addSubview:self.userNameLabel];
        //
        self.commissionLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCBold:58] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:1];
        self.commissionLabel.frame = CGRectMake(0,self.userNameLabel.bottom + frame.size.height * 0.1, frame.size.width * 0.5, frame.size.height * 0.15);
        self.commissionLabel.center = CGPointMake(frame.size.width / 2, self.commissionLabel.centerY);
        [self addSubview:self.commissionLabel];
        //
        self.commissionTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:2];
        self.commissionTipLabel.frame = CGRectMake(0,self.commissionLabel.bottom +  frame.size.height * 0.1, frame.size.width * 0.5, frame.size.height * 0.045);
        self.commissionTipLabel.text = @"我的佣金";
        [self addSubview:self.commissionTipLabel];
        //
        self.withDrawView = [[WithDrawView alloc] initWithFrame:CGRectMake(self.commissionTipLabel.right + 10, self.commissionTipLabel.top, 64, frame.size.height * 0.08)];
        self.withDrawView.center = CGPointMake(self.withDrawView.centerX, self.commissionTipLabel.centerY);
        [self addSubview:self.withDrawView];
    }
    return self;
}



@end
