//
//  LaunchPiesTicketYuSuanView.h
//  鲁班同城
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchPiesTicketYuSuanView : UIView

@property (strong,nonatomic) UIImageView *leftImageView;

@property (strong,nonatomic) UILabel *nameLabel;

@property (strong,nonatomic) OwnTextField *rightTextField;

- (void)addOwnConstraints:(UIImage *)iconImage;

@end
