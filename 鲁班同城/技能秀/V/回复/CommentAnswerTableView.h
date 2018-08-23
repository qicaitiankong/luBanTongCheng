//
//  CommentAnswerTableView.h
//  鲁班同城
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentAnswerTableView : UIView

- (void)giveTopSingleModel:(CommentModel*)model;


- (void)showAnswetView;

- (void)dismissAnswerViewFromBottom;

@end
