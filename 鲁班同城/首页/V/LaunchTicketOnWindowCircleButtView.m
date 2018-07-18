//
//  LaunchTicketOnWindowCircleButtView.m
//  鲁班同城
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "LaunchTicketOnWindowCircleButtView.h"

@implementation LaunchTicketOnWindowCircleButtView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SPECIAL_BLUE_COLOR;
        self.clipsToBounds = YES;
        UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height * 0.2, 15, 13)];
        topImageView.backgroundColor = self.backgroundColor;
        topImageView.center = CGPointMake(frame.size.width / 2, topImageView.centerY);
        [topImageView setImage:[UIImage imageNamed:@"send_message"]];
        [self addSubview:topImageView];
        //
        UILabel *bottomLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:17] titleColor:[UIColor whiteColor] aligement:1];
        bottomLabel.frame = CGRectMake(0, topImageView.bottom, frame.size.width, frame.size.height - topImageView.bottom);
        bottomLabel.text = @"派单";
        [self addSubview:bottomLabel];
        //
        UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [butt addTarget:self action:@selector(buttHandler) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:butt];
    }
    return self;
}

- (void)buttHandler{
    
    if (self.clickButtBlock){
        self.clickButtBlock();
    }
}

@end
