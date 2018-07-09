//
//  CustomeLabelButt.m
//  鲁班同城
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CustomeLabelButt.h"

@interface CustomeLabelButt (){
    
}
@end


@implementation CustomeLabelButt

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //
        self.displayLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:15] titleColor:[UIColor colorWithHexString:@"#999999"] aligement:0];
        self.displayLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:self.displayLabel];
        //
        UIButton *backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        backButt.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [backButt addTarget:self action:@selector(backHandler) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButt];
    }
    return self;
}

- (void)backHandler{
    if (self.clickButtBlock){
        self.clickButtBlock();
    }
}


@end
