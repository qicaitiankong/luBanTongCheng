//
//  CustomerLabelView.h
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerLabelView : UIView

@property (strong,nonatomic) UILabel *displayLabel;

- (void)giveTitles:(NSString*)str;


@end
