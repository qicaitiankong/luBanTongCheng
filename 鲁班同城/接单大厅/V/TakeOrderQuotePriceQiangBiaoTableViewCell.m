//
//  TakeOrderQuotePriceQiangBiaoTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "TakeOrderQuotePriceQiangBiaoTableViewCell.h"

@implementation TakeOrderQuotePriceQiangBiaoTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHeight:(CGFloat)height{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, height / 2, height / 2)];
        self.userImageView.backgroundColor = [UIColor grayColor];
        self.userImageView.layer.cornerRadius = self.userImageView.height / 2;
        self.userImageView.clipsToBounds = YES;
        self.userImageView.center = CGPointMake(self.userImageView.centerX, height / 2);
        [self.contentView addSubview:self.userImageView];
        //
        CGFloat stateLabelHeight = 15;
        CGFloat stateLabelWidth = [LzhReturnLabelHeight getLabelWidth:@"字字字字" font:[UIFont getPingFangSCMedium:13] targetHeight:stateLabelHeight];
        self.baoJiaStateLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#999999"] aligement:0];
        self.baoJiaStateLabel.frame = CGRectMake(SCREEN_WIDTH - 20 - stateLabelWidth, 0, stateLabelWidth, stateLabelHeight);
        self.baoJiaStateLabel.center = CGPointMake(self.baoJiaStateLabel.centerX, self.userImageView.centerY);
        [self.contentView addSubview:self.baoJiaStateLabel];
        //
        self.nickNameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        CGFloat nickNameLabeWidth = self.baoJiaStateLabel.left - self.userImageView.right - 20;
        self.nickNameLabel.frame = CGRectMake(self.userImageView.right + 10, 0, nickNameLabeWidth, self.userImageView.height * 0.8);
        self.nickNameLabel.center = CGPointMake(self.nickNameLabel.centerX, self.userImageView.centerY);
        self.nickNameLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.nickNameLabel];
    }
    return self;
}

- (void)setModel:(TakeOrderQuotePriceModel*)model{
    _model = model;
    if (model){
        [self.userImageView setImage:model.image];
        self.nickNameLabel.text = [model.nickNameStr copy];
        self.baoJiaStateLabel.text = [model.quoteStateStr copy];
    }
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
