//
//  WriteCommentInputView.h
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WriteCommentInputView : UIView

//
@property (strong,nonatomic) UIImageView *pencilImageView;

@property (strong,nonatomic) CustomeLzhLabel *rightTipLabel;

@property (copy,nonatomic) void (^clickButtClick)(void);

@end
