//
//  MyInfoTableFootView.m
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MyInfoTableFootView.h"
@interface MyInfoTableFootView ()


@end

@implementation MyInfoTableFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIColor *identitBackColor = [UIColor colorWithHexString:@"#EF8733"];
        UIColor *existLoginColor = [UIColor colorWithHexString:@"#78CAC5"];
        self.identityButtView = [[CustomeStyleCornerButt alloc] initWithFrame:CGRectMake(0, frame.size.height * 0.153, frame.size.width * 0.9, frame.size.height * 0.346) backColor:identitBackColor cornerRadius:5 title:@"切换为雇主身份" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:18]];
        self.identityButtView.center = CGPointMake(frame.size.width / 2, self.identityButtView.centerY);
        [self addSubview:self.identityButtView];
        //
        self.exitLoginButtView = [[CustomeStyleCornerButt alloc] initWithFrame:CGRectMake(0,self.identityButtView.bottom + frame.size.height * 0.153, frame.size.width * 0.9, frame.size.height * 0.346) backColor:existLoginColor cornerRadius:5 title:@"退出登录" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:18]];
        self.exitLoginButtView.center = CGPointMake(frame.size.width / 2, self.exitLoginButtView.centerY);
        [self addSubview:self.exitLoginButtView];
        
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
