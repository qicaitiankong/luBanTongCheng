//
//  WriteCommentKeyboardInputView.h
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomeLabelButt.h"
#import "OwnTextView.h"

@interface WriteCommentKeyboardInputView : UIView

@property (strong,nonatomic) CustomeLabelButt *rightButtView;

@property (strong,nonatomic) OwnTextView *leftInputTextView;


@end
