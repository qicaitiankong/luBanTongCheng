//
//  DispatchOrderDetailCellSureServiceCompleteGroupView.h
//  鲁班同城
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "CustomeStyleCornerButt.h"
#import "ImageAndLabelView.h"

@interface DispatchOrderDetailCellSureServiceCompleteGroupView : UIView

@property (strong,nonatomic) UIImageView *userImageView;

@property (strong,nonatomic) UILabel *nickNameLabel;

@property (strong,nonatomic) StarView *xinxinView;

@property (strong,nonatomic) UILabel *messageTipLabel;

@property (strong,nonatomic) CustomeStyleCornerButt *sureServiceButt;

@property (strong,nonatomic) ImageAndLabelView *messageButtView;

@property (strong,nonatomic) ImageAndLabelView *mobileButtView;

@property (strong,nonatomic) ImageAndLabelView *cancelButtView;

@end
