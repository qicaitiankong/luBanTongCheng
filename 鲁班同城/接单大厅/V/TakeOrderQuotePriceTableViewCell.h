//
//  TakeOrderQuotePriceTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWeiXinPhotoContainerView.h"
#import "TakeOrderQuotePriceModel.h"

@interface TakeOrderQuotePriceTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *personLogoImaView;

@property (strong,nonatomic) UILabel *personNameLabel;

@property (strong,nonatomic) UILabel *timeLabel;

@property (strong,nonatomic) UILabel *detailLabel;

@property (strong,nonatomic) UILabel *praiseLabel;

@property (strong,nonatomic) UILabel *ticketsNumberLabel;

@property (strong,nonatomic) SDWeiXinPhotoContainerView *picContainView;

@property (strong,nonatomic) TakeOrderQuotePriceModel *model;

@end
