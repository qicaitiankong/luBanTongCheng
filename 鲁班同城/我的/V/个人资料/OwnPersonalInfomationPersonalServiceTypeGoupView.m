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
    }
    return self;
}

- (void)giveOwnValue:(NSArray*)titlesArr{
    NSArray *localTitleArr = titlesArr;
    CGFloat viewWidth = self.width * 0.293;
    CGFloat height = SCREEN_HEIGHT * 0.044;
    CGFloat horizontalSpace = (self.width - 3 *viewWidth) / 4;
    CGFloat verticalSpace = 0;
    UIView *lastSingleView = nil;
    for (int k = 0; k < localTitleArr.count; k ++){
        verticalSpace = self.topTipLabel.bottom + 15 + (k / 3) * 15 + height * (k / 3);
        CustomerLabelView *singleView = [[CustomerLabelView alloc]initWithFrame:CGRectMake(horizontalSpace * (k % 3 + 1) + viewWidth * (k % 3),verticalSpace , viewWidth, height)];
        [self addSubview:singleView];
        singleView.displayLabel.text = localTitleArr[k];
        if (k == localTitleArr.count - 1){
            lastSingleView = singleView;
        }
    }
    //
    [self setFrame:CGRectMake(self.x, self.y, self.width, lastSingleView.bottom + 10)];
}


@end
