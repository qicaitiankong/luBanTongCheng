//
//  OrderTakingQuotePriceDetailTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TakeOrderQuotePriceDetailModel.h"


@interface OrderTakingQuotePriceDetailTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *personLogoImaView;

@property (strong,nonatomic) UILabel *personNameLabel;

@property (strong,nonatomic) UILabel *timeLabel;

@property (strong,nonatomic) UILabel *detailLabel;

@property (strong,nonatomic) UILabel *praiseLabel;

@property (strong,nonatomic) UILabel *ticketsNumberLabel;

@property (strong,nonatomic) TakeOrderQuotePriceDetailModel *model;

@end
