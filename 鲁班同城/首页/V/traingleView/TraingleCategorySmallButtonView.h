//
//  TraingleCategorySmallButtonView.h
//  鲁班同城
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TraingleCategorySmallButtonView : UIView

@property (strong,nonatomic) UILabel *leftLabel;

@property (strong,nonatomic) UIButton *backButt;

- (void)addConstraints;

//作为筛选按钮时去掉三角号
- (void)adjustDisplayWhenIsFilterButt;

@end
