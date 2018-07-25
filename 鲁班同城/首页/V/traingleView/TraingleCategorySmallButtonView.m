//
//  TraingleCategorySmallButtonView.m
//  鲁班同城
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "TraingleCategorySmallButtonView.h"

@interface TraingleCategorySmallButtonView (){
    
    UIImageView *traingleImageView;
}
@end

@implementation TraingleCategorySmallButtonView
@synthesize leftLabel;
@synthesize backButt;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        traingleImageView = [[UIImageView alloc] init];
        traingleImageView.backgroundColor = [UIColor whiteColor];
        [traingleImageView setImage:[UIImage imageNamed:@"traingle"]];
        traingleImageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:traingleImageView];
        //
        leftLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:11] titleColor:[UIColor colorWithHexString:@"#444444"] aligement:1];
        leftLabel.backgroundColor = self.backgroundColor;
        [self addSubview:leftLabel];
        //
        backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:backButt];
        
        
    }
    return self;
}

- (void)addConstraints{
    //
    traingleImageView.sd_layout
    .rightSpaceToView(self, 8)
    .widthIs(7)
    .heightIs(5)
    .centerYEqualToView(self);
    
    leftLabel.sd_layout
    .leftSpaceToView(self, 5)
    .rightSpaceToView(traingleImageView, 3)
    .topEqualToView(self)
    .bottomEqualToView(self);
    
    backButt.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self);
}
//作为筛选按钮时去掉三角号
- (void)adjustDisplayWhenIsFilterButt{
    traingleImageView.hidden = YES;
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.sd_resetLayout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .topEqualToView(self)
    .bottomEqualToView(self);
}


- (void)adjustConstraintsAfterGiveTitle{
    NSString *yangBenStr = @"";
    if (leftLabel.text.length > 4){
        yangBenStr = @"字字字字";
    }else{
        yangBenStr = leftLabel.text;
    }
    //
    CGFloat pridicateWidth = [LzhReturnLabelHeight getLabelWidth:yangBenStr font:[UIFont getPingFangSCMedium:11] targetHeight:self.height];
    //
    leftLabel.sd_resetLayout
    .centerXIs(self.width / 2 - 4)
    .widthIs(pridicateWidth)
    .topEqualToView(self)
    .bottomEqualToView(self);
    //
    traingleImageView.sd_resetLayout
    .leftSpaceToView(self, self.width  / 2 + pridicateWidth / 2 - 4 + 2)
    .widthIs(7)
    .heightIs(5)
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
