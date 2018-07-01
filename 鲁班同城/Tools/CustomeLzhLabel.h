//
//  CustomeLzhLabel.h
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomeLzhLabel : UILabel

//size=0(则为默认17),color=nil(默认),aligement=-1|0(则为默认左对齐)
- (instancetype)initWithParamer:(CGFloat)fontSize titleColor:(UIColor*)titleColor aligement:(NSTextAlignment)aligenment;

- (instancetype)initWithCustomerParamer:(UIFont*)font titleColor:(UIColor*)titleColor aligement:(NSTextAlignment)aligenment;


@end
