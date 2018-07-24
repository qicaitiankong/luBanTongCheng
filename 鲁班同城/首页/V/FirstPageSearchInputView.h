//
//  FirstPageSearchInputView.h
//  鲁班同城
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISearchBar+CustomeStyle.h"

@interface FirstPageSearchInputView : UIView

- (void)addConstraints;

@property (copy,nonatomic) void (^clickLocationCity)(UIButton *targetCityButton);

@property (copy,nonatomic) void (^clickTextViewBlock)(void);


@end
