//
//  WaterCellRecuritJobView.m
//  鲁班同城
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WaterCellRecuritJobView.h"

@implementation WaterCellRecuritJobView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.alpha = 0.75;
        self.leftPositionLabel = [[CustomeLzhLabel alloc
                                   ]initWithCustomerParamer:[UIFont getPingFangSCMedium:9] titleColor:[UIColor whiteColor] aligement:1];
        [self addSubview:self.leftPositionLabel];
        //
        self.rightCountLabel = [[CustomeLzhLabel alloc
                                   ]initWithCustomerParamer:[UIFont getPingFangSCMedium:9] titleColor:[UIColor whiteColor] aligement:1];
        [self addSubview:self.rightCountLabel];
    }
    return self;
}


- (void)LzhUpdateConstraints{
    self.leftPositionLabel.sd_resetLayout
    .widthRatioToView(self, 0.75)
    .leftEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self);
    
    self.rightCountLabel.sd_resetLayout
    .leftSpaceToView(self.leftPositionLabel, 0)
    .rightSpaceToView(self, 5)
    .topEqualToView(self)
    .bottomEqualToView(self);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
