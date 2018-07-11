//
//  QuotePriceOnWebGroupView.m
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QuotePriceOnWebGroupView.h"

@interface QuotePriceOnWebGroupView (){
    UIButton *soundButtView;
    UITextField *moneyTextfield;
    UITextView *beiZhuTextView;
}
@end


@implementation QuotePriceOnWebGroupView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //
        UILabel *topTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:15] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        topTipLabel.text = @"在线报价";
        //topTipLabel.frame = CGRectMake(0, 15, frame.size., <#CGFloat height#>)
    }
    return self;
}



@end
