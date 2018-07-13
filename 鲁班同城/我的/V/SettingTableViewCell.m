//
//  SettingTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHeight:(CGFloat)height{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        //
        self.ownLeftLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.ownLeftLabel.frame = CGRectMake(15, 0, 100, 15);
        self.ownLeftLabel.center = CGPointMake(self.ownLeftLabel.centerX,height / 2);
        [self.contentView addSubview:self.ownLeftLabel];
        //
        self.ownRightLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#999999"] aligement:2];
        self.ownRightLabel.frame = CGRectMake(SCREEN_WIDTH - 34 - 60, 0, 60, 15);
        self.ownRightLabel.center = CGPointMake(self.ownRightLabel.centerX,height / 2);
        [self.contentView addSubview:self.ownRightLabel];
        //
        self.goImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 34 - 7, 0, 7, 13)];
        self.goImageView.center = CGPointMake(self.goImageView.centerX, height / 2);
        [self.goImageView setImage:[UIImage imageNamed:@"goFlag"]];
        [self.contentView addSubview:self.goImageView];
        
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
