//
//  BaseHiddenNaviViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/1.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "BaseHiddenNaviViewController.h"

@interface BaseHiddenNaviViewController ()

@end

@implementation BaseHiddenNaviViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hiddenNavigation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hiddenNavigation];
    // Do any additional setup after loading the view.
}

- (void)hiddenNavigation{
    if (self.navigationController.navigationBarHidden == NO){
        [self.navigationController setNavigationBarHidden:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
