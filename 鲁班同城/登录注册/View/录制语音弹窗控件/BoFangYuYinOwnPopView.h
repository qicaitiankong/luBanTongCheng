//
//  BoFangYuYinOwnPopView.h
//  鲁班同城
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoFangYuYinOwnPopView : UIView

@property (copy,nonatomic) void (^sureBlock)(void);

@property (copy,nonatomic) void (^deleteBlock)(void);


@property (strong,nonatomic) UILabel *tipLabel;


@property (strong,nonatomic) UIButton *zheZhaoButt;

- (instancetype)initWithFrame:(CGRect)frame totalTime:(NSInteger)times;


@end
