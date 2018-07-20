//
//  CommunicateViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/19.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "CommunicateViewController.h"

@interface CommunicateViewController ()

@end

@implementation CommunicateViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    self.view.backgroundColor = [UIColor whiteColor];
    self.defaultInputType = RCChatSessionInputBarInputExtention;
    //
    [self.chatSessionInputBarControl.pluginBoardView removeItemAtIndex:2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
