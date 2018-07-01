//
//  GetCellHeight.m
//  Liankeji
//
//  Created by 李自豪 on 16/12/2.
//  Copyright © 2016年 haichuanhuiwulianxinxi. All rights reserved.
//

#import "GetCellHeight.h"
 GetCellHeight *getCellHeight = nil;
@implementation GetCellHeight
+ (GetCellHeight*)ShareCellHeight{
    getCellHeight = [[GetCellHeight alloc]init];
    return getCellHeight;
}
- (CGFloat)cellHeight:(UILabel*)targetLabel content:(NSString *)_contentString Cellwidth:(CGFloat)_width{
    CGFloat height = 0;
    //NSLog(@"%lf",targetLabel.frame.size.width);
    UILabel *lable = [[UILabel alloc]init];
    lable.backgroundColor = [UIColor grayColor];
    lable.numberOfLines = 0;
    lable.textAlignment = targetLabel.textAlignment;
    lable.font = targetLabel.font;
    lable.text = _contentString;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:lable.font forKey:NSFontAttributeName];
     CGRect rect = [lable.text boundingRectWithSize:CGSizeMake(_width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  attributes:dict context:nil];
    height = rect.size.height;
    return height;
}
- (CGFloat)cellWidth:(UILabel*)targetLabel content:(NSString *)_contentString CellHeight:(CGFloat)_height{
    CGFloat width = 0;
    UILabel *lable = [[UILabel alloc]init];
    lable.backgroundColor = [UIColor grayColor];
    lable.numberOfLines = 1;
    lable.textAlignment = targetLabel.textAlignment;
    lable.font = targetLabel.font;
    lable.text = _contentString;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:lable.font forKey:NSFontAttributeName];
    CGRect rect = [lable.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, _height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  attributes:dict context:nil];
    width = rect.size.width;
    return width;
}

@end
