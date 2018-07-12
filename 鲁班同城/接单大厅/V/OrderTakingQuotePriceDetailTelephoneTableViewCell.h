//
//  OrderTakingQuotePriceDetailTelephoneTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TakeOrderQuotePriceDetailModel.h"

@interface OrderTakingQuotePriceDetailTelephoneTableViewCell : UITableViewCell

@property (strong,nonatomic) UILabel *ownLeftLabel;

@property (strong,nonatomic) UILabel *ownRightLabel;

@property (strong,nonatomic) UIButton *telephoneButt;

@property (strong,nonatomic) TakeOrderQuotePriceDetailModel *model;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isNeedRightButt:(BOOL)isNeed;


@end
