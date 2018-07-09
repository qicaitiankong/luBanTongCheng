//
//  SkillShowCommentToolView.m
//  鲁班同城
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "SkillShowCommentToolView.h"

@implementation SkillShowCommentToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        //
        self.sayMoreButt = [[CustomeLabelButt alloc] initWithFrame:CGRectMake(10, 0, frame.size.width / 2 - 10, frame.size.height) ];
        self.sayMoreButt.backgroundColor = [UIColor blackColor];
        [self.sayMoreButt.displayLabel setText:@"说点什么"];
        self.sayMoreButt.displayLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        self.sayMoreButt.displayLabel.font = [UIFont getPingFangSCMedium:15];
        [self addSubview:self.sayMoreButt];
        //最大支持6位显示
        self.commentView = [[ImageAndLabelView alloc]initWithFrame:CGRectMake(self.sayMoreButt.right + 5, 0, 10, 10) image:[UIImage imageNamed:@"message"] title:@"000000" font:[UIFont getPingFangSCMedium:12] titleColor:[UIColor colorWithHexString:@"#999999"]];
        self.commentView.rightLabel.text = @"0";
        self.commentView.leftImageView.backgroundColor = self.backgroundColor;
        self.commentView.rightLabel.backgroundColor = self.backgroundColor;
        self.commentView.backgroundColor = self.backgroundColor;
        [self addSubview:self.commentView];
        self.commentView.center = CGPointMake(self.commentView.centerX, frame.size.height / 2);
        //最大支持6位显示
        self.praiseView = [[ImageAndLabelView alloc]initWithFrame:CGRectMake(self.commentView.right + 5, 0, 10, 10) image:[UIImage imageNamed:@"clickPraise"] title:@"000000" font:[UIFont getPingFangSCMedium:12] titleColor:[UIColor colorWithHexString:@"#999999"]];
        self.praiseView.rightLabel.text = @"0";
        self.praiseView.leftImageView.backgroundColor = self.backgroundColor;
        self.praiseView.rightLabel.backgroundColor = self.backgroundColor;
        self.praiseView.backgroundColor = self.backgroundColor;
        [self addSubview:self.praiseView];
        self.praiseView.center = CGPointMake(self.praiseView.centerX, frame.size.height / 2);
        //
        CGFloat buttWidth = frame.size.height * 0.423;
        self.sharButt = [[CustomerImageButt alloc]initWithFrame:CGRectMake(frame.size.width - buttWidth - 5,0, buttWidth, buttWidth)];
        self.sharButt.center = CGPointMake(self.sharButt.centerX, frame.size.height / 2);
        [self addSubview:self.sharButt];
        [self.sharButt.imageView setImage:[UIImage imageNamed:@"share"]];
        
    }
    return self;
}


- (void)moreButtHandler{
    
}



@end
