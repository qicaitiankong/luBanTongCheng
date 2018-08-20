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
        UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        topImageView.backgroundColor = self.backgroundColor;
        //topImageView.center = CGPointMake(frame.size.width, topImageView.centerY);
        [topImageView setImage:[UIImage imageNamed:@"xuanFuButt"]];
        [self addSubview:topImageView];
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
