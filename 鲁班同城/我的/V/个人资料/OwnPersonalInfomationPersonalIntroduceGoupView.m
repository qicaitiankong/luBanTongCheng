//
//  OwnPersonalInfomationPersonalIntroduceGoupView.m
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalInfomationPersonalIntroduceGoupView.h"

@interface OwnPersonalInfomationPersonalIntroduceGoupView (){

}
@end

@implementation OwnPersonalInfomationPersonalIntroduceGoupView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //
        CGFloat labelWidth = frame.size.width - 15 * 2;
         self.topTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCBold:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
         self.topTipLabel.frame = CGRectMake(15, 20, labelWidth, 20);
        [self addSubview:self.topTipLabel];
        //
        NSString *testStr = @"这里显示文字介绍。文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍文字介绍。";
        CGFloat labelHeight = [LzhReturnLabelHeight getLabelHeight:testStr font:[UIFont getPingFangSCMedium:16] width:labelWidth];
        self.detaileLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        self.detaileLabel.frame = CGRectMake(self.topTipLabel.left, self.topTipLabel.bottom + 20, labelWidth, labelHeight);
        self.detaileLabel.numberOfLines = 0;
        self.detaileLabel.text = testStr;
        [self addSubview:self.detaileLabel];
        //
        self.soundView = [[MessageSoundView alloc]initWithFrame:CGRectMake(self.detaileLabel.left, self.detaileLabel.bottom + 20, 260, 40)];
        [self addSubview:self.soundView];
        //
        [self setFrame:CGRectMake(self.x, self.y, self.width, self.soundView.bottom + 10)];
    }
    return self;
}
@end
