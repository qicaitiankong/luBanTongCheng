//
//  ImageAndLabelView.h
//  鲁班同城
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageAndLabelView : UIView

@property (strong,nonatomic) UIImageView *leftImageView;

@property (strong,nonatomic) UILabel *rightLabel;

- (instancetype)initWithFrame:(CGRect)frame image: (UIImage*)image title:(NSString*)title font:(UIFont*)font titleColor:(UIColor*)textColor;



@end
