//
//  chooseIdentityButtView.h
//  鲁班同城
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chooseIdentityButtView : UIView

@property (assign,nonatomic) BOOL selectedState;

@property (copy,nonatomic) void (^clickButtBlock)(void);

- (void)setNormalState;

- (void)setSelectedState;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title;

@end
