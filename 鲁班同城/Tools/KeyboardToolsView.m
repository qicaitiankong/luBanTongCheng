//
//  KeyboardToolsView.m
//  鲁班同城
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "KeyboardToolsView.h"

@implementation KeyboardToolsView
@synthesize exixtButt;


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)flagTitle
{
    self = [super initWithFrame:frame];
    if (self) {
            self.backgroundColor = [UIColor whiteColor];
            UIColor *buttBackColor = SPECIAL_BLUE_COLOR;
            //
            exixtButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(frame.size.width - 100, 0, 90, frame.size.height * 0.8) backColor:buttBackColor cornerRadius:8 title:flagTitle titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:14]];
            [self addSubview:exixtButt];
            exixtButt.center = CGPointMake(exixtButt.centerX, frame.size.height / 2);
            //
            UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
            topLine.backgroundColor = [UIColor colorWithHexString:@"#C6C6C6"];
            [self addSubview:topLine];
        
    }
    return self;
}

@end
