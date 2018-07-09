//
//  CustomeLabelButt.h
//  鲁班同城
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomeLabelButt : UIView

@property (strong,nonatomic) UILabel *displayLabel;

@property (copy,nonatomic) void (^clickButtBlock)(void);
@end
