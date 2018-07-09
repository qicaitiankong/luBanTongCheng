//
//  FirstPageWaterCollectionReusableHeaderView.m
//  鲁班同城
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "FirstPageWaterCollectionReusableHeaderView.h"


@interface FirstPageWaterCollectionReusableHeaderView (){
    
}
@property (strong, nonatomic) CXCarouselView * lunBoView;

@property (strong,nonatomic) ZHQScrollMenu *scrollButtGroupView;

@property (strong,nonatomic) UIView *spaceLine;

@end

@implementation FirstPageWaterCollectionReusableHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //表头总高度350（ip6下）
        NSLog(@"ReusableHeaderView = %lf",frame.size.height);
        self.backgroundColor = [UIColor whiteColor];
        //244
        self.lunBoView = [CXCarouselView initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , frame.size.height * 0.697) hasTimer:YES interval:3 placeHolder:[UIImage imageNamed:@"test04"]];
        self.lunBoView.delegate = self;
        [self addSubview:self.lunBoView];
        NSArray *array = @[@"scollPicture01",@"scollPicture02",@"scollPicture03"];
        [self.lunBoView setupWithArray:array];
        [self addSubview:self.lunBoView];
        //
        self.searchView = [[FirstPageSearchInputView alloc] init];
        self.searchView.clipsToBounds = YES;
        self.searchView.layer.cornerRadius = 5;
        [self addSubview:self.searchView];
        //
        self.scrollButtGroupView = [[ZHQScrollMenu alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height * 0.142) delegate:self];
        self.scrollButtGroupView.norMalTitleColor = [UIColor colorWithRed:131.998/255.0 green:131.998/255.0 blue:131.998/255.0 alpha:1];
        self.scrollButtGroupView.changeTitleColor = [UIColor colorWithRed:51.0026/255.0 green:51.0026/255.0 blue:51.0026/255.0 alpha:1];
        self.scrollButtGroupView.lineColor = [UIColor colorWithRed:247/255.0 green:125/255.0 blue:30/255.0 alpha:1];
        self.scrollButtGroupView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.scrollButtGroupView];
        [self.scrollButtGroupView addButton:@[@"全部职位",@"只看全部",@"只看零工"] titleFontSize:15];
        //
        self.spaceLine = [[UIView alloc] init];
        self.spaceLine.backgroundColor = [UIColor colorWithHexString:@"#E8E8E8"];
        [self addSubview:self.spaceLine];
        //
        self.traingleButtonGroupView = [[TraingleCategoryButtonGroupView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height * 0.114)];
        [self addSubview:self.traingleButtonGroupView];
    }
    return self;
}

- (void)addConstraints{
    //
    self.lunBoView.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .rightEqualToView(self)
    .heightRatioToView(self, 0.697);
    //
    self.searchView.sd_layout
    .widthIs(SCREEN_WIDTH * 0.933)
    .centerXEqualToView(self)
    .topSpaceToView(self, STATUSBAR_HEIGHT + 5)
    .heightIs(40);
    [self.searchView addConstraints];
    
    self.scrollButtGroupView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(self.lunBoView, 0)
    .heightRatioToView(self, 0.142);
    
    self.spaceLine.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(self.scrollButtGroupView, 1)
    .heightIs(1);
    
    self.traingleButtonGroupView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(self.spaceLine, self.height * 0.025)
    .heightRatioToView(self, 0.114);
}

-(void)carouselTouch:(CXCarouselView *)carousel atIndex:(NSUInteger)index{
    NSLog(@"%@",@(index).stringValue);

}

-(void)categoryButtonHandler:(NSInteger)tag{
    NSLog(@"tag=%ld",tag);
//    if (self.categoeyButtonBlock){
//        self.categoeyButtonBlock(tag);
//    }
}

@end
