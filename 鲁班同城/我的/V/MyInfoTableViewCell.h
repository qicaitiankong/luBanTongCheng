//
//  MyInfoTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *leftImageView;

@property (strong,nonatomic) UILabel *rightLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)cellHeight;

@end
