//
//  JHCollectionViewCell.m
//  WaterfallCollection
//
//  Created by Jivan on 2017/3/17.
//  Copyright © 2017年 Jivan. All rights reserved.
//

#import "JHCollectionViewCell.h"

@interface JHCollectionViewCell (){
    UIView *jobInfoMasterView;
}
@end
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
        jobInfoMasterView = [[UIView alloc] init];
        jobInfoMasterView.backgroundColor = [UIColor blackColor];
        jobInfoMasterView.alpha = 0.35;
        [self.contentView addSubview:jobInfoMasterView];
        //
        self.firstJobInfoView = [[WaterCellRecuritJobView alloc] init];
        [self.contentView addSubview:self.firstJobInfoView];
        //
        self.secondJobInfoView = [[WaterCellRecuritJobView alloc] init];
        [self.contentView addSubview:self.secondJobInfoView];
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
    //
    jobInfoMasterView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(40)
    .bottomEqualToView(self.topImageView);
    //
    self.firstJobInfoView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(jobInfoMasterView, 5)
    .heightRatioToView(jobInfoMasterView, 0.375);
    //
    self.secondJobInfoView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(self.firstJobInfoView, 5)
    .heightRatioToView(jobInfoMasterView, 0.375);
    
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
        if (model.recuritJobInfoArr.count){
            
            NSDictionary *jobInfoDict = model.recuritJobInfoArr[0];
             NSDictionary *secondJobInfoDict = model.recuritJobInfoArr[1];
            self.firstJobInfoView.leftPositionLabel.text = [jobInfoDict[@"0"] copy];
            self.firstJobInfoView.rightCountLabel.text = [jobInfoDict[@"1"] copy];
            self.secondJobInfoView.leftPositionLabel.text = [secondJobInfoDict[@"0"] copy];
            self.secondJobInfoView.rightCountLabel.text = [secondJobInfoDict[@"1"] copy];
        }
        
        self.companyNamelabel.text = [_model.companyNameStr copy];
        self.concernView.rightNumLabel.text = [_model.concernCountStr copy];
        //
        self.topImageView.sd_resetLayout
        .leftEqualToView(self.contentView)
        .topEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(_model.bigImageDisplayHeight);
        //
        jobInfoMasterView.sd_resetLayout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(40)
        .bottomEqualToView(self.topImageView);
        //
        self.firstJobInfoView.sd_resetLayout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .topSpaceToView(self.contentView, _model.bigImageDisplayHeight - jobInfoMasterView.height + 5)
         .heightRatioToView(jobInfoMasterView, 0.375);
        [self.firstJobInfoView LzhUpdateConstraints];
        //
        self.secondJobInfoView.sd_resetLayout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .topSpaceToView(self.firstJobInfoView, 5)
        .heightRatioToView(jobInfoMasterView, 0.375);
        [self.secondJobInfoView LzhUpdateConstraints];
        //图片下部区域为24
        self.companyLogoView.sd_resetLayout
        .leftSpaceToView(self.contentView, 7)
        .bottomSpaceToView(self.contentView, 9)
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
