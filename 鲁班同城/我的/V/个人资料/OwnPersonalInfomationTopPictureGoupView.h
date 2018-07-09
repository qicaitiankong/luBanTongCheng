//
//  OwnPersonalInfomationTopPictureGoupView.h
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomeStyleCornerButt.h"
#import  "CustomerImageButt.h"
#import "StarView.h"

@interface OwnPersonalInfomationTopPictureGoupView : UIView

@property (strong,nonatomic) UIImageView *topBigImaView;

@property (strong,nonatomic) CustomerImageButt *navReturnButt;

@property (strong,nonatomic) CustomerImageButt *addFriendButt;

@property (strong,nonatomic) CustomerImageButt *shareButt;

@property (strong,nonatomic) UIImageView *userlogoImaView;

@property (strong,nonatomic) UILabel *fenSiLabel;

@property (strong,nonatomic) UILabel *concernLabel;

@property (strong,nonatomic) UILabel *sexAndHomeLabel;

@property (strong,nonatomic) StarView * starGroupView;

@end
