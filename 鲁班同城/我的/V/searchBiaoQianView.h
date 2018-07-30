//
//  searchBiaoQianView.h
//  鲁班同城
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBiaoQianSmallView.h"

@interface searchBiaoQianView : UIView

@property (copy,nonatomic) void (^flagViewBlock)(NSString *flagStr);

@end
