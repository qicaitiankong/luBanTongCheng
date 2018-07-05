//
//  PersonalInfoExchangeViceTextView.m
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//


#import "PersonalInfoExchangeViceTextView.h"
@interface PersonalInfoExchangeViceTextView (){
    UILabel *tipLabel;
    UIImageView *voiceImageView;
    UIButton *backButt;
    UIImage *soundImage;
    UIImage *textImage;
    BOOL isSound;
    CGFloat imageWidth;
    CGFloat imageAndLabelSpace;

}

@end

@implementation PersonalInfoExchangeViceTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //234,134,60
        self.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:60 / 255.0 alpha:1];
        imageWidth = 15;
        imageAndLabelSpace = 10;
        textImage = [UIImage imageNamed:@"keyboard@2x.png"];
        soundImage = [UIImage imageNamed:@"voice@2x.png"];
        //
        tipLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor whiteColor] aligement:0];
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

- (void)backButtonHandler{
    isSound = !isSound;
    [self refreshOwnConstraints];
    if (self.clickSoundTextChangeViewBlock){
    self.clickSoundTextChangeViewBlock(isSound);
    }
}

- (void)addOwnContraints{
    //
    UIImage *image = nil;
    if (isSound){
         image = textImage;
    }else{
        image = soundImage;

    }
   
    CGFloat imageHeight = imageWidth / (image.size.width / image.size.height);
    //
    CGFloat labelHeight = self.height * 0.8;
    CGFloat titleWidth = [LzhReturnLabelHeight getLabelWidth:@"不会打字怎么办？（语音输入）" font:[UIFont getPingFangSCMedium:14] targetHeight:labelHeight];
    CGFloat labelLeftSpace = (self.width - titleWidth) / 2 + imageWidth + imageAndLabelSpace;
    [voiceImageView setImage:image];
    tipLabel.text = @"不会打字怎么办？（语音输入）";
    tipLabel.sd_layout
    .widthIs(titleWidth)
    .heightIs(labelHeight)
    .centerYEqualToView(self)
    .leftSpaceToView(self, labelLeftSpace);
    
    voiceImageView.sd_layout
    .rightSpaceToView(tipLabel, imageAndLabelSpace)
    .widthIs(imageWidth)
    .heightIs(imageHeight)
    .centerYEqualToView(self);
    
    backButt.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self);
    
}

- (void)refreshOwnConstraints{
    UIImage *image = nil;
    NSString *tipStr = nil;
    if (isSound){
        image = textImage;
        tipStr = @"文字输入";
    }else{
        image = soundImage;
        tipStr = @"不会打字怎么办？（语音输入）";
    }
    [voiceImageView setImage:image];
    tipLabel.text = tipStr;
    CGFloat imageHeight = imageWidth / (image.size.width / image.size.height);
    //
    CGFloat labelHeight = self.height * 0.8;
    CGFloat titleWidth = [LzhReturnLabelHeight getLabelWidth:tipStr font:[UIFont getPingFangSCMedium:14] targetHeight:labelHeight];
    CGFloat labelLeftSpace = (self.width - titleWidth) / 2 + imageWidth + imageAndLabelSpace;
    
    tipLabel.sd_resetLayout
    .widthIs(titleWidth)
    .heightIs(labelHeight)
    .centerYEqualToView(self)
    .leftSpaceToView(self, labelLeftSpace);
    
    voiceImageView.sd_resetLayout
    .rightSpaceToView(tipLabel, imageAndLabelSpace)
    .widthIs(imageWidth)
    .heightIs(imageHeight)
    .centerYEqualToView(self);
    
    backButt.sd_resetLayout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
