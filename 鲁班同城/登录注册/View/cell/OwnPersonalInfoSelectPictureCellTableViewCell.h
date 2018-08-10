//
//  OwnPersonalInfoSelectPictureCellTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwnPersonalInfoChoosePictureModel.h"

@interface OwnPersonalInfoSelectPictureCellTableViewCell : UITableViewCell

@property (strong,nonatomic) OwnPersonalInfoChoosePictureModel *model;

@property (strong,nonatomic) NSIndexPath *path;

@property (copy,nonatomic) void (^addPictureBlock)(NSIndexPath *path,NSInteger clickIndex);

@end
