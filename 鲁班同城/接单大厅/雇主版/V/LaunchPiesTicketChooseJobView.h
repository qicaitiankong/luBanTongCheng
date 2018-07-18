//
//  LaunchPiesTicketChooseJobView.h
//  鲁班同城
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchPiesTicketChooseJobView : UIView

@property (strong,nonatomic) UIImageView *leftImageView;

@property (strong,nonatomic) UILabel *ageLabel;

@property (strong,nonatomic) OwnTextField *rightTextField;

@property (copy,nonatomic) void (^backButtBlock)(UITextField *textField);

- (void)addOwnConstraints:(UIImage *)iconImage;

@end
