//
//  EmploymentRecordTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmploymentRecordModel.h"

@interface EmploymentRecordTableViewCell : UITableViewCell

@property (strong,nonatomic) UILabel *nameLabel;

@property (strong,nonatomic) UILabel *stateLabel;

@property (strong,nonatomic) UILabel *companyNameLabel;

@property (strong,nonatomic) UILabel *timeLabel;

@property (strong,nonatomic) UILabel *addressLabel;

@property (strong,nonatomic) EmploymentRecordModel *model;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHeight:(CGFloat)height;


@end
