//
//  MessageTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHieght:(CGFloat)height{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        CGFloat leftSpace = 15;
        self.userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(leftSpace, 0, height * 0.8, height * 0.8)];
        self.userImageView.backgroundColor = IMAGEVIEW_DEFAULT_COLOR;
        self.userImageView.clipsToBounds = YES;
        self.userImageView.center = CGPointMake(self.userImageView.centerX, height / 2);
        self.userImageView.layer.cornerRadius = self.userImageView.width / 2;
        [self.contentView addSubview:self.userImageView];
        //
        CGFloat nameHeight = (self.userImageView.height - 5) / 2;
        CGFloat nameWidth = [LzhReturnLabelHeight getLabelWidth:@"字字字" font:[UIFont getPingFangSCMedium:16] targetHeight:nameHeight];
        
        self.nameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.nameLabel.frame = CGRectMake(self.userImageView.right + 5, self.userImageView.top, nameWidth, nameHeight);
        [self.contentView addSubview:self.nameLabel];
        //
        CGFloat timeHeight = nameHeight;
        CGFloat timeWidth = [LzhReturnLabelHeight getLabelWidth:@"字字字字" font:[UIFont getPingFangSCMedium:12] targetHeight:timeHeight];
        //
        self.timeLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:12] titleColor: [UIColor colorWithHexString:@"#999999"] aligement:0];
        self.timeLabel.frame = CGRectMake(SCREEN_WIDTH -  timeWidth - 25, self.nameLabel.top, timeWidth, timeHeight);
        [self.contentView addSubview:self.timeLabel];
        //
        self.jobLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:12] titleColor: [UIColor colorWithHexString:@"#999999"] aligement:0];
        self.jobLabel.frame = CGRectMake(self.nameLabel.right + 5, self.nameLabel.top, self.timeLabel.left - self.nameLabel.right - 15 , self.nameLabel.height);
        [self.contentView addSubview:self.jobLabel];
        //
        self.messageLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCRegular:13] titleColor:[UIColor colorWithHexString:@"#999999"] aligement:0];
        self.messageLabel.frame = CGRectMake(self.nameLabel.left, self.nameLabel.bottom + 5, self.timeLabel.right - self.nameLabel.left, self.nameLabel.height);
        [self.contentView addSubview:self.messageLabel];
    }
    return self;
}

- (void)setModel:(MessageModel*)model{
    _model = model;
    [self.userImageView setImage:model.userImage];
    self.nameLabel.text = [model.nameStr copy];
    self.jobLabel.text = [model.jobStr copy];
    self.messageLabel.text = [model.messageStr copy];
    self.timeLabel.text = [model.timeStr copy];
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
