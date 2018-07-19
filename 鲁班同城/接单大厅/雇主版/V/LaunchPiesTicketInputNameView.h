//
//  LaunchPiesTicketInputNameView.h
//  鲁班同城
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LaunchPiesTicketInputNameView : UIView

@property (strong,nonatomic) UIImageView *leftImageView;

@property (strong,nonatomic) UILabel *nameLabel;

@property (strong,nonatomic) OwnTextField *rightTextField;

@property (strong,nonatomic) UIView *bottomLineView;

- (void)addOwnConstraints:(UIImage *)iconImage;

- (instancetype)initWithFrame:(CGRect)frame needRightMapButt:(BOOL)needMapButt;


@end
