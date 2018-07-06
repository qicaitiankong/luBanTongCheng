//
//  CustomerLabelView.m
//  鲁班同城
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CustomerLabelView.h"

@implementation CustomerLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithHexString:@"#C6C6C6"].CGColor;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 4;
        self.backgroundColor = [UIColor whiteColor];
        //
        self.displayLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:12] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:1];
        self.displayLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:self.displayLabel];
        
    }
    return self;
}

- (void)giveTitles:(NSString*)str{
    CGFloat labelWidth = [LzhReturnLabelHeight getLabelWidth:str font:[UIFont getPingFangSCMedium:12] targetHeight:self.height];
    self.displayLabel.text = str;
    [self setFrame:CGRectMake(self.x, self.y, labelWidth + 10, self.height)];
}


@end
