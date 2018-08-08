//
//  ChooseTechnologyLeftModel.h
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseTechnologyLeftModel : NSObject

@property (assign,nonatomic) NSInteger idFlag;

@property (assign,nonatomic) NSInteger parentId;

@property (strong,nonatomic) NSString *title;

@property (assign,nonatomic) BOOL judgeSelected;

@property (assign,nonatomic) NSIndexPath *indexPath;


@end
