//
//  SearchBiaoQianSmallView.h
//  鲁班同城
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchBiaoQianSmallView : UIView

@property (strong,nonatomic) UILabel *rightDisplayLabel;

@property (copy,nonatomic) void (^backButtBlock)(NSString *title);

@end
