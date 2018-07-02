//
//  ConcernDisplayView.m
//  鲁班同城
//
//  Created by apple on 2018/7/1.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ConcernDisplayView.h"

@implementation ConcernDisplayView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.leftImageView = [[UIImageView alloc]init];
        self.leftImageView.backgroundColor = [UIColor whiteColor];
        [self.leftImageView setImage:[UIImage imageNamed:@"heart"]];
        [self addSubview:self.leftImageView];
        //
        self.rightNumLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:9] titleColor:[UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1] aligement:0];
        [self addSubview:self.rightNumLabel];
    }
    return self;
}

- (void)addOwnConstraints{
    self.leftImageView.sd_layout
    .leftEqualToView(self)
    .widthIs(14)
    .heightIs(12)
    .centerXEqualToView(self)
    .centerYEqualToView(self);
    
    self.rightNumLabel.sd_layout
    .leftSpaceToView(self.leftImageView, 5)
    .rightSpaceToView(self, 2)
    .heightRatioToView(self, 0.9)
    .centerYEqualToView(self);
}





@end
