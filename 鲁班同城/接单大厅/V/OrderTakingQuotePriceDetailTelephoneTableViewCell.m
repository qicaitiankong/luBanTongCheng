//
//  OrderTakingQuotePriceDetailTelephoneTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "OrderTakingQuotePriceDetailTelephoneTableViewCell.h"

@interface OrderTakingQuotePriceDetailTelephoneTableViewCell (){
    CGFloat leftLabelWidth;
    CGFloat leftLabelHeight;
}
@end


@implementation OrderTakingQuotePriceDetailTelephoneTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isNeedRightButt:(BOOL)isNeed{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentView.backgroundColor = [UIColor redColor];
        leftLabelHeight = 15;
        //
        leftLabelWidth = [LzhReturnLabelHeight getLabelWidth:@"字字字" font:[UIFont getPingFangSCMedium:13]  targetHeight:leftLabelHeight];
        self.ownLeftLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        //
         self.ownRightLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.ownRightLabel.numberOfLines = 0;
        //
        self.telephoneButt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.telephoneButt.backgroundColor = [UIColor grayColor];
        //
        NSArray *viewArr = @[self.ownLeftLabel,self.telephoneButt,self.ownRightLabel];
        //
        [self.contentView sd_addSubviews:viewArr];
        //
        self.ownLeftLabel.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 10)
        .widthIs(leftLabelWidth)
        .heightIs(leftLabelHeight);
//        //
//        //if (isNeed){
            self.telephoneButt.sd_layout
            .rightSpaceToView(self.contentView, 15)
            .widthIs(78)
            .heightIs(20)
            .topEqualToView(self.ownLeftLabel);
            //
            self.ownRightLabel.sd_layout
            .leftSpaceToView(self.ownLeftLabel, 10)
            .rightSpaceToView(self.contentView, 110)
            .topEqualToView(self.ownLeftLabel)
            .autoHeightRatio(0);
//        }else{
//            self.ownRightLabel.sd_layout
//            .leftSpaceToView(self.ownLeftLabel, 10)
//            .rightSpaceToView(self.contentView, 15)
//            .topEqualToView(self.ownLeftLabel)
//            .autoHeightRatio(0);
//        }
       
    }
    return self;
}

- (void)setLocalModel:(TakeOrderQuotePriceDetailModel*)localModel{
    _localModel = localModel;
    if (localModel){
        self.ownLeftLabel.text = [localModel.personInfoTipStr copy];
        self.ownRightLabel.text = [localModel.personInfoStr copy];
        [self setupAutoHeightWithBottomView:self.ownRightLabel bottomMargin:10];
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
