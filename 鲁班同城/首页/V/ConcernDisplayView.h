//
//  ConcernDisplayView.h
//  鲁班同城
//
//  Created by apple on 2018/7/1.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConcernDisplayView : UIView

@property (strong,nonatomic) UIImageView *leftImageView;

@property (strong,nonatomic) UILabel *rightNumLabel;

- (void)addOwnConstraints;

@end
