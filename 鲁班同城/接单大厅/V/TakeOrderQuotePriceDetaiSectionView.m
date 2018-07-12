//
//  TakeOrderQuotePriceDetaiSectionView.m
//  鲁班同城
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "TakeOrderQuotePriceDetaiSectionView.h"

@interface TakeOrderQuotePriceDetaiSectionView (){
    UIImageView *backImageView;
}
@end

@implementation TakeOrderQuotePriceDetaiSectionView

- (instancetype)initWithFrame:(CGRect)frame backImageHeight:(CGFloat)imageHieght image:(UIImage*)image
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, imageHieght)];
        backImageView.backgroundColor = [UIColor whiteColor];
        [backImageView setImage:image];
        [self addSubview:backImageView];
        //
        self.topDisplayLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:23] titleColor:[UIColor whiteColor] aligement:1];
        self.topDisplayLabel.frame = CGRectMake(0, backImageView.height / 4, frame.size.width, backImageView.height / 4);
        [backImageView addSubview:self.topDisplayLabel];
        //
        self.botDisplayLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:[UIColor colorWithHexString:@"#78CAC5"] aligement:1];
        self.botDisplayLabel.frame = CGRectMake(0, backImageView.height / 4 * 3 + 5, backImageView.width * 0.9, backImageView.height / 4);
        self.botDisplayLabel.center = CGPointMake(backImageView.width / 2, self.botDisplayLabel.centerY);
        self.botDisplayLabel.backgroundColor = [UIColor whiteColor];
        self.botDisplayLabel.layer.cornerRadius = 5;
        self.botDisplayLabel.clipsToBounds = YES;
        [backImageView addSubview:self.botDisplayLabel];
        //
        UIImageView *traingleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, backImageView.bottom + 5, 12, 7)];
        traingleImageView.center = CGPointMake(frame.size.width / 2, traingleImageView.centerY);
        [traingleImageView setImage:[UIImage imageNamed:@"quotePriceTraingle"]];
        [self addSubview:traingleImageView];
        //
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
        bottomLine.backgroundColor = [UIColor colorWithHexString:@"#DADADA"];
        [self addSubview:bottomLine];
    }
    return self;
}

@end
