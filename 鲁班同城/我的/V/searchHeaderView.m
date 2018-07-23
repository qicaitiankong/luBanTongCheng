//
//  searchHeaderView.m
//  鲁班同城
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "searchHeaderView.h"

@implementation searchHeaderView

@synthesize navReturnButt;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        navReturnButt = [NavTools getOwnNavStyleGrayReturnButt];
        [self addSubview:navReturnButt];
        
        self.searchView = [[SSSearchBar alloc] initWithFrame:CGRectMake(navReturnButt.right + 10, 0, frame.size.width - navReturnButt.right - 10 - 15, frame.size.height * 0.9)];
        self.searchView.isNeedSearch = YES;
        self.searchView.placeholder = @"输入搜索内容";
        [self addSubview: self.searchView];
        self.searchView.center = CGPointMake(self.searchView.centerX, frame.size.height / 2);
        //
        navReturnButt.center = CGPointMake(navReturnButt.centerX, self.searchView.centerY);
    }
    return self;
}

@end
