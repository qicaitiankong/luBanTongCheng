//
//  SkillShowCommentToolView.h
//  鲁班同城
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageAndLabelView.h"
#import "CustomerImageButt.h"
#import "CustomeLabelButt.h"

@interface SkillShowCommentToolView : UIView

@property (strong,nonatomic) CustomeLabelButt *sayMoreButt;

@property (strong,nonatomic) ImageAndLabelView *commentView;

@property (strong,nonatomic) ImageAndLabelView *praiseView;

@property (strong,nonatomic) CustomerImageButt *sharButt;

@end
