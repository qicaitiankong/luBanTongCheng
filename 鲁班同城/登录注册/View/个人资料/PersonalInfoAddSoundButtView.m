//
//  PersonalInfoAddSoundButtView.m
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "PersonalInfoAddSoundButtView.h"

@interface PersonalInfoAddSoundButtView (){
    UILabel *tipLabel;
    UIImageView *voiceImageView;
    UIButton *backButt;
}
@end

@implementation PersonalInfoAddSoundButtView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithHexString:@"#C6C6C6"].CGColor;
        self.layer.cornerRadius = 4;
        tipLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#999999"] aligement:0];
        //
        voiceImageView = [[UIImageView alloc]init];
        //voiceImageView.backgroundColor = [UIColor whiteColor];
        //
        backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButt addTarget:self action:@selector(backButtonHandler) forControlEvents:UIControlEventTouchUpInside];
        //
        NSArray *viewArr = @[tipLabel,voiceImageView,backButt];
        [self sd_addSubviews:viewArr];
    }
    return self;
}

- (void)addOwnContraints{
    CGFloat labelHeight = self.height * 0.8;
    CGFloat titleWidth = [LzhReturnLabelHeight getLabelWidth:@"添加语音" font:[UIFont getPingFangSCMedium:14] targetHeight:labelHeight];
    UIImage *image = [UIImage imageNamed:@"voiceGray"];
    CGFloat imageWidth = 11;
    CGFloat imageHeight = imageWidth / (image.size.width / image.size.height);
    CGFloat imageAndLabelSpace = 15;
    CGFloat labelrightSpace = (self.width - titleWidth) / 2 + imageWidth + imageAndLabelSpace;
    [voiceImageView setImage:image];
    tipLabel.text = @"添加语音";
    tipLabel.sd_layout
    .widthIs(titleWidth)
    .heightIs(labelHeight)
    .centerYEqualToView(self)
    .rightSpaceToView(self, labelrightSpace);
    
    voiceImageView.sd_layout
    .leftSpaceToView(tipLabel, imageAndLabelSpace)
    .widthIs(imageWidth)
    .heightIs(imageHeight)
    .centerYEqualToView(self);
    
    backButt.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self);
}

- (void)backButtonHandler{
    NSLog(@"添加语音");
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
