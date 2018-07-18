//
//  LaunchPiesTicketYuSuanView.m
//  鲁班同城
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "LaunchPiesTicketYuSuanView.h"

@interface LaunchPiesTicketYuSuanView (){
    UIView *bottomLineView;
    UILabel *moneyTipLabel;
}

@end

@implementation LaunchPiesTicketYuSuanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.leftImageView = [[UIImageView alloc] init];
        self.leftImageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.leftImageView];
        
        self.nameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        [self addSubview:self.nameLabel];
        
        self.rightTextField = [[OwnTextField alloc] initWithFrame:CGRectMake(0, 0, 40, frame.size.height)];
        self.rightTextField.myTextField.backgroundColor = [UIColor whiteColor];
        self.rightTextField.myTextField.font = [UIFont getPingFangSCMedium:14];
        [self addSubview:self.rightTextField];
        //
        moneyTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        moneyTipLabel.text = @"元";
        moneyTipLabel.frame = CGRectMake(0, 0, 15, frame.size.height - 1);
        [self addSubview:moneyTipLabel];
        //
        bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = [UIColor colorWithHexString:@"#C6C6C6"];
        [self addSubview:bottomLineView];
        //
    }
    return self;
}

- (void)addOwnConstraints:(UIImage *)iconImage{
    
    CGFloat leftimageWidth = 15;
    
    CGFloat leftImageViewHeight = 15 / (iconImage.size.width / iconImage.size.height);
    
    [self.leftImageView setImage:iconImage];
    self.leftImageView.sd_layout
    .leftSpaceToView(self, 10)
    .widthIs(leftimageWidth)
    .heightIs(leftImageViewHeight)
    .centerYEqualToView(self);
    
    //按照4个字长度
    CGFloat labelWidrh = [LzhReturnLabelHeight getLabelWidth:@"字字字字" font:[UIFont getPingFangSCMedium:14] targetHeight:leftImageViewHeight];
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.leftImageView, 10)
    .widthIs(labelWidrh)
    .heightIs(leftImageViewHeight)
    .topEqualToView(self.leftImageView);
    
    self.rightTextField.sd_layout
    .leftSpaceToView(self.nameLabel, 10)
    .rightSpaceToView(self, 10 + moneyTipLabel.width)
    .centerYEqualToView(self)
    .heightRatioToView(self, 0.6);
    [self.rightTextField addOwnConstraints];
    //
    moneyTipLabel.sd_layout
    .topEqualToView(self)
    .rightSpaceToView(self, 10)
    .widthIs(15)
    .heightIs(self.height - 1);
    
    
    bottomLineView.sd_layout
    .leftEqualToView(self.nameLabel)
    .rightEqualToView(moneyTipLabel)
    .bottomSpaceToView(self, 0)
    .heightIs(1);
    
}

@end
