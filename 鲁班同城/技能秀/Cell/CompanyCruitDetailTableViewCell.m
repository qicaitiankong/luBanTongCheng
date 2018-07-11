//
//  CompanyCruitDetailTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/10.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CompanyCruitDetailTableViewCell.h"

@interface CompanyCruitDetailTableViewCell (){
    CGFloat leftSpace;
}
@end

@implementation CompanyCruitDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        leftSpace = 15;
        self.contentView.backgroundColor = [UIColor whiteColor];
        //应聘
        self.applyForJobButt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.applyForJobButt.backgroundColor = [UIColor whiteColor];
        [self.applyForJobButt setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        self.applyForJobButt.titleLabel.font = [UIFont getPingFangSCMedium:13];
        self.applyForJobButt.layer.cornerRadius = 5;
        self.applyForJobButt.layer.borderWidth = 1;
        self.applyForJobButt.layer.borderColor = [UIColor colorWithHexString:@"#BBBBBB"].CGColor;
        self.applyForJobButt.frame = CGRectMake(SCREEN_WIDTH - 60 - leftSpace, 10, 60, 25);
        [self.contentView addSubview:self.applyForJobButt];
        //详情
        self.detailButtView = [[DetailSmallButtView alloc]initWithFrame:CGRectMake(self.applyForJobButt.left - 40 - 10, self.applyForJobButt.top, 40, 15)];
        self.detailButtView.center = CGPointMake(self.detailButtView.centerX, self.applyForJobButt.centerY);
        [self.detailButtView.backButt addTarget:self action:@selector(detailButtClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.detailButtView];
        //工作
         self.jobLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        self.jobLabel.frame = CGRectMake(leftSpace, self.applyForJobButt.top, SCREEN_WIDTH - leftSpace - 10, self.applyForJobButt.height);
        [self.contentView addSubview:self.jobLabel];
        //
        self.detailContentLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:12] titleColor:[UIColor colorWithHexString:@"#999999"] aligement:0];
        self.detailContentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.detailContentLabel];
        //
        self.detailContentLabel.sd_resetLayout
        .leftEqualToView(self.jobLabel)
        .rightEqualToView(self.applyForJobButt)
        .topSpaceToView(self.jobLabel, 10)
        .autoHeightRatio(0);
    }
    return self;
}

- (void)detailButtClick{
    if (self.cliclDetailBlock){
        self.cliclDetailBlock(self.indexPath);
    }
}

- (void)setModel:(CompanyCruitDetailModel*)model{
    _model = model;
    
    if (model){
        self.jobLabel.text = [model.jobNameStr copy];
        self.detailContentLabel.text = [model.detailContentStr copy];
        [self.applyForJobButt setTitle:@"应聘" forState:UIControlStateNormal];
        if (model.isDetailDisplayState){
            [self.detailButtView setPullUpState];
            self.detailContentLabel.hidden = NO;
            [self setupAutoHeightWithBottomView:self.detailContentLabel bottomMargin:10];
        }else{
            [self.detailButtView setPullDownState];
            self.detailContentLabel.hidden = YES;
            [self setupAutoHeightWithBottomView:self.jobLabel bottomMargin:10];
        }
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
