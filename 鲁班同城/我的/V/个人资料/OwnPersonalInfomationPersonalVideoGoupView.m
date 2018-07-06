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
        //
        CGFloat beginLeftSpace = 15;
        CGFloat horizontalSpace = 5;
        CGFloat beginTopSpace = self.topTipLabel.bottom +  15;
        CGFloat verticalSpace = 5;
        CGFloat viewWidth = (frame.size.width - 2 * beginLeftSpace - 2 * horizontalSpace) / 3 ;
        UIView *lastView = nil;
        for (int k = 0; k < 6; k ++){
            CustomerImageButt *imageButt = [[CustomerImageButt alloc]initWithFrame:CGRectMake(beginLeftSpace + (k % 3) * (horizontalSpace + viewWidth), beginTopSpace + (k / 3) * (verticalSpace + viewWidth), viewWidth, viewWidth)];
            imageButt.imageView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
            [self addSubview:imageButt];
            if (k == 5){
                lastView = imageButt;
            }
        }
         [self setFrame:CGRectMake(self.x, self.y, self.width, lastView.bottom + 10)];
    }
    return self;
}

@end
