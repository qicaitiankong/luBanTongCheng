//
//  PersonalInfoInputAgeView.m
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "PersonalInfoInputAgeView.h"

@interface PersonalInfoInputAgeView (){
        UIView *bottomLineView;
       
        UIButton *backButt;
}
@end

@implementation PersonalInfoInputAgeView

@synthesize flagImageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.leftImageView = [[UIImageView alloc] init];
        self.leftImageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.leftImageView];
        
        self.ageLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        [self addSubview:self.ageLabel];
        //
        flagImageView = [[UIImageView alloc] init];
        flagImageView.backgroundColor = [UIColor whiteColor];
        [flagImageView setImage:[UIImage imageNamed:@"goFlag"]];
        [self addSubview:flagImageView];
        //
        self.rightTextField = [[OwnTextField alloc] initWithFrame:CGRectMake(0, 0, 40, frame.size.height)];
        self.rightTextField.myTextField.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.rightTextField];
        //
        self.addSoundView = [[PersonalInfoAddSoundButtView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        self.addSoundView.hidden = YES;
        [self addSubview:self.addSoundView];
        //
        bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = [UIColor colorWithHexString:@"#C6C6C6"];
        [self addSubview:bottomLineView];
        //
        backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButt addTarget:self action:@selector(backHandler) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButt];
        
    }
    return self;
}

- (void)backHandler{
    if(self.backButtBlock){
        self.backButtBlock(self.rightTextField.myTextField);
    }
}

- (void)displayTextOrYuYin:(BOOL)isYuYin{
    if (isYuYin){
        self.rightTextField.hidden = YES;
        self.rightTextField.myTextField.text = @"";
        self.addSoundView.hidden = NO;
    }else{
        self.rightTextField.hidden = NO;
        self.addSoundView.hidden = YES;
    }
}

- (void)hiddenBottomLine:(BOOL)hid{
    [bottomLineView setHidden:hid];
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
    
    self.ageLabel.sd_layout
    .leftSpaceToView(self.leftImageView, 10)
    .widthIs(labelWidrh)
    .heightIs(leftImageViewHeight)
    .topEqualToView(self.leftImageView);
    //
    flagImageView.sd_layout
    .rightSpaceToView(self, 12)
    .widthIs(7)
    .heightIs(13)
    .centerYEqualToView(self);
    //
    self.rightTextField.sd_layout
    .leftSpaceToView(self.ageLabel, 10)
    .rightSpaceToView(flagImageView, 10)
    .centerYEqualToView(self)
    .heightRatioToView(self, 0.6);
    [self.rightTextField addOwnConstraints];
    
    //
    self.addSoundView.sd_layout
    .leftSpaceToView(self.ageLabel, 10)
    .rightSpaceToView(self, 10)
    .centerYEqualToView(self)
    .heightRatioToView(self, 0.6);
    [self.addSoundView addOwnContraints];
    
    bottomLineView.sd_layout
    .leftEqualToView(self.ageLabel)
    .rightEqualToView(self)
    .bottomSpaceToView(self, 0)
    .heightIs(1);
    //
    backButt.sd_layout
    .leftEqualToView(self.ageLabel)
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
