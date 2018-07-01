//
//  LzhReturnLabelHeight.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "LzhReturnLabelHeight.h"

@implementation LzhReturnLabelHeight

+(CGFloat)getLabelHeight:(NSString*)content font:(UIFont*)targetFont width:(CGFloat)labelWidth{
    CGFloat h = 0;
    LzhReturnLabelHeight *selfClass = [[LzhReturnLabelHeight alloc]init];
    if(selfClass){
        UILabel *modelLabel = [[UILabel alloc]init];
        modelLabel.font = targetFont;
        h =  [[GetCellHeight ShareCellHeight] cellHeight:modelLabel content:content Cellwidth:labelWidth];
        return h + 1;
    }
    return h;
}

+(CGFloat)getLabelWidth:(NSString*)content font:(UIFont*)targetFont targetHeight:(CGFloat)height{
    CGFloat w = 0;
    LzhReturnLabelHeight *selfClass = [[LzhReturnLabelHeight alloc]init];
    if(selfClass){
        UILabel *modelLabel = [[UILabel alloc]init];
        modelLabel.font = targetFont;
        w =  [[GetCellHeight ShareCellHeight] cellWidth:modelLabel content:content CellHeight:height];
        return w + 1;
    }
    return w;
}

@end
