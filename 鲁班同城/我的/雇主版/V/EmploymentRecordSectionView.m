//
//  EmploymentRecordSectionView.m
//  鲁班同城
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "EmploymentRecordSectionView.h"

@implementation EmploymentRecordSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(242, 242, 242, 1);
        self.displayLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#999999"] aligement:0];
        self.displayLabel.frame = CGRectMake(15, 0, frame.size.width - 30, frame.size.height);
        self.displayLabel.backgroundColor = self.backgroundColor;
        [self addSubview:self.displayLabel];
        self.displayLabel.text = @"已完成";
    }
    return self;
}

@end
