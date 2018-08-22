//
//  CommentTopView.h
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerImageButt.h"


@interface CommentTopView : UIView

@property (strong,nonatomic) CustomeLzhLabel *leftDisplayLabel;

@property (strong,nonatomic) UIButton *cancelButt;

@property (copy,nonatomic) void (^clickCancelBlock)(void);

@end
