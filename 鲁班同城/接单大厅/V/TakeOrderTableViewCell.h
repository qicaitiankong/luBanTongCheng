//
//  TakeOrderTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TakeOrderMainHallModel.h"

@interface TakeOrderTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *personLogoImaView;

@property (strong,nonatomic) UILabel *personNameLabel;

@property (strong,nonatomic) UILabel *timeLabel;

@property (strong,nonatomic) UILabel *detailLabel;

@property (strong,nonatomic) UILabel *praiseLabel;

@property (strong,nonatomic) UILabel *ticketsNumberLabel;

@property (strong,nonatomic) TakeOrderMainHallModel *model;

@property (strong,nonatomic) NSIndexPath *indexPath;

@property (copy,nonatomic) void (^bottomButtBlock)(NSIndexPath *indexPath);

- (void)setModel:(TakeOrderMainHallModel*)model;

@end
