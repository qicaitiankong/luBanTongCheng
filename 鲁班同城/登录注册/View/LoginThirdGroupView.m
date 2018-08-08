//
//  LoginThirdGroupView.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "LoginThirdGroupView.h"

@implementation LoginThirdGroupView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.wxButt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.wxButt.frame = CGRectMake(0, 0, 35, 35);
        self.wxButt.center = CGPointMake(self.wxButt.centerX,frame.size.height / 2);
        self.wxButt.backgroundColor = [UIColor whiteColor];
        [self.wxButt setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
        [self addSubview:self.wxButt];
        
        self.qqButt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.qqButt.frame = CGRectMake(self.wxButt.right + 80, 0, 35, 35);
        self.qqButt.center = CGPointMake(self.qqButt.centerX,frame.size.height / 2);
        self.qqButt.backgroundColor = [UIColor whiteColor];
        [self.qqButt setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
        [self addSubview:self.qqButt];
    }
    return self;
}

- (void)updateOwnContsaints{
    self.wxButt.sd_resetLayout
    .leftSpaceToView(self, 10)
    .heightRatioToView(self, 0.9)
    .widthEqualToHeight()
    .centerYEqualToView(self);
    
    self.qqButt.sd_resetLayout
    .rightSpaceToView(self, 10)
    .heightRatioToView(self, 0.9)
    .widthEqualToHeight()
    .centerYEqualToView(self);
}

- (void)updateOwnContsaintsWhenNoWeXin{
    self.qqButt.sd_resetLayout
    .centerXEqualToView(self)
    .heightRatioToView(self, 0.9)
    .widthEqualToHeight()
    .centerYEqualToView(self);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
