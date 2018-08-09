//
//  OwnPersonalInfoChoosePictureModel.h
//  鲁班同城
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OwnPersonalInfoChoosePictureModel : NSObject

@property (strong,nonatomic) NSMutableArray *selectedImageArr;

//实际上是数组里面是data，字段名没有改过来，地方太多
@property (strong,nonatomic) NSMutableArray *selectedImageBaseStrArr;

@property (strong,nonatomic) NSArray *imageUrlStrArr;

@end
