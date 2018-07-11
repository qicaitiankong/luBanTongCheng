//
//  UILabel+ChangeCustomeLineSpace.m
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UILabel+ChangeCustomeLineSpace.h"

@implementation UILabel (ChangeCustomeLineSpace)

+ (CGFloat)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.lineBreakMode = 0;
    label.attributedText = attributedString;
    [label sizeToFit];
    return label.height;
    //
//     self.labelEng = [[UILabel alloc] initWithFrame:CGRectMake(0, 500, [UIScreen mainScreen].bounds.size.width, 100)]; self.labelEng.backgroundColor = [UIColor yellowColor]; self.labelEng.font = [UIFont systemFontOfSize:12]; //自动折行设置 self.labelEng.lineBreakMode = 0; self.labelEng.numberOfLines = 3;//0 代表自动换行,1234...... 数字是几代表几行 self.labelEng.text = string; NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string]; NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init]; [paragraphStyle setLineSpacing:11];//行距 [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])]; [self.labelEng setAttributedText:attributedString]; [self.labelEng sizeToFit]
}


@end
