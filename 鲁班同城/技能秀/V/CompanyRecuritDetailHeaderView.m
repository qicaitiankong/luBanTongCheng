//
//  CompanyRecuritDetailHeaderView.m
//  鲁班同城
//
//  Created by apple on 2018/7/10.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CompanyRecuritDetailHeaderView.h"

@implementation CompanyRecuritDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //
        self.companyLogoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH * 0.133, SCREEN_WIDTH * 0.133)];
        self.companyLogoImageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.companyLogoImageView];
        //
        self.companyNameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.companyNameLabel.frame = CGRectMake(self.companyLogoImageView.right + 5, self.companyLogoImageView.top, frame.size.width - self.companyLogoImageView.right - 5 - 10, self.companyLogoImageView.height / 2);
        [self addSubview:self.companyNameLabel];
        //
        self.companyAddressLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:12] titleColor:[UIColor colorWithHexString:@"#999999"] aligement:0];
        self.companyAddressLabel.frame = CGRectMake(self.companyNameLabel.left, self.companyNameLabel.bottom, frame.size.width - self.companyNameLabel.left - 10, self.companyLogoImageView.height / 2);
        [self addSubview:self.companyAddressLabel];
        //
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(8,self.companyLogoImageView.bottom + 10, frame.size.width - 12,  1)];
        bottomLine.backgroundColor = [UIColor colorWithHexString:@"#BBBBBB"];
        [self addSubview:bottomLine];
        //
        [self setFrame:CGRectMake(self.x, self.y, self.width, bottomLine.bottom + 1)];
    }
    return self;
}

@end
