//
//  CustomerImageButt.h
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerImageButt : UIView

@property (strong,nonatomic) UIImageView *imageView;

@property (copy,nonatomic) void (^clickButtBlock)(void);


@end
