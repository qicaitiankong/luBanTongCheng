//
//  KeyboardToolsView.h
//  鲁班同城
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardToolsView : UIView

@property (strong,nonatomic) CustomeStyleCornerButt *exixtButt;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)flagTitle;

@end
