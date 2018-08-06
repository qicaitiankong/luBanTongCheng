//
//  OwnPersonalInfoSectionView.m
//  鲁班同城
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalInfoSectionView.h"
#import "ImageAndLabelView.h"

@implementation OwnPersonalInfoSectionView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage*)leftImage title:(NSString *)leftTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        ImageAndLabelView *firstImageAndLabelView = [[ImageAndLabelView alloc] initWithFrame:CGRectMake(15,0,10, frame.size.height) image:leftImage title:leftTitle font:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"]];
        [self addSubview:firstImageAndLabelView];
        //
        self.rightTopTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithRed:153.003/255.0 green:153.003/255.0 blue:153.003/255.0 alpha:1] aligement:2];
          self.rightTopTipLabel.frame = CGRectMake(firstImageAndLabelView.right + 5, firstImageAndLabelView.top, frame.size.width - firstImageAndLabelView.right - 15, firstImageAndLabelView.height);
        self.rightTopTipLabel.text = @"点击 +上传/拍摄";
        [self addSubview: self.rightTopTipLabel];
    }
    return self;
}

@end
