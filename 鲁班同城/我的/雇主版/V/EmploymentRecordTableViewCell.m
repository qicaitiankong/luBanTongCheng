//
//  EmploymentRecordTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "EmploymentRecordTableViewCell.h"

@implementation EmploymentRecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHeight:(CGFloat)height{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentView.backgroundColor = RGBA(242, 242, 242, 1);
        UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, height * 0.9)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:baseView];
        //
        CGFloat leftSpaceToBaseView = 15;
        CGFloat rightGoWidth = 5;
        CGFloat rightGoHeight = 9;
        CGFloat stateLabelAndFlagImageSpace = 8;
        
        self.nameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.nameLabel.backgroundColor = [UIColor whiteColor];
        self.nameLabel.frame = CGRectMake(leftSpaceToBaseView, baseView.height * 0.08, baseView.width / 2, baseView.height * 0.1);
        [baseView addSubview:self.nameLabel];
        //
        self.stateLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#999999"] aligement:2];
        self.stateLabel.frame = CGRectMake(self.nameLabel.right, self.nameLabel.top, baseView.width / 2 - rightGoWidth - 2 * leftSpaceToBaseView - stateLabelAndFlagImageSpace, rightGoHeight);
        self.stateLabel.backgroundColor = [UIColor whiteColor];
        [baseView addSubview:self.stateLabel];
        //
        UIImageView *goFlagImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.stateLabel.right + stateLabelAndFlagImageSpace, self.stateLabel.top, rightGoWidth, rightGoHeight)];
        [goFlagImageView setImage:[UIImage imageNamed:@"goFlag"]];
        goFlagImageView.backgroundColor = [UIColor whiteColor];
        [baseView addSubview:goFlagImageView];
        //
        UIImageView *companyNameImageView = [[UIImageView alloc]initWithFrame:CGRectMake(leftSpaceToBaseView, self.nameLabel.bottom + baseView.height * 0.1, 8, 8)];
        companyNameImageView.backgroundColor = [UIColor whiteColor];
        [baseView addSubview:companyNameImageView];
        [companyNameImageView setImage:[UIImage imageNamed:@"companyName"]];
        //
        self.companyNameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        self.companyNameLabel.frame = CGRectMake(companyNameImageView.right + 8, 0, baseView.width - companyNameImageView.right - 8 - leftSpaceToBaseView, self.nameLabel.height);
        self.companyNameLabel.center = CGPointMake(self.companyNameLabel.centerX, companyNameImageView.centerY);
        [baseView addSubview:self.companyNameLabel];
        //
        UIImageView *timeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(leftSpaceToBaseView, self.companyNameLabel.bottom + baseView.height * 0.1, 8, 8)];
        timeImageView.backgroundColor = [UIColor whiteColor];
        [baseView addSubview:timeImageView];
        [timeImageView setImage:[UIImage imageNamed:@"companyTime"]];
        //
        self.timeLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        self.timeLabel.frame = CGRectMake(timeImageView.right + 8, 0, baseView.width - timeImageView.right - 8 - leftSpaceToBaseView, self.nameLabel.height);
        self.timeLabel.center = CGPointMake(self.timeLabel.centerX, timeImageView.centerY);
        [baseView addSubview:self.timeLabel];
        //
        UIImageView *addressImageView = [[UIImageView alloc]initWithFrame:CGRectMake(leftSpaceToBaseView, self.timeLabel.bottom + baseView.height * 0.1, 5, 8)];
        addressImageView.backgroundColor = [UIColor whiteColor];
        [baseView addSubview:addressImageView];
        [addressImageView setImage:[UIImage imageNamed:@"companyAddress"]];
        addressImageView.center = CGPointMake(timeImageView.centerX, addressImageView.centerY);
        //
        self.addressLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:14] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        self.addressLabel.numberOfLines = 2;
        self.addressLabel.frame = CGRectMake(addressImageView.right + 8, 0, baseView.width - addressImageView.right - 8 - leftSpaceToBaseView, self.nameLabel.height);
        self.addressLabel.center = CGPointMake(self.addressLabel.centerX, addressImageView.centerY);
        //继续重调
        self.addressLabel.frame = CGRectMake(self.addressLabel.x, self.addressLabel.y, self.addressLabel.width, baseView.height - self.addressLabel.top - 10);
        [baseView addSubview:self.addressLabel];
        
    }
    return self;
}

- (void)setModel:(EmploymentRecordModel*)model{
    
    _model = model;
    if (model){
        self.nameLabel.text = [model.topNameStr copy];
        self.companyNameLabel.text = [model.companyNameStr copy];
        self.stateLabel.text = [model.stateStr copy];
        self.timeLabel.text = [model.timeStr copy];
        self.addressLabel.text = [model.addressStr copy];
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
