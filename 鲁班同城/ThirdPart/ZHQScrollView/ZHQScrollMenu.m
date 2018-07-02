//
//  ZHQScrollMenu.m
//  新闻客户端
//
//  Created by zhouqing on 16/4/14.
//  Copyright © 2016年 uplooking. All rights reserved.
//

#import "ZHQScrollMenu.h"

@implementation ZHQScrollMenu
{
    NSMutableArray * buttons;
    UIButton *scrollViewSelectButton;
    
}
@synthesize  lineView;

-(instancetype)initWithFrame:(CGRect)frame delegate:(id<categoryButtonClickDelegate>)delelgate
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.targetDelegate = delelgate;
        //self.backgroundColor = [UIColor grayColor];
        buttons=[[NSMutableArray alloc]init];
        self.showsHorizontalScrollIndicator=NO;
    }
    return self;
}
-(void)addButton:(NSArray*)buttonTitleArr titleFontSize:(CGFloat)size
{
    //btn.backgroundColor = [UIColor grayColor];
    //调整按钮位置
    for(NSInteger i = 0; i <buttonTitleArr.count; i ++){
        UIButton*btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame=CGRectMake(i * self.frame.size.width / buttonTitleArr.count, 0, self.frame.size.width / buttonTitleArr.count, self.bounds.size.height * 0.4);
        btn.center = CGPointMake(btn.center.x, self.bounds.size.height / 2);
        [btn setTitleColor:self.norMalTitleColor forState:UIControlStateNormal];
        [btn setTitle:buttonTitleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:size];
        //btn.backgroundColor = [UIColor grayColor];
        //添加到界面
        [self addSubview:btn];
        [btn addTarget:self action:@selector(buttonHandler:) forControlEvents:UIControlEventTouchUpInside];
        if(i == 0)//第一个按 钮
        {
            [btn setTitleColor:self.changeTitleColor  forState:UIControlStateNormal];
            lineView=[[UIView alloc]initWithFrame:CGRectMake(btn.frame.origin.x, self.height - 5, 20, 4)];
            lineView.center = CGPointMake(btn.centerX, lineView.centerY);
            lineView.backgroundColor=self.lineColor;
            [self addSubview:lineView];
        }
        //保存到数组中
        [buttons addObject:btn];
        if(btn.frame.origin.x+btn.frame.size.width>self.frame.size.width)//内容超出滚动视图范围
        {
            //self.contentSize=CGSizeMake(btn.frame.origin.x+btn.frame.size.width, self.frame.size.height);
        }
    }
}
//修改变化状态
-(void)selected:(UIButton *)btn
{
    for(UIButton * b in buttons)
    {
        //清除文本改为黑色
        [b setTitleColor:self.norMalTitleColor forState:UIControlStateNormal];
    }
    //点亮当前按钮 文本改为红色
    [btn setTitleColor:self.changeTitleColor forState:UIControlStateNormal];
    self.currentSelectedIndex = btn.tag;
    //动画
    [UIView animateWithDuration:0.2 animations:^{
        //把线移动到当前选中按钮下
        lineView.center = CGPointMake(btn.centerX, lineView.centerY);
        
    }];
}
//当走势图弹窗进来不是近期开奖时需要调整显示
- (void)changeDisplayWhenComeIn:(int)buttTag{
    UIButton *butt = buttons[buttTag];
    [self selected:butt];
}



//设置按钮显示内容
- (void)setButtonTitle:(NSString*)title index:(NSInteger)buttonIndex{
    UIButton *button = buttons[buttonIndex];
    [button setTitle:title forState:UIControlStateNormal];
}


- (void)buttonHandler:(UIButton*)_b{
    
    if(self.targetDelegate){//有代理
        if(self.repeatClick == YES){
            UIButton *button = _b;
            [self selected:button];
            [self.targetDelegate categoryButtonHandler:_b.tag];
            scrollViewSelectButton = _b;
        }else{//默认不支持
            if(scrollViewSelectButton!= _b){
                UIButton *button = _b;
                [self selected:button];
                [self.targetDelegate categoryButtonHandler:_b.tag];
                scrollViewSelectButton = _b;
            }
        }
    }else{//不使用代理
        if(self.repeatClick == YES){
            UIButton *button = _b;
            [self selected:button];
            self.clickButtTag(_b.tag);
            scrollViewSelectButton = _b;
        }else{//默认不支持
            if(scrollViewSelectButton!= _b){
                UIButton *button = _b;
                [self selected:button];
                self.clickButtTag(_b.tag);
                scrollViewSelectButton = _b;
            }
        }
    }
}

@end
