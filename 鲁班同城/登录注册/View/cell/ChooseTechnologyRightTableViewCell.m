//
//  ChooseTechnologyRightTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ChooseTechnologyRightTableViewCell.h"

@implementation ChooseTechnologyRightTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHeight:(CGFloat)height cellWidth:(CGFloat)width{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        //
        self.userImageView = [[UIImageView alloc] init];
        self.userImageView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        CGFloat imageViewHeight = (height - 2 * 7) ;
        self.userImageView.frame = CGRectMake(7, 7, imageViewHeight, imageViewHeight);
        [self.contentView addSubview:self.userImageView];
        //
        self.jobNameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.jobNameLabel.backgroundColor = [UIColor whiteColor];
        CGFloat labelLeft = self.userImageView.left + self.userImageView.width + 10;
        self.jobNameLabel.frame = CGRectMake(labelLeft, 0, width - labelLeft - height * 0.45 - 15, height * 0.8);
        self.jobNameLabel.center = CGPointMake(self.jobNameLabel.centerX, height / 2);
        [self.contentView addSubview:self.jobNameLabel];
        //
        self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.jobNameLabel.right + 10, 0, height * 0.45, height * 0.45)];
        self.rightImageView.backgroundColor = [UIColor whiteColor];
        self.rightImageView.center = CGPointMake(self.rightImageView.centerX, height / 2);
        [self.contentView addSubview:self.rightImageView];
    }
    return self;
}


- (void)setModel:(ChooseTechnologyLeftModel*)model{
    _model = model;
    model.indexPath = self.indexPath;
    if (model.judgeSelected){
        [self.rightImageView setImage:[UIImage imageNamed:@"rightSelected"]];
    }else{
        UIImage *image = [[UIImage alloc]init];
        [self.rightImageView setImage:image];
    }
    self.jobNameLabel.text = [model.title copy];
    
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
