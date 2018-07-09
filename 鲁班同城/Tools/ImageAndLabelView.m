//
//  ImageAndLabelView.m
//  鲁班同城
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ImageAndLabelView.h"

@implementation ImageAndLabelView



- (instancetype)initWithFrame:(CGRect)frame image: (UIImage*)image title:(NSString*)title font:(UIFont*)font titleColor:(UIColor*)textColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.leftImageView = [[UIImageView alloc]init];
        self.leftImageView.backgroundColor = [UIColor whiteColor];
        //
        self.rightLabel = [[UILabel alloc]init];
        self.rightLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.leftImageView];
        [self addSubview:self.rightLabel];
        //
        CGFloat imageWidth = 20;
        CGFloat imageHeight = imageWidth / (image.size.width / image.size.height);
        [self.leftImageView setImage:image];
        self.rightLabel.text = title;
        self.rightLabel.font = font;
        self.rightLabel.textColor = textColor;
        CGFloat labelWidth = [LzhReturnLabelHeight getLabelWidth:title font:font targetHeight:imageHeight + 10];
        //
        self.leftImageView.frame = CGRectMake(0, 5, imageWidth, imageHeight);
        
        self.rightLabel.frame = CGRectMake(self.leftImageView.right + 5, 0, labelWidth, imageHeight + 10);
        //
        UIButton *backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        backButt.frame = CGRectMake(0, 0, self.rightLabel.left + self.rightLabel.width, self.rightLabel.height);
        [backButt addTarget:self action:@selector(backButtClickBlock) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButt];
        //
        [self setFrame:CGRectMake(self.x, self.y, self.rightLabel.left + self.rightLabel.width, self.leftImageView.bottom + 5)];
        
    }
    return self;
}

- (void)backButtClickBlock{
    if (self.clickBackButt){
        self.clickBackButt();
    }
}


@end
