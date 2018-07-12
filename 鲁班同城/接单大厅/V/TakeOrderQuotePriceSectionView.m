//
//  TakeOrderQuotePriceSectionView.m
//  鲁班同城
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "TakeOrderQuotePriceSectionView.h"

@implementation TakeOrderQuotePriceSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#DADADA"];
        [self addSubview:lineView];
        //
        self.tipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:15] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.tipLabel.frame = CGRectMake(20, lineView.bottom, frame.size.width - 40, frame.size.height - 1);
        [self addSubview:self.tipLabel];
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
