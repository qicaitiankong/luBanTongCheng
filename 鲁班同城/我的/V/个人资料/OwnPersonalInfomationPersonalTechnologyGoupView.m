//
//  OwnPersonalInfomationPersonalTechnologyGoupView.m
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalInfomationPersonalTechnologyGoupView.h"
#import "CustomerLabelView.h"

@interface OwnPersonalInfomationPersonalTechnologyGoupView (){
    
}
@end

@implementation OwnPersonalInfomationPersonalTechnologyGoupView
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
        self.soundView = [[messagwSoundView alloc]initWithFrame:CGRectMake(self.topTipLabel.left, self.topTipLabel.bottom + 20, 260, 40)];
        [self addSubview:self.soundView];
        //
        NSArray *titleArr = @[@"技能名称技能",@"技能名称技能",@"技能名称技能",@"技能名称技能",@"技能名称技能",@"技能名称技能"];
        CGFloat viewWidth = frame.size.width * 0.293;
        CGFloat height = SCREEN_HEIGHT * 0.044;
        CGFloat horizontalSpace = (frame.size.width - 3 *viewWidth) / 4;
        CGFloat verticalSpace = 0;
        UIView *lastSingleView = nil;
        for (int k = 0; k < 6; k ++){
            if (k < 3){
                verticalSpace = self.soundView.bottom + 15;
            }else{
                verticalSpace = self.soundView.bottom + 15 * 2 + height;
            }
            CustomerLabelView *singleView = [[CustomerLabelView alloc]initWithFrame:CGRectMake(horizontalSpace * (k % 3 + 1) + viewWidth * (k % 3),verticalSpace , viewWidth, height)];
            [self addSubview:singleView];
            singleView.displayLabel.text = titleArr[k];
            if (k == 5){
                lastSingleView = singleView;
            }
        }
        //
        [self setFrame:CGRectMake(self.x, self.y, self.width, lastSingleView.bottom + 10)];
    }
    return self;
}


@end
