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
#import "QuotePriceOnWebGroupView.h"



@interface TakeOrderQuotePriceTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *personLogoImaView;

@property (strong,nonatomic) UILabel *personNameLabel;

@property (strong,nonatomic) UILabel *timeLabel;

@property (strong,nonatomic) UILabel *detailLabel;

@property (strong,nonatomic) UILabel *praiseLabel;

@property (strong,nonatomic) UILabel *ticketsNumberLabel;

@property (strong,nonatomic) SDWeiXinPhotoContainerView *picContainView;

@property (strong,nonatomic) QuotePriceOnWebGroupView *bottomGroupView;

@property (strong,nonatomic) TakeOrderQuotePriceModel *model;
//isBaoJiaDetail:是报价用还是报价详情用
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier kindFlag:(BOOL)isBaoJiaDetail;

@end
