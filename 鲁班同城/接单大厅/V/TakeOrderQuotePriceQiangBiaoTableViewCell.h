//
//  TakeOrderQuotePriceQiangBiaoTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TakeOrderQuotePriceModel.h"

@interface TakeOrderQuotePriceQiangBiaoTableViewCell : UITableViewCell


@property (strong,nonatomic) UIImageView *userImageView;

@property (strong,nonatomic) UILabel *nickNameLabel;

@property (strong,nonatomic) UILabel *baoJiaStateLabel;

@property (strong,nonatomic) TakeOrderQuotePriceModel *model;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHeight:(CGFloat)height;


@end
