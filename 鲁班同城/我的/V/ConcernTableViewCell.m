//
//  ConcernTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "ConcernTableViewCell.h"

@implementation ConcernTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHieght:(CGFloat)height{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        CGFloat leftSpace = 15;
        self.userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(leftSpace, 0, height * 0.6, height * 0.6)];
        self.userImageView.backgroundColor = IMAGEVIEW_DEFAULT_COLOR;
        self.userImageView.clipsToBounds = YES;
        self.userImageView.center = CGPointMake(self.userImageView.centerX, height / 2);
        self.userImageView.layer.cornerRadius = self.userImageView.width / 2;
        [self.contentView addSubview:self.userImageView];
        //
        self.goImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 34 - 7, 0, 7, 13)];
        self.goImageView.center = CGPointMake(self.goImageView.centerX, height / 2);
        [self.goImageView setImage:[UIImage imageNamed:@"goFlag"]];
        [self.contentView addSubview:self.goImageView];
        //
        CGFloat nameHeight = self.userImageView.height / 2;
        self.nameLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:0];
        self.nameLabel.frame = CGRectMake(self.userImageView.right + 10, self.userImageView.top, self.goImageView.left - self.userImageView.right - 20, nameHeight);
        self.nameLabel.center = CGPointMake(self.nameLabel.centerX, height / 2);
        [self.contentView addSubview:self.nameLabel];
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
