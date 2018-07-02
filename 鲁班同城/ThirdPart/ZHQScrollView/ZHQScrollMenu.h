//
//  ZHQScrollMenu.h
//  新闻客户端
//
//  Created by zhouqing on 16/4/14.
//  Copyright © 2016年 uplooking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "appCommonAttributes.h"

@protocol categoryButtonClickDelegate <NSObject>
- (void)categoryButtonHandler:(NSInteger)tag;
@end

@interface ZHQScrollMenu : UIScrollView

-(instancetype)initWithFrame:(CGRect)frame delegate:(id<categoryButtonClickDelegate>)delelgate;

@property (assign,nonatomic) NSInteger currentSelectedIndex;
//添加按钮
-(void)addButton:(NSArray*)buttonTitleArr titleFontSize:(CGFloat)size
;
//设置按钮标题
- (void)setButtonTitle:(NSString*)title index:(NSInteger)buttonIndex;



//当走势图弹窗进来不是近期开奖时需要调整显示
- (void)changeDisplayWhenComeIn:(int)buttTag;

//标题的正常颜色
@property (strong,nonatomic)UIColor *norMalTitleColor;
//标题改变颜色
@property (strong,nonatomic)UIColor *changeTitleColor;
//线的颜色
@property (strong,nonatomic)UIColor *lineColor;
//细线
@property (strong,nonatomic)UIView * lineView;
//点击代理
@property (assign,nonatomic) id<categoryButtonClickDelegate>targetDelegate;
//按钮是否支持重复点击（由于该空间被在不同地方使用，功能也需要动态调节）
@property (assign,nonatomic)BOOL repeatClick;
//有时用到此方法，不使用代理时
@property (copy,nonatomic) void (^clickButtTag)(NSInteger tag);



@end
