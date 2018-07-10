//
//  DetailSmallButtView.m
//  鲁班同城
//
//  Created by apple on 2018/7/10.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "DetailSmallButtView.h"

@interface DetailSmallButtView (){
    CGFloat labelHeight;
    UIImage *rightImage;
}
@end

@implementation DetailSmallButtView
@synthesize backButt;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        labelHeight = frame.size.height;
        //
        self.backgroundColor = [UIColor whiteColor];
        self.leftLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        //
        self.leftLabel.frame = CGRectMake(0, 0, frame.size.width * 0.7, frame.size.height);
        self.leftLabel.text = @"详情";
        [self addSubview:self.leftLabel];
        //
        rightImage = [UIImage imageNamed:@"pullDown@3x.png"];
        self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.leftLabel.right + 5, 0, 10, 6)];
        self.rightImageView.backgroundColor = [UIColor whiteColor];
        self.rightImageView.center = CGPointMake(self.rightImageView.centerX, frame.size.height / 2);
        [self.rightImageView setImage:rightImage];
        [self addSubview:self.rightImageView];
        //
        //
        backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        backButt.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:backButt];
    }
    return self;
}


- (void)setPullUpState{
    [self.rightImageView setImage:[UIImage imageNamed:@"pullUp"]];
}

- (void)setPullDownState{
    [self.rightImageView setImage:[UIImage imageNamed:@"pullDown"]];
}




@end
