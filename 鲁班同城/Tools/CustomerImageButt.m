//
//  CustomerImageButt.m
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CustomerImageButt.h"

@implementation CustomerImageButt

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor whiteColor];
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.imageView];
        //
        UIButton *backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        backButt.frame = self.imageView.frame;
        [backButt addTarget:self action:@selector(backButtHandler) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButt];
    }
    return self;
}

- (void)backButtHandler{
    if (self.clickButtBlock){
        self.clickButtBlock();
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
