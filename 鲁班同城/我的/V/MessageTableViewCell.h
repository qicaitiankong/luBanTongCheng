//
//  MessageTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MessageTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *userImageView;

@property (strong,nonatomic) UILabel *nameLabel;

@property (strong,nonatomic) UILabel *jobLabel;

@property (strong,nonatomic) UILabel *messageLabel;

@property (strong,nonatomic) UILabel *timeLabel;

@property (strong,nonatomic) MessageModel *model;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHieght:(CGFloat)height;


@end
