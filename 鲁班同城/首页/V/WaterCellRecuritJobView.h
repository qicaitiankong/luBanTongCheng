//
//  WaterCellRecuritJobView.h
//  鲁班同城
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterCellRecuritJobView : UIView

@property (strong,nonatomic) UILabel *leftPositionLabel;

@property (strong,nonatomic) UILabel *rightCountLabel;

- (void)LzhUpdateConstraints;

@end
