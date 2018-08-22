//
//  WriteCommentKeyboardPop.h
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WriteCommentKeyboardInputView.h"

@interface WriteCommentKeyboardPop : NSObject

+ (void)showKeyBoardInputView:(void (^)(NSString* contentStr))inputContent leftTextViewTipStr:(NSString*)tipStr rightButtTitle:(NSString*)buttTitle;



@end
