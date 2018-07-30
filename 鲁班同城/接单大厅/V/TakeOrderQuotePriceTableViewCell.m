//
//  TakeOrderQuotePriceTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "TakeOrderQuotePriceTableViewCell.h"

@interface TakeOrderQuotePriceTableViewCell (){
    CGFloat leftSpace;
    BOOL isBaoJiaXiangQing;
}
@end


@implementation TakeOrderQuotePriceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier kindFlag:(BOOL)isBaoJiaDetail{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        leftSpace = 15;
        isBaoJiaXiangQing = isBaoJiaDetail;
        self.contentView.backgroundColor = [UIColor whiteColor];
        //
        self.personLogoImaView = [[UIImageView alloc] init];
        self.personLogoImaView.backgroundColor = [UIColor grayColor];
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
        self.picContainView = [SDWeiXinPhotoContainerView new];
        //
        NSArray *viewArr = @[self.personLogoImaView,self.timeLabel,self.personNameLabel,self.detailLabel,self.ticketsNumberLabel,self.praiseLabel,self.picContainView];
        [self.contentView sd_addSubviews:viewArr];
        //
        if (isBaoJiaDetail){
            self.bottomGroupView = [[QuotePriceOnWebGroupView alloc]initWithFrame:CGRectMake(leftSpace, 0, SCREEN_WIDTH - 2 * leftSpace, 10)];
            [self.contentView addSubview:self.bottomGroupView];
        }
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
    .widthIs(60)
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
    //
    self.picContainView.sd_layout
    .leftEqualToView(self.personLogoImaView)
    .topSpaceToView(self.praiseLabel, 15);
    //
    if (isBaoJiaXiangQing){
        self.bottomGroupView.sd_layout
        .leftEqualToView(self.personLogoImaView)
        .topSpaceToView(self.picContainView, 10)
        .rightSpaceToView(self.contentView, 20)
        .heightIs(self.bottomGroupView.height);
    }
    
}

- (void)setModel:(TakeOrderQuotePriceModel*)model{
    _model = model;
    if (_model){
        [self.personLogoImaView setImage:model.image];
        self.personNameLabel.text = [model.personNameStr copy];
        self.timeLabel.text = [model.timeStr copy];
        self.detailLabel.text = [model.detailStr copy];
        self.praiseLabel.text = [NSString stringWithFormat:@"赏金： %@",model.praiseStr];
        self.ticketsNumberLabel.text = [NSString stringWithFormat:@"抢单名额 %@",model.ticketsNumberStr];
        [self.picContainView setPicPathStringsArray:model.imageUrls];
        //
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
        self.picContainView.sd_layout
        .topSpaceToView(self.praiseLabel, 15);
        //
        UIView *botView = nil;
        //
        if (isBaoJiaXiangQing){
            self.bottomGroupView.sd_layout
            .leftEqualToView(self.personLogoImaView)
            .topSpaceToView(self.picContainView, 10)
            .rightSpaceToView(self.contentView, leftSpace)
            .heightIs(self.bottomGroupView.height);
            botView = self.bottomGroupView;
        }else{
            botView = self.bottomGroupView;
        }
        
        //
        [self setupAutoHeightWithBottomView:botView bottomMargin:15];
        
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
