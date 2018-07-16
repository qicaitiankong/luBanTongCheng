//
//  searchBiaoQianView.m
//  鲁班同城
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "searchBiaoQianView.h"

@implementation searchBiaoQianView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat viewWidth = 70;
            CGFloat viewHeight = 20;
            CGFloat leftBeginSpace = 20;
            CGFloat topBeginSpace =  25;
            CGFloat centerHorizotalSpace = (frame.size.width - 3 * viewWidth - 2 * leftBeginSpace) / 3;
            CGFloat centerVerticalSpace = 10;
        UIView *lastView = nil;
            for (int i = 0; i < 6; i ++){
                SearchBiaoQianSmallView *biaoQianView = [[SearchBiaoQianSmallView alloc]initWithFrame:CGRectMake(leftBeginSpace + (i % 3) *(viewWidth + centerHorizotalSpace), topBeginSpace + (i / 3) * (viewHeight + centerVerticalSpace) , viewWidth, viewHeight)];
                biaoQianView.rightDisplayLabel.text = @"关键词";
                [self addSubview:biaoQianView];
                lastView = biaoQianView;
            }
        [self setFrame:CGRectMake(self.x, self.y, frame.size.width, lastView.bottom + centerVerticalSpace)];
    }
    return self;
}

@end
