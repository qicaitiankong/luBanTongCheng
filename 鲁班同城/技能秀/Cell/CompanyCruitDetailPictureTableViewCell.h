//
//  CompanyCruitDetailPictureTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyCruitDetailModel.h"

@interface CompanyCruitDetailPictureTableViewCell : UITableViewCell

@property (strong,nonatomic) UILabel *topTipLabel;

@property (strong,nonatomic) UILabel *detailContentLabel;

@property (strong,nonatomic) CompanyCruitDetailModel *model;

@end
