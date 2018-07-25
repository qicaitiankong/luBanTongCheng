//
//  OwnTextView.h
//  鲁班同城
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnTextView : UIView

@property (strong,nonatomic) UITextView * writeTextView;

@property (strong,nonatomic) UILabel * writeViewPlaceHolderLabel;

@property (copy,nonatomic) void (^keyBoardChangedBlock)(CGFloat keyBoardHeight);

@property (copy,nonatomic) void (^keyBoardExistBlock)(void);


@end
