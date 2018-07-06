//
//  OwnPersonalInfomationPersonalServiceTypeGoupView.m
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalInfomationPersonalServiceTypeGoupView.h"
#import "CustomerLabelView.h"

@implementation OwnPersonalInfomationPersonalServiceTypeGoupView

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
        NSArray *titleArr = @[@"服务员",@"厨师",@"建筑工"];
        CGFloat viewWidth = 60;
        CGFloat height = 30;
        CGFloat horizontalSpace = 30;
        CGFloat verticalSpace = 0;
        UIView *lastSingleView = nil;
        for (int k = 0; k < titleArr.count; k ++){
            if (k < 3){
                verticalSpace = self.topTipLabel.bottom + 15;
            }else{
                verticalSpace = self.topTipLabel.bottom + 15 * 2 + height;
            }
            CustomerLabelView *singleView = [[CustomerLabelView alloc]initWithFrame:CGRectMake(horizontalSpace * (k % 3 + 1) + viewWidth * (k % 3),verticalSpace , viewWidth, height)];
            [self addSubview:singleView];
            singleView.displayLabel.text = titleArr[k];
            if (k == titleArr.count - 1){
                lastSingleView = singleView;
            }
        }
        //
        [self setFrame:CGRectMake(self.x, self.y, self.width, lastSingleView.bottom + 10)];
    }
    return self;
}

@end
