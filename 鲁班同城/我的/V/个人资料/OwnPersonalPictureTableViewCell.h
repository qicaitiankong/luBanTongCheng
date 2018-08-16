//
//  OwnPersonalPictureTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwnPersonalInfoModel.h"


@interface OwnPersonalPictureTableViewCell : UITableViewCell

@property (strong,nonatomic) OwnPersonalInfoModel *model;

@property (strong,nonatomic) NSIndexPath *path;


@end
