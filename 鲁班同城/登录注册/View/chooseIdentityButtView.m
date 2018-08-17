//
//  chooseIdentityButtView.m
//  鲁班同城
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "chooseIdentityButtView.h"

@interface chooseIdentityButtView (){
    CustomeLzhLabel *rightDisplayLabel;
    UIImageView *rightFlagImageView;
    UIImageView *leftImageView;
}

@end

@implementation chooseIdentityButtView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //
         UIColor *titleNormalColr = SPECIAL_BLUE_COLOR;
        self.layer.cornerRadius = frame.size.height / 2;
        self.layer.borderWidth = 1;
        self.layer.borderColor = titleNormalColr.CGColor;
        
        leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, frame.size.height * 0.75, frame.size.height * 0.75)];
        leftImageView.clipsToBounds = YES;
        leftImageView.layer.cornerRadius = leftImageView.width / 2;
        leftImageView.center = CGPointMake(leftImageView.centerX, frame.size.height / 2);
        [leftImageView setImage:[UIImage imageNamed:@"chooseIdentityPerson"]];
        [self addSubview:leftImageView];
        //
        rightFlagImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 10 - frame.size.height * 0.8, 0, frame.size.height * 0.8, frame.size.height * 0.8)];
        rightFlagImageView.center = CGPointMake(rightFlagImageView.centerX, frame.size.height / 2);
        [rightFlagImageView setImage:[UIImage imageNamed:@"chooseIdentityFlag"]];
        [self addSubview:rightFlagImageView];
        //
       
        rightDisplayLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:titleNormalColr aligement:0];
        rightDisplayLabel.frame = CGRectMake(leftImageView.right + 10, 0, rightFlagImageView.left - leftImageView.left - leftImageView.width - 20, frame.size.height * 0.8);
        rightDisplayLabel.center = CGPointMake(rightDisplayLabel.centerX, frame.size.height / 2);
        rightDisplayLabel.text = title;
        [self addSubview:rightDisplayLabel];
        
        //
        UIButton *backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        backButt.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [backButt addTarget:self action:@selector(backButtHandler) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButt];
        
        
        
    }
    return self;
}

- (void)backButtHandler{
    if (self.clickButtBlock){
        self.clickButtBlock();
    }
}


- (void)setNormalState{
     [leftImageView setImage:[UIImage imageNamed:@"chooseIdentitySelectedPerson"]];
    self.backgroundColor = [UIColor whiteColor];
    rightDisplayLabel.textColor = SPECIAL_BLUE_COLOR;
    rightFlagImageView.hidden = YES;
    self.selectedState = NO;
    
}

- (void)setSelectedState{
    [leftImageView setImage:[UIImage imageNamed:@"chooseIdentityPerson"]];
    self.backgroundColor = SPECIAL_BLUE_COLOR;
    rightDisplayLabel.textColor = [UIColor whiteColor];
   
    rightFlagImageView.hidden = NO;
    self.selectedState = YES;
}




@end
