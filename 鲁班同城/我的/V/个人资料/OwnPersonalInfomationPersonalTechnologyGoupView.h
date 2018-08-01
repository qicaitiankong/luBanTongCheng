//
//  OwnPersonalInfomationPersonalTechnologyGoupView.h
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageSoundView.h"

@interface OwnPersonalInfomationPersonalTechnologyGoupView : UIView
@property (strong,nonatomic) UILabel *topTipLabel;

//@property (strong,nonatomic) MessageSoundView *soundView;


- (void)giveOwnValue:(NSArray*)titlesArr;

@end
