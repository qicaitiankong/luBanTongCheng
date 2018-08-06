//
//  OwnPersonalInfoChoosePictureModel.m
//  鲁班同城
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalInfoChoosePictureModel.h"

@implementation OwnPersonalInfoChoosePictureModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectedImageArr = [[NSMutableArray alloc]init];
        self.selectedImageBaseStrArr = [[NSMutableArray alloc]init];
    }
    return self;
}


@end
