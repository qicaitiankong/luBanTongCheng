//
//  JHCollectionViewCell.m
//  WaterfallCollection
//
//  Created by Jivan on 2017/3/17.
//  Copyright © 2017年 Jivan. All rights reserved.
//

#import "JHCollectionViewCell.h"


@implementation JHCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        //
        self.topImageView = [[UIImageView alloc] init];
        self.topImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.topImageView];
        //
        self.companyLogoView = [[UIImageView alloc] init];
        self.companyLogoView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.companyLogoView];
        //
        self.concernView = [[ConcernDisplayView alloc] init];
        [self.contentView addSubview:self.concernView];
        //
        self.companyNamelabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:9] titleColor:[UIColor blackColor] aligement:0];
        [self.contentView addSubview:self.companyNamelabel];
        //
        [self addOwnConstraints];
    }
    
    return self;
}

- (void)addOwnConstraints{
    self.topImageView.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(20);
    //图片下部区域为24
    self.companyLogoView.sd_layout
    .leftSpaceToView(self.contentView, 7)
    .bottomSpaceToView(self.contentView, 12)
    .widthIs(30)
    .heightEqualToWidth();
    self.companyLogoView.layer.cornerRadius = 15;
    
    self.concernView.sd_layout
    .widthIs(45)
    .rightSpaceToView(self.contentView, 5)
    .heightIs(12)
    .bottomEqualToView(self.companyLogoView);
    [self.concernView addOwnConstraints];
    //
    self.companyNamelabel.sd_layout
    .leftSpaceToView(self.companyLogoView, 5)
    .rightSpaceToView(self.concernView, 3)
    .bottomEqualToView(self.companyLogoView)
    .heightIs(12);
}

- (void)setModel:(FirstPageInfoModel*)model{
    _model = model;
    if (_model){
        [self.topImageView setImage:_model.bigImage];
        [self.companyLogoView setImage:_model.logoImage];
        self.companyNamelabel.text = [_model.companyNameStr copy];
        self.concernView.rightNumLabel.text = [_model.concernCountStr copy];
        //
        self.topImageView.sd_resetLayout
        .leftEqualToView(self.contentView)
        .topEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(_model.bigImageDisplayHeight);
        //图片下部区域为24
        self.companyLogoView.sd_resetLayout
        .leftSpaceToView(self.contentView, 7)
        .bottomSpaceToView(self.contentView, 12)
        .widthIs(30)
        .heightEqualToWidth();
        self.companyLogoView.layer.cornerRadius = 15;
        
        self.concernView.sd_resetLayout
        .widthIs(45)
        .rightSpaceToView(self.contentView, 5)
        .heightIs(12)
        .bottomEqualToView(self.companyLogoView);
        //
        self.companyNamelabel.sd_resetLayout
        .leftSpaceToView(self.companyLogoView, 5)
        .rightSpaceToView(self.concernView, 3)
        .bottomEqualToView(self.companyLogoView)
        .heightIs(12);
    }
    
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
