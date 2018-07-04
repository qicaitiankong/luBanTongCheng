//
//  PersonalInfoExchangeViceTextView.h
//  鲁班同城
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInfoExchangeViceTextView : UIView

@property (copy,nonatomic) void (^clickSoundTextChangeViewBlock)(BOOL isSound);

- (void)addOwnContraints;


@end
