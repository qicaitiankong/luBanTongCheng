//
//  OrderTakingQuotePriceDetailTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "OrderTakingQuotePriceDetailTableViewCell.h"

@interface OrderTakingQuotePriceDetailTableViewCell (){
    CGFloat leftSpace;
}
@end

@implementation OrderTakingQuotePriceDetailTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        leftSpace = 15;
        self.contentView.backgroundColor = [UIColor whiteColor];
        //
        self.personLogoImaView = [[UIImageView alloc] init];
        self.personLogoImaView.backgroundColor = IMAGEVIEW_DEFAULT_COLOR;
        self.personLogoImaView.layer.cornerRadius = SCREEN_HEIGHT * 0.104 / 2;
        self.personLogoImaView.clipsToBounds = YES;
        //
        self.personNameLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:15] titleColor:[UIColor colorWithRed:65.0021/255.0 green:65.0021/255.0 blue:65.0021/255.0 alpha:1] aligement:0];
        //
        self.timeLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:11] titleColor:[UIColor colorWithRed:153.003/255.0 green:153.003/255.0 blue:153.003/255.0 alpha:1] aligement:2];
        
        //
        self.detailLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:12] titleColor:[UIColor colorWithRed:153.003/255.0 green:153.003/255.0 blue:153.003/255.0 alpha:1] aligement:0];
        self.detailLabel.numberOfLines = 0;
        //
        self.praiseLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:15] titleColor:[UIColor colorWithRed:65.0021/255.0 green:65.0021/255.0 blue:65.0021/255.0 alpha:1] aligement:0];
        //
        self.ticketsNumberLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:12] titleColor:[UIColor colorWithRed:51.0026/255.0 green:51.0026/255.0 blue:51.0026/255.0 alpha:1] aligement:2];
        //
        NSArray *viewArr = @[self.personLogoImaView,self.timeLabel,self.personNameLabel,self.detailLabel,self.ticketsNumberLabel,self.praiseLabel];
        [self.contentView sd_addSubviews:viewArr];
        [self addOwnConstraints];
    }
    return self;
}

- (void)addOwnConstraints{
    self.personLogoImaView.sd_layout
    .leftSpaceToView(self.contentView, leftSpace)
    .topSpaceToView(self.contentView, 20)
    .widthIs(SCREEN_HEIGHT * 0.104)
    .heightIs(SCREEN_HEIGHT * 0.104);
    
    self.timeLabel.sd_layout
    .widthIs(80)
    .rightSpaceToView(self.contentView, leftSpace)
    .topSpaceToView(self.contentView, 20 + 5)
    .heightIs(10);
    
    self.personNameLabel.sd_layout
    .topEqualToView(self.timeLabel)
    .heightIs(14)
    .leftSpaceToView(self.personLogoImaView, 17)
    .rightSpaceToView(self.timeLabel, 10);
    
    self.detailLabel.sd_layout
    .leftEqualToView(self.personNameLabel)
    .rightEqualToView(self.timeLabel)
    .topSpaceToView(self.personNameLabel, 8)
    .autoHeightRatio(0);
    
    self.ticketsNumberLabel.sd_layout
    .rightEqualToView(self.detailLabel)
    .widthIs(90)
    .topSpaceToView(self.detailLabel, 15)
    .heightIs(15);
    
    self.praiseLabel.sd_layout
    .leftEqualToView(self.detailLabel)
    .rightSpaceToView(self.ticketsNumberLabel, 10)
    .topEqualToView(self.ticketsNumberLabel)
    .heightIs(15);
    
}

- (void)setModel:(TakeOrderQuotePriceDetailModel*)model{
    _model = model;
    if (_model){
        if (model.logoUrlStr.length){
            [self.personLogoImaView sd_setImageWithURL:[NSURL URLWithString:model.logoUrlStr]];
        }
        self.personNameLabel.text = [model.personNameStr copy];
        self.timeLabel.text = [model.timeStr copy];
        self.detailLabel.text = [model.detailStr copy];
        self.praiseLabel.text = [NSString stringWithFormat:@"赏金：%@元",model.praiseStr];
        self.ticketsNumberLabel.text = [NSString stringWithFormat:@"抢单名额:%@",model.ticketsNumberStr];
        
        self.ticketsNumberLabel.sd_resetLayout
        .rightEqualToView(self.detailLabel)
        .widthIs(90)
        .topSpaceToView(self.detailLabel, 15)
        .heightIs(15);
        //
        self.praiseLabel.sd_resetLayout
        .leftEqualToView(self.detailLabel)
        .rightSpaceToView(self.ticketsNumberLabel, 10)
        .topEqualToView(self.ticketsNumberLabel)
        .heightIs(15);
        //
        [self setupAutoHeightWithBottomView:self.praiseLabel bottomMargin:15];
        
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
