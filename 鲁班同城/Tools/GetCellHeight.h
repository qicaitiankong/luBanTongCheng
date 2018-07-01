//
//  GetCellHeight.h
//  Liankeji
//
//  Created by 李自豪 on 16/12/2.
//  Copyright © 2016年 haichuanhuiwulianxinxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GetCellHeight : NSObject
//
+ (GetCellHeight*)ShareCellHeight;
//返回字符串高度
- (CGFloat)cellHeight:(UILabel*)targetLabel content:(NSString *)_contentString Cellwidth:(CGFloat)_width;

- (CGFloat)cellWidth:(UILabel*)targetLabel content:(NSString *)_contentString CellHeight:(CGFloat)_height;

@end
