//
//  SettingTableViewCell.h
//  鲁班同城
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewCell : UITableViewCell

@property (strong,nonatomic) UILabel *ownLeftLabel;

@property (strong,nonatomic) UILabel *ownRightLabel;

@property (strong,nonatomic) UIImageView *goImageView;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHeight:(CGFloat)height;


@end
