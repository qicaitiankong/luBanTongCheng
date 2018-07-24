//
//  FirstPageSearchInputView.m
//  鲁班同城
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "FirstPageSearchInputView.h"

@interface FirstPageSearchInputView (){
    UIImageView *smallImageView;
    UIView *verticalLine;
    UIButton *cityBackButt;
    UIButton *textViewBackButt;
}

@property (strong,nonatomic) UIButton *locationCityButt;

@property (strong,nonatomic) UISearchBar *mySearchView;

@end

@implementation FirstPageSearchInputView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.locationCityButt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.locationCityButt.titleLabel.font = [UIFont getPingFangSCMedium:16];
        self.locationCityButt.backgroundColor = [UIColor whiteColor];
        [self.locationCityButt setTitleColor:[UIColor colorWithRed:101.997/255.0 green:101.997/255.0 blue:101.997/255.0 alpha:1] forState:UIControlStateNormal];
        [self.locationCityButt setTitle:@"青岛" forState:UIControlStateNormal];
        
        [self addSubview:self.locationCityButt];
        //
        smallImageView = [[UIImageView alloc] init];
        smallImageView.backgroundColor = [UIColor whiteColor];
        [smallImageView setImage:[UIImage imageNamed:@"traingle"]];
        [self addSubview:smallImageView];
        //
        verticalLine = [[UIView alloc] init];
        verticalLine.backgroundColor = [UIColor colorWithRed:125.001/255.0 green:125.001/255.0 blue:125.001/255.0 alpha:1];
        [self addSubview:verticalLine];
        //
        self.mySearchView = [UISearchBar getFirstPageStyleSearchBar];
        [self addSubview:self.mySearchView];
        //
        textViewBackButt = [UIButton buttonWithType:UIButtonTypeCustom];
        [textViewBackButt addTarget:self action:@selector(textViewBackButtHandler:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:textViewBackButt];
        //
        cityBackButt = [UIButton buttonWithType:UIButtonTypeCustom];
        [cityBackButt addTarget:self action:@selector(cityButtHandler:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cityBackButt];
        
    }
    return self;
}

- (void)addConstraints{
    self.locationCityButt.sd_layout
    .leftSpaceToView(self, 2)
    .topEqualToView(self)
    .bottomEqualToView(self)
    .widthIs(40);
    
    smallImageView.sd_layout
    .leftSpaceToView(self.locationCityButt, 3)
    .widthIs(6)
    .heightIs(5)
    .centerYEqualToView(self);
    
    verticalLine.sd_layout
    .leftSpaceToView(smallImageView, 12)
    .widthIs(1)
    .heightRatioToView(self, 0.6)
    .centerYEqualToView(self);
    
    self.mySearchView.sd_layout
    .leftSpaceToView(verticalLine, 2)
    .rightSpaceToView(self, 10)
    .heightRatioToView(self, 0.8)
    .centerYEqualToView(self);
    //
    textViewBackButt.sd_layout
    .leftEqualToView(self.mySearchView)
    .topEqualToView(self.mySearchView)
    .bottomEqualToView(self.mySearchView)
    .rightEqualToView(self.mySearchView);
    //
    cityBackButt.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self)
    .rightEqualToView(smallImageView);
    
}

- (void)cityButtHandler:(UIButton*)_b{
    NSLog(@"定位城市点击");
    if (self.clickLocationCity){
        self.clickLocationCity(self.locationCityButt);
    }
}

- (void)textViewBackButtHandler:(UIButton*)_b{
    if (self.clickTextViewBlock){
        self.clickTextViewBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
