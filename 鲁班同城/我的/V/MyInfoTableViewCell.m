//
//  MyInfoTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MyInfoTableViewCell.h"

@interface MyInfoTableViewCell (){
    UIImageView *goFlagImageView;
}

@end

@implementation MyInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)cellHeight{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.leftImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.leftImageView];
        //
        goFlagImageView = [[UIImageView alloc] init];
        [goFlagImageView setImage:[UIImage imageNamed:@"goFlag"]];
        [self.contentView addSubview:goFlagImageView];
        //
        self.rightLabel = [[CustomeLzhLabel alloc] initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        [self.contentView addSubview:self.rightLabel];
        //
        self.leftImageView.sd_layout
        .leftSpaceToView(self.contentView,34)
        .widthIs(18)
        .heightIs(17)
        .centerYIs(cellHeight / 2);
        
        goFlagImageView.sd_layout
        .rightSpaceToView(self.contentView, 34)
        .widthIs(7)
        .heightIs(13)
        .centerYIs(cellHeight / 2);
        
        self.rightLabel.sd_layout
        .leftSpaceToView(self.leftImageView, 15)
        .rightSpaceToView(goFlagImageView, 15)
        .heightIs(cellHeight)
        .topEqualToView(self.contentView);
        
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
