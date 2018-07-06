//
//  ChooseTechnologyLeftTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ChooseTechnologyLeftTableViewCell.h"

@implementation ChooseTechnologyLeftTableViewCell


- (void)setModel:(ChooseTechnologyLeftModel*)model{
    _model = model;
    model.indexPath = self.indexPath;
    if (model.judgeSelected){
        UIColor *changeColor = [UIColor colorWithHexString:@"#78CAC5"];
        self.contentView.backgroundColor = changeColor;
        self.textLabel.backgroundColor = changeColor;
    }else{
        UIColor *normalColor = [UIColor whiteColor];
        self.contentView.backgroundColor = normalColor;
        self.textLabel.backgroundColor = normalColor;
    }
    self.textLabel.text = [model.title copy];
    
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
