//
//  LzhReturnLabelHeight.h
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetCellHeight.h"

@interface LzhReturnLabelHeight : NSObject

+(CGFloat)getLabelHeight:(NSString*)content font:(UIFont*)targetFont width:(CGFloat)labelWidth;

+(CGFloat)getLabelWidth:(NSString*)content font:(UIFont*)targetFont targetHeight:(CGFloat)height;


@end
