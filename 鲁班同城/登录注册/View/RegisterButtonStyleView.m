//
//  RegisterButtonStyleView.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "RegisterButtonStyleView.h"
@interface RegisterButtonStyleView (){
    UILabel *label;
    UIView *lineView;
    UIButton *backButt;
}
@end

@implementation RegisterButtonStyleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        backButt.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:backButt];
        [backButt addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 1)];
        label.backgroundColor = [UIColor whiteColor];
        UIColor *textColor = [UIColor colorWithHexString:@"#78CAC5"];
        label.textColor = textColor;
        label.text = @"立刻注册";
        label.font = [UIFont getPingFangSCMedium:11];
        [self addSubview:label];
        //
         lineView = [[UIView alloc] initWithFrame:CGRectMake(0, label.bottom, frame.size.width, 1)];
        lineView.backgroundColor = textColor;
        [self addSubview:lineView];
        
    }
    return self;
}


- (void)buttonClick{
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
