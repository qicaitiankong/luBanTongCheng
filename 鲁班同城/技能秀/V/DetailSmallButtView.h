//
//  DetailSmallButtView.h
//  鲁班同城
//
//  Created by apple on 2018/7/10.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailSmallButtView : UIView

@property (strong,nonatomic) UILabel *leftLabel;

@property (strong,nonatomic) UIImageView *rightImageView;

@property (strong,nonatomic) UIButton *backButt;;

- (void)setPullUpState;

- (void)setPullDownState;



@end
