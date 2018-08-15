//
//  QuotePriceOnWebGroupView.m
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QuotePriceOnWebGroupView.h"
#import "CustomeStyleCornerButt.h"

@interface QuotePriceOnWebGroupView (){
   // UIButton *soundButtView;
}
@end


@implementation QuotePriceOnWebGroupView
@synthesize takeOrderButt;
@synthesize moneyTextfield;
@synthesize beiZhuTextView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#DADADA"];
        [self addSubview:lineView];
        //
        UILabel *topTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:15] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        topTipLabel.text = @"在线报价";
        topTipLabel.frame = CGRectMake(0, lineView.bottom + 10, frame.size.width, 15);
        [self addSubview:topTipLabel];
        //
        self.addSoundView = [[PersonalInfoAddSoundButtView alloc]initWithSecondUseFrame:CGRectMake(0, topTipLabel.bottom  + 10, frame.size.width , 60)];
        [self addSubview:self.addSoundView];
        
//        soundButtView = [UIButton buttonWithType:UIButtonTypeCustom];
//        soundButtView.frame = CGRectMake(0, topTipLabel.bottom  + 10, frame.size.width , 60);
//        soundButtView.backgroundColor = [UIColor whiteColor];
//        [soundButtView setBackgroundImage:[UIImage imageNamed:@"pressSound"] forState:UIControlStateNormal];
//        [soundButtView addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:soundButtView];
        //
        UILabel *priceTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        priceTipLabel.frame = CGRectMake(0, self.addSoundView.bottom + 20, 30, 15);
        priceTipLabel.text = @"报价";
        [self addSubview:priceTipLabel];
        //
        moneyTextfield = [[OwnTextField alloc]initWithFrameForBaoJIA:CGRectMake(priceTipLabel.right + 5, 0, frame.size.width - priceTipLabel.right - 5, 25)];
        moneyTextfield.center = CGPointMake(moneyTextfield.centerX, priceTipLabel.centerY);
        moneyTextfield.myTextField.font = [UIFont getPingFangSCMedium:14];
        moneyTextfield.layer.borderWidth = 1;
        moneyTextfield.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
        moneyTextfield.layer.cornerRadius = 5;
        [self addSubview:moneyTextfield];
        //
        UILabel *beiZhuTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        beiZhuTipLabel.frame = CGRectMake(0, moneyTextfield.bottom + 10, 30, 15);
        beiZhuTipLabel.text = @"备注";
        [self addSubview:beiZhuTipLabel];
        //
        beiZhuTextView = [[OwnTextView alloc]initWithFrame:CGRectMake(moneyTextfield.left, beiZhuTipLabel.top, moneyTextfield.width, 80)];
        beiZhuTextView.backgroundColor = [UIColor whiteColor];
        beiZhuTextView.layer.borderWidth = 1;
        beiZhuTextView.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
        beiZhuTextView.layer.cornerRadius = 5;

        [self addSubview:beiZhuTextView];
        //
        takeOrderButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(0, beiZhuTextView.bottom + 10, frame.size.width, 45) backColor:[UIColor colorWithHexString:@"#78CAC5"] cornerRadius:8 title:@"接单报价" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:18]];
        [self addSubview:takeOrderButt];
        //
        [self setFrame:CGRectMake(self.x, self.y, self.width, takeOrderButt.bottom + 10)];
    }
    return self;
}



@end
