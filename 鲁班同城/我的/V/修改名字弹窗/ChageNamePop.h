//
//  ChageNamePop.h
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChangeNamePopView.h"


@interface ChageNamePop : NSObject

@property (strong,nonatomic) ChangeNamePopView *popView;

@property (strong,nonatomic) UIView *zheZhaoView;

+ (void)showPopView:(void (^)(NSString* nameStr))sureBlock;

@end
