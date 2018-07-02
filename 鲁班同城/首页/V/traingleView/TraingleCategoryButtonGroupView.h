//
//  TraingleCategoryButtonGroupView.h
//  鲁班同城
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TraingleCategoryButtonGroupView : UIView


@property (copy,nonatomic) void (^traingleButtBlock)(NSInteger index,UILabel *targetLabel);


@end
