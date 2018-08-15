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
        tipLabel.backgroundColor = [UIColor whiteColor];
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

- (instancetype)initWithSecondUseFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithHexString:@"#C6C6C6"].CGColor;
        self.layer.cornerRadius = 4;
        tipLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#999999"] aligement:0];
        tipLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:tipLabel];
        //
        voiceImageView = [[UIImageView alloc]init];
        //voiceImageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:voiceImageView];
        
        backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButt addTarget:self action:@selector(backButtonHandler) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButt];
        //
        
        CGFloat labelHeight = frame.size.height * 0.9;
        CGFloat titleWidth = [LzhReturnLabelHeight getLabelWidth:@"添加语音" font:[UIFont getPingFangSCMedium:14] targetHeight:labelHeight];
        UIImage *image = [UIImage imageNamed:@"voiceGray"];
        CGFloat imageWidth = 11;
        CGFloat imageHeight = imageWidth / (image.size.width / image.size.height);
        CGFloat imageAndLabelSpace = 15;
        CGFloat labelLeftSpace = (frame.size.width - titleWidth) / 2 - imageAndLabelSpace;
        //
        tipLabel.frame = CGRectMake(0, 0, titleWidth, labelHeight);
        tipLabel.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        tipLabel.text = @"添加语音";
        
        //
        voiceImageView.frame = CGRectMake(tipLabel.right + labelLeftSpace, 0, imageWidth, imageHeight);
        voiceImageView.center = CGPointMake(voiceImageView.centerX, tipLabel.centerY);
        [voiceImageView setImage:image];
    }
    return self;
}



- (void)addOwnContraints{
    //
    CGFloat labelHeight = self.height * 0.9;
    CGFloat titleWidth = [LzhReturnLabelHeight getLabelWidth:@"添加语音" font:[UIFont getPingFangSCMedium:14] targetHeight:labelHeight];
    UIImage *image = [UIImage imageNamed:@"voiceGray"];
    CGFloat imageWidth = 11;
    CGFloat imageHeight = imageWidth / (image.size.width / image.size.height);
    CGFloat imageAndLabelSpace = 15;
    CGFloat labelLeftSpace = (self.width - titleWidth) / 2 - imageAndLabelSpace;
    //
    [voiceImageView setImage:image];
    tipLabel.text = @"添加语音";
    tipLabel.sd_layout
    .centerXEqualToView(self)
    .widthIs(titleWidth)
    .heightIs(labelHeight)
    .centerYEqualToView(self);
    
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
    if (self.addSoundClickBlock){
        self.addSoundClickBlock();
    }
    
    
    
}

- (void)changeToAddSoundState{
    tipLabel.text = @"添加语音";
    
}

- (void)changeToPlaySoundState{
    tipLabel.text = @"播放语音";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
