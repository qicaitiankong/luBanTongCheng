//
//  CustomeLzhLabel.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CustomeLzhLabel.h"

@implementation CustomeLzhLabel
- (instancetype)initWithParamer:(CGFloat)fontSize titleColor:(UIColor*)titleColor aligement:(NSTextAlignment)aligenment
{
    self = [super init];
    if (self) {
        if(fontSize){
            self.font = [UIFont systemFontOfSize:fontSize];
        }
        if(titleColor){
            self.textColor = titleColor;
        }else{
            self.textColor = [UIColor blackColor];
        }
        if(aligenment >= 0){
            self.textAlignment = aligenment;
        }
        
    }
    return self;
}

- (instancetype)initWithCustomerParamer:(UIFont*)font titleColor:(UIColor*)titleColor aligement:(NSTextAlignment)aligenment{
    self = [super init];
    if (self) {
        if(font){
            self.font = font;
        }
        if(titleColor){
            self.textColor = titleColor;
        }else{
            self.textColor = [UIColor blackColor];
        }
        if(aligenment >= 0){
            self.textAlignment = aligenment;
        }
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
