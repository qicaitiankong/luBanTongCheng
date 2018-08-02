//
//  OwnPersonalInfomationPersonalVideoGoupView.m
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalInfomationPersonalVideoGoupView.h"
#import "CustomerImageButt.h"

@implementation OwnPersonalInfomationPersonalVideoGoupView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat labelWidth = frame.size.width - 15 * 2;
        self.topTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCBold:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.topTipLabel.frame = CGRectMake(15, 20, labelWidth, 20);
        [self addSubview:self.topTipLabel];
         UIView *lastView = nil;
        self.picContainView = [SDWeiXinPhotoContainerView new];
        [self addSubview:self.picContainView];
        
        self.picContainView.sd_layout
        .leftSpaceToView(self, 15)
        .topSpaceToView(self.topTipLabel, 15);
        
        lastView = self.picContainView;
         [self setFrame:CGRectMake(self.x, self.y, self.width, self.topTipLabel.bottom + 10)];
    }
    return self;
}

- (void)givePictureArr:(NSArray*)arr{
    [self.picContainView setPicPathStringsArray:arr];
    //[self setupAutoHeightWithBottomView:self.picContainView bottomMargin:10];
    
}


@end
