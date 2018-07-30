//
//  SSSearchBar.h
//  Demo
//
//  Created by xk jiang on 2017/10/10.
//  Copyright © 2017年 xk jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardToolsView.h"

@interface SSSearchBar : UISearchBar

@property (assign,nonatomic) BOOL isNeedSearch;

@property (strong,nonatomic) UITextField *textField;

@property (copy,nonatomic) void (^clickTextFieldBlock)(void);

@property (copy,nonatomic) void (^searchTextFieldBlock)(NSString *targetStr);

@property (strong,nonatomic) KeyboardToolsView *toolsView;
@end
