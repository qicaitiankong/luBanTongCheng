//
//  chooseIdentityGroupButtView.h
//  鲁班同城
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chooseIdentityButtView.h"


@interface chooseIdentityGroupButtView : UIView

@property (strong,nonatomic) chooseIdentityButtView *capsualButtView;

@property (strong,nonatomic) chooseIdentityButtView *employmentButtView;

//0雇主 1;林工
@property (assign,nonatomic) NSInteger selectedUserType;


@end
