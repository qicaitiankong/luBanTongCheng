//
//  SearchBiaoQianSmallView.m
//  鲁班同城
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "SearchBiaoQianSmallView.h"

@interface SearchBiaoQianSmallView (){
    UIImageView *leftImageView;
}
@end


@implementation SearchBiaoQianSmallView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 14)];
        [leftImageView setImage:[UIImage imageNamed:@"searchBiaoQian"]];
        leftImageView.center = CGPointMake(leftImageView.centerX, frame.size.height / 2);
        [self addSubview:leftImageView];
        //
        
        self.rightDisplayLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:15] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        self.rightDisplayLabel.frame = CGRectMake(leftImageView.right + 5, 0, frame.size.width - leftImageView.right - 5, frame.size.height);
        [self addSubview:self.rightDisplayLabel];
        //
        UIButton *backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        backButt.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [backButt addTarget:self action:@selector(backButtClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButt];
    }
    return self;
}

- (void)backButtClick{
    if (self.backButtBlock){
        self.backButtBlock([self.rightDisplayLabel.text copy]);
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
